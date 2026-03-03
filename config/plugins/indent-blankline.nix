{
  plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "│";
      };
      scope = {
        # Disable ibl's scope highlighting — mini.indentscope handles this
        enabled = false;
      };
      exclude = {
        filetypes = [
          "help"
          "alpha"
          "dashboard"
          "neo-tree"
          "Trouble"
          "trouble"
          "lazy"
          "notify"
          "toggleterm"
          "lazyterm"
          ""
        ];
      };
    };
  };
}
