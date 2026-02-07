{ pkgs, ... }:
{
  # Tmux Navigator
  plugins.tmux-navigator = {
    enable = true;
    settings = {
      no_mappings = 1;
      disable_when_zoomed = 1;
    };
  };

  # Glow (markdown preview)
  plugins.glow = {
    enable = true;
    settings = {
      style = "dark";
      width = 120;
      border = "rounded";
    };
  };

  # Extra plugins without native nixvim support
  extraPlugins = with pkgs.vimPlugins; [
    nvim-osc52
    vim-gnupg
  ];

  # OSC52 clipboard setup
  extraConfigLua = ''
    -- OSC52 Clipboard (works over SSH/tmux)
    local ok, osc52 = pcall(require, "osc52")
    if ok then
      osc52.setup({
        max_length = 0,
        silent = true,
        trim = false,
        tmux_passthrough = true,
      })

      local clipboard_cache = {
        lines = {},
        regtype = "v",
      }

      local function copy(lines, regtype)
        local text = table.concat(lines, "\n")
        if regtype == "V" then
          text = text .. "\n"
        end
        osc52.copy(text)
        clipboard_cache.lines = lines
        clipboard_cache.regtype = regtype
      end

      local function paste()
        return clipboard_cache.lines, clipboard_cache.regtype
      end

      vim.g.clipboard = {
        name = "osc52",
        copy = {
          ["+"] = copy,
          ["*"] = copy,
        },
        paste = {
          ["+"] = paste,
          ["*"] = paste,
        },
      }
    end
  '';
}
