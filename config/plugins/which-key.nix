{
  plugins.which-key = {
    enable = true;
    settings = {
      plugins.spelling.enabled = true;
      win.border = "single";
      spec = [
        {
          __unkeyed-1 = "<leader>a";
          group = "AI";
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "Find";
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "Git";
        }
        {
          __unkeyed-1 = "<leader>r";
          group = "Refactor";
          mode = [
            "n"
            "x"
          ];
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "Search/Replace";
        }
        {
          __unkeyed-1 = "<leader>e";
          group = "Explorer";
        }
        {
          __unkeyed-1 = "<leader>l";
          group = "LSP";
        }
        {
          __unkeyed-1 = "<leader>lg";
          group = "Glance";
        }
        {
          __unkeyed-1 = "<leader>m";
          group = "Markdown";
        }
        {
          __unkeyed-1 = "<leader>t";
          group = "Debug";
        }
        {
          __unkeyed-1 = "<leader>h";
          group = "Harpoon";
        }
        {
          __unkeyed-1 = "<leader>y";
          group = "Yank";
        }
      ];
    };
  };
}
