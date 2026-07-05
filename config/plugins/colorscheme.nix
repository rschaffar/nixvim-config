{ pkgs, ... }:
{
  # Default colorscheme (change this to set a different default)
  colorschemes.tokyonight = {
    enable = true;
    settings = {
      style = "moon";
      transparent = true;
    };
  };

  # Additional colorscheme plugins (available for runtime switching)
  extraPlugins = with pkgs.vimPlugins; [
    gruvbox-nvim
    catppuccin-nvim
    rose-pine
    kanagawa-nvim
    onedark-nvim
    nightfox-nvim
  ];

  # Theme switcher (Telescope picker with live preview)
  extraConfigLua = ''
    -- Markdown inline strikethrough is provided by Tree-sitter's
    -- @markup.strikethrough capture. Removing that capture requires replacing
    -- the whole markdown_inline query, so just override the markdown-specific
    -- highlight group and keep the parser/query intact.
    local function _disable_markdown_inline_strikethrough()
      local hl = {}
      for _, group in ipairs({ "@markup.strikethrough.markdown_inline", "@markup.strikethrough" }) do
        local ok, existing = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
        if ok and not vim.tbl_isempty(existing) then
          hl = existing
          break
        end
      end

      hl.strikethrough = false
      if type(hl.cterm) == "table" then
        hl.cterm.strikethrough = false
      end
      vim.api.nvim_set_hl(0, "@markup.strikethrough.markdown_inline", hl)
    end

    _disable_markdown_inline_strikethrough()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = _disable_markdown_inline_strikethrough,
    })

    local _theme_switcher_themes = {
      -- Gruvbox
      "gruvbox",
      -- Catppuccin
      "catppuccin",
      "catppuccin-latte",
      "catppuccin-frappe",
      "catppuccin-macchiato",
      "catppuccin-mocha",
      -- Tokyonight
      "tokyonight",
      "tokyonight-night",
      "tokyonight-storm",
      "tokyonight-day",
      "tokyonight-moon",
      -- Rose Pine
      "rose-pine",
      "rose-pine-main",
      "rose-pine-moon",
      "rose-pine-dawn",
      -- Kanagawa
      "kanagawa",
      "kanagawa-wave",
      "kanagawa-dragon",
      "kanagawa-lotus",
      -- OneDark
      "onedark",
      -- Nightfox
      "nightfox",
      "dayfox",
      "dawnfox",
      "duskfox",
      "nordfox",
      "terafox",
      "carbonfox",
    }

    function ThemeSwitcher()
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local previous = vim.g.colors_name or "gruvbox"

      pickers.new({}, {
        prompt_title = "Theme Switcher",
        finder = finders.new_table({ results = _theme_switcher_themes }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(bufnr, map)
          -- Live preview on selection change
          local preview_theme = function()
            local entry = action_state.get_selected_entry()
            if entry then
              pcall(vim.cmd.colorscheme, entry[1])
            end
          end
          map("i", "<C-n>", function()
            actions.move_selection_next(bufnr)
            preview_theme()
          end)
          map("i", "<C-p>", function()
            actions.move_selection_previous(bufnr)
            preview_theme()
          end)
          map("i", "<Down>", function()
            actions.move_selection_next(bufnr)
            preview_theme()
          end)
          map("i", "<Up>", function()
            actions.move_selection_previous(bufnr)
            preview_theme()
          end)
          map("n", "j", function()
            actions.move_selection_next(bufnr)
            preview_theme()
          end)
          map("n", "k", function()
            actions.move_selection_previous(bufnr)
            preview_theme()
          end)

          -- Confirm selection
          actions.select_default:replace(function()
            actions.close(bufnr)
            local entry = action_state.get_selected_entry()
            if entry then
              vim.cmd.colorscheme(entry[1])
            end
          end)

          -- Revert on cancel
          actions.close:enhance({
            post = function()
              if vim.g.colors_name ~= action_state.get_selected_entry()[1] then
                pcall(vim.cmd.colorscheme, previous)
              end
            end,
          })

          return true
        end,
      }):find()
    end
  '';
}
