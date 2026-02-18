{
  autoCmd = [
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
