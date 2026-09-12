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

  # Herdr forwards its navigation chords into Neovim while a nested terminal
  # is active. Catch them in LazyGit's terminal buffer before they reach the
  # TUI, and delegate back to the optional Herdr navigation integration.
  extraConfigLua = ''
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "lazygit",
      callback = function(event)
        if vim.env.HERDR_ENV ~= "1" then
          return
        end

        local ok, splits = pcall(require, "herdr-splits")
        if not ok then
          return
        end

        local mappings = {
          ["<M-h>"] = splits.move_cursor_left,
          ["<M-j>"] = splits.move_cursor_down,
          ["<M-k>"] = splits.move_cursor_up,
          ["<M-l>"] = splits.move_cursor_right,
        }

        for key, action in pairs(mappings) do
          vim.keymap.set("t", key, action, {
            buffer = event.buf,
            silent = true,
            desc = "Navigate across LazyGit and Herdr panes",
          })
        end
      end,
    })
  '';

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
