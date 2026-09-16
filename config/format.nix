{ ... }:
{
  extraConfigLua = ''
    local project_formatter_file = ".nvim-format.json"

    local function formatter_error(message)
      vim.notify("Format: " .. message, vim.log.levels.ERROR)
    end

    local function project_formatter(bufnr)
      local file = vim.api.nvim_buf_get_name(bufnr)
      if file == "" then
        return nil
      end

      local config_path = vim.fs.find(project_formatter_file, {
        path = vim.fs.dirname(file),
        upward = true,
        type = "file",
      })[1]
      if not config_path then
        return nil
      end

      local contents = vim.secure.read(config_path)
      if not contents then
        formatter_error(config_path .. " is not trusted")
        return false
      end

      local decoded, config = pcall(vim.json.decode, contents)
      if not decoded or type(config) ~= "table" then
        formatter_error(config_path .. " is not valid JSON")
        return false
      end
      if config.version ~= 1 or type(config.formatters) ~= "table" then
        formatter_error(config_path .. " must contain version 1 and a formatters object")
        return false
      end

      local formatter = config.formatters[vim.bo[bufnr].filetype]
      if formatter == nil then
        return nil
      end
      if type(formatter) ~= "table" or not vim.islist(formatter.command) or #formatter.command == 0 then
        formatter_error("formatter command must be a non-empty argument array")
        return false
      end

      local root = vim.fs.dirname(config_path)
      local command = {}
      for _, argument in ipairs(formatter.command) do
        if type(argument) ~= "string" then
          formatter_error("formatter command arguments must be strings")
          return false
        end
        local expanded = argument:gsub("{file}", function()
          return file
        end):gsub("{root}", function()
          return root
        end)
        table.insert(command, expanded)
      end

      local timeout_ms = formatter.timeout_ms or 300000
      if type(timeout_ms) ~= "number" or timeout_ms <= 0 then
        formatter_error("formatter timeout_ms must be a positive number")
        return false
      end

      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local input = table.concat(lines, "\n")
      if vim.bo[bufnr].endofline then
        input = input .. "\n"
      end

      local started, process = pcall(vim.system, command, {
        cwd = root,
        stdin = input,
        text = true,
      })
      if not started then
        formatter_error(process)
        return false
      end
      local result = process:wait(timeout_ms)
      if result.code ~= 0 then
        local stderr = result.stderr or ""
        local stdout = result.stdout or ""
        local output = stderr ~= "" and stderr or stdout
        formatter_error(output ~= "" and output or ("command exited with " .. result.code))
        return false
      end

      local output = result.stdout or ""
      if output == input then
        return true
      end
      local has_final_newline = output:sub(-1) == "\n"
      if has_final_newline then
        output = output:sub(1, -2)
      end
      local formatted = output == "" and {} or vim.split(output, "\n", { plain = true })
      local view = vim.fn.winsaveview()
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
      vim.bo[bufnr].endofline = has_final_newline
      vim.fn.winrestview(view)
      return true
    end

    vim.api.nvim_create_user_command("Format", function()
      local handled = project_formatter(0)
      if handled == nil then
        vim.lsp.buf.format()
      end
    end, {})
  '';
}
