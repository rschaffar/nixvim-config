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
        # Diffview has no native multi-select. Treat visually selected commit
        # rows as one contiguous before/after range.
        {
          mode = "x";
          key = "<CR>";
          action.__raw = ''
            function()
              local lib = require("diffview.lib")
              local view = lib.get_current_view()

              if not view or not view.panel or not view.panel.get_log_entry_at_cursor then
                vim.notify("No Diffview file history is active", vim.log.levels.WARN)
                return
              end

              local first_line = vim.fn.line("v")
              local last_line = vim.fn.line(".")
              if first_line > last_line then
                first_line, last_line = last_line, first_line
              end

              local cursor = vim.api.nvim_win_get_cursor(0)
              local entries = {}
              local seen = {}

              for line = first_line, last_line do
                vim.api.nvim_win_set_cursor(0, { line, 0 })
                local entry = view.panel:get_log_entry_at_cursor()
                local hash = entry and entry.commit and entry.commit.hash

                if hash and not seen[hash] then
                  seen[hash] = true
                  table.insert(entries, entry)
                end
              end

              vim.api.nvim_win_set_cursor(0, cursor)

              if #entries == 0 then
                vim.notify("Select at least one commit row", vim.log.levels.WARN)
                return
              end

              local reverse = view.panel:get_log_options().reverse
              local newest = reverse and entries[#entries] or entries[1]
              local oldest = reverse and entries[1] or entries[#entries]
              local oldest_file = oldest.files[1]
              local newest_file = newest.files[1]

              if not oldest_file or not newest_file then
                vim.notify("Could not resolve the selected commit range", vim.log.levels.ERROR)
                return
              end

              local left = oldest_file.layout.a.file.rev
              local right = newest_file.layout.b.file.rev
              local current_file = view:infer_cur_file()
              local DiffView = require("diffview.scene.views.diff.diff_view").DiffView
              local range_view = DiffView({
                adapter = view.adapter,
                rev_arg = view.adapter:rev_to_pretty_string(left, right),
                left = left,
                right = right,
                options = {
                  selected_file = current_file and current_file.absolute_path or nil,
                },
              })

              lib.add_view(range_view)
              range_view:open()
            end
          '';
          description = "Open selected commit range in Diffview";
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
