{
  autoCmd = [
  ];

  # Custom user commands
  extraConfigLua = ''
    vim.api.nvim_create_user_command("BufOnly", function(opts)
      local current = vim.api.nvim_get_current_buf()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and (vim.api.nvim_buf_is_loaded(buf) or vim.bo[buf].buflisted) then
          vim.api.nvim_buf_delete(buf, { force = opts.bang })
        end
      end
    end, { bang = true, desc = "Close all buffers but the current one" })

    vim.api.nvim_create_user_command("DiffClipboard", function()
      local source_win = vim.api.nvim_get_current_win()
      local source_buf = vim.api.nvim_get_current_buf()
      local lines = vim.fn.getreg("+", 1, true)

      if type(lines) == "string" then
        lines = vim.split(lines, "\n", { plain = true })
      end

      if #lines == 0 or (#lines == 1 and lines[1] == "") then
        vim.notify("System clipboard is empty", vim.log.levels.WARN)
        return
      end

      vim.cmd("rightbelow vertical new")
      local clipboard_buf = vim.api.nvim_get_current_buf()

      vim.bo[clipboard_buf].buftype = "nofile"
      vim.bo[clipboard_buf].bufhidden = "wipe"
      vim.bo[clipboard_buf].swapfile = false
      vim.bo[clipboard_buf].buflisted = false
      vim.bo[clipboard_buf].filetype = vim.bo[source_buf].filetype
      vim.api.nvim_buf_set_name(clipboard_buf, "clipboard://+/" .. clipboard_buf)
      vim.api.nvim_buf_set_lines(clipboard_buf, 0, -1, false, lines)
      vim.bo[clipboard_buf].modified = false
      vim.bo[clipboard_buf].modifiable = false
      vim.bo[clipboard_buf].readonly = true

      vim.cmd("diffthis")
      vim.api.nvim_set_current_win(source_win)
      vim.cmd("diffthis")
      vim.api.nvim_set_current_win(source_win)
    end, { desc = "Diff current buffer against system clipboard" })
  '';
}
