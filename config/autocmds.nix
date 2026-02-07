{
  autoCmd = [
    # Auto-format Lua files with stylua on save
    {
      event = "BufWritePost";
      pattern = "*.lua";
      callback.__raw = ''
        function()
          local path = vim.api.nvim_buf_get_name(0)
          local out = vim.fn.system({ "stylua", path })
          if vim.v.shell_error ~= 0 then
            vim.notify("stylua failed: " .. out, vim.log.levels.ERROR)
            return
          end
          local view = vim.fn.winsaveview()
          vim.cmd("checktime")
          vim.fn.winrestview(view)
        end
      '';
    }
  ];

  # BufOnly command
  extraConfigLua = ''
    vim.api.nvim_create_user_command("BufOnly", function(opts)
      local current = vim.api.nvim_get_current_buf()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and (vim.api.nvim_buf_is_loaded(buf) or vim.bo[buf].buflisted) then
          vim.api.nvim_buf_delete(buf, { force = opts.bang })
        end
      end
    end, { bang = true, desc = "Close all buffers but the current one" })
  '';
}
