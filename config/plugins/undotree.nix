{
  plugins.undotree = {
    enable = true;
    settings = {
      WindowLayout = 2;
      ShortIndicators = 1;
      SetFocusWhenToggle = 1;
    };
  };

  # Ensure undo persists across sessions
  opts.undofile = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>u";
      action = "<cmd>UndotreeToggle<CR>";
      options = {
        desc = "Toggle Undotree";
      };
    }
  ];
}
