{
  plugins = {
    noice = {
      enable = true;
      settings = {
        cmdline.enabled = true;
        messages.enabled = true;
        popupmenu.enabled = true;

        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
          progress.enabled = true;
        };

        presets = {
          bottom_search = false;
          command_palette = true;
          long_message_to_split = true;
          lsp_doc_border = true;
        };
      };
    };

    notify = {
      enable = true;
      settings = {
        background_colour = "#000000";
      };
    };
  };
}
