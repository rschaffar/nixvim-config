{
  # TODO(rs): Re-enable nvim-ufo once the async.nvim / promise-async conflict is fixed.
  # plugins.nvim-ufo = {
  #   enable = true;
  #
  #   settings = {
  #     provider_selector = ''
  #       function(bufnr, filetype, buftype)
  #         if filetype == "python" then
  #           return { "indent" }
  #         end
  #         return { "lsp", "indent" }
  #       end
  #     '';
  #   };
  # };
}
