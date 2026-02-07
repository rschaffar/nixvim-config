{
  plugins.mini = {
    enable = true;
    modules.indentscope.draw.delay = 0;
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
