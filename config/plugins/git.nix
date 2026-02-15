{
  plugins.fugitive.enable = true;

  plugins.lazygit = {
    enable = true;
    settings = {
      floating_window_scaling_factor = 0.9;
      floating_window_border_chars = [
        "╭"
        "─"
        "╮"
        "│"
        "╯"
        "─"
        "╰"
        "│"
      ];
      floating_window_use_plenary = 0;
      use_neovim_remote = 1;
    };
  };

  plugins.diffview = {
    enable = true;
    settings.keymaps = {
      view = [
        {
          mode = "n";
          key = "q";
          action = "<Cmd>DiffviewClose<CR>";
        }
      ];
      file_panel = [
        {
          mode = "n";
          key = "q";
          action = "<Cmd>DiffviewClose<CR>";
        }
      ];
      file_history_panel = [
        {
          mode = "n";
          key = "q";
          action = "<Cmd>DiffviewClose<CR>";
        }
      ];
    };
  };

  plugins.gitsigns = {
    enable = true;
    settings = {
      current_line_blame = false;
      signcolumn = true;
      watch_gitdir.follow_files = true;
    };
  };
}
