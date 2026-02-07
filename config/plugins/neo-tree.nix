{
  plugins.neo-tree = {
    enable = true;

    settings = {
      popup_border_style = "rounded";

      default_component_configs = {
        container.enable_character_fade = true;
        indent = {
          indent_size = 2;
          padding = 1;
          with_markers = true;
          indent_marker = "│";
          last_indent_marker = "└";
          expander_collapsed = "";
          expander_expanded = "";
        };
        icon = {
          folder_closed = "";
          folder_open = "";
          folder_empty = "ﰊ";
          default = "*";
        };
        modified.symbol = "[+]";
        name = {
          trailing_slash = false;
          use_git_status_colors = true;
        };
        git_status.symbols = {
          added = "";
          modified = "";
          deleted = "✖";
          renamed = "";
          untracked = "";
          ignored = "";
          unstaged = "";
          staged = "";
          conflict = "";
        };
      };

      window = {
        position = "left";
        width = 40;
        mapping_options = {
          noremap = true;
          nowait = true;
        };
        mappings = {
          "<space>" = {
            command = "toggle_node";
            nowait = false;
          };
          "<2-LeftMouse>" = "open";
          "<cr>" = "open";
          "<esc>" = "revert_preview";
          "P" = {
            command = "toggle_preview";
            config.use_float = true;
          };
          "l" = "focus_preview";
          "S" = "open_split";
          "s" = "open_vsplit";
          "t" = "open_tabnew";
          "w" = "open_with_window_picker";
          "C" = "close_node";
          "z" = "close_all_nodes";
          "Z" = "expand_all_nodes";
          "a" = {
            command = "add";
            config.show_path = "none";
          };
          "A" = "add_directory";
          "d" = "delete";
          "r" = "rename";
          "y" = "copy_to_clipboard";
          "x" = "cut_to_clipboard";
          "p" = "paste_from_clipboard";
          "c" = "copy";
          "m" = "move";
          "q" = "close_window";
          "R" = "refresh";
          "?" = "show_help";
          "<" = "prev_source";
          ">" = "next_source";
        };
      };

      filesystem = {
        filtered_items = {
          hide_dotfiles = true;
          hide_gitignored = true;
          hide_hidden = true;
          hide_by_name = [
            ".DS_Store"
            "thumbs.db"
          ];
          hide_by_pattern = [
            "*.meta"
            "*/src/*/tsconfig.json"
          ];
          always_show = [ ".gitignored" ];
          never_show = [
            ".DS_Store"
            "thumbs.db"
          ];
          never_show_by_pattern = [ ".null-ls_*" ];
        };
        follow_current_file.enabled = false;
        hijack_netrw_behavior = "disabled";
        window.mappings = {
          "<bs>" = "navigate_up";
          "." = "set_root";
          "H" = "toggle_hidden";
          "/" = "fuzzy_finder";
          "D" = "fuzzy_finder_directory";
          "#" = "fuzzy_sorter";
          "f" = "filter_on_submit";
          "<c-x>" = "clear_filter";
          "[g" = "prev_git_modified";
          "]g" = "next_git_modified";
        };
      };

      buffers = {
        follow_current_file.enabled = true;
        group_empty_dirs = true;
        show_unloaded = true;
        window.mappings = {
          "bd" = "buffer_delete";
          "<bs>" = "navigate_up";
          "." = "set_root";
        };
      };

      git_status.window = {
        position = "float";
        mappings = {
          "A" = "git_add_all";
          "gu" = "git_unstage_file";
          "ga" = "git_add_file";
          "gr" = "git_revert_file";
          "gc" = "git_commit";
          "gp" = "git_push";
          "gg" = "git_commit_and_push";
        };
      };
    };
  };
}
