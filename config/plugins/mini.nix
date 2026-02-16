{
  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      indentscope.draw.delay = 0;
      surround = { };
      pairs = { };
      icons = { };
    };
  };

  autoCmd = [
    {
      event = "FileType";
      pattern = [
        "help"
        "alpha"
        "neo-tree"
        "gitcommit"
        "TelescopePrompt"
        "TelescopeResults"
        "NvimTree"
      ];
      callback.__raw = "function() vim.b.miniindentscope_disable = true end";
    }
  ];
}
