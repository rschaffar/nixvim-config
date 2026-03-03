{
  plugins.treesitter-textobjects = {
    enable = true;
    settings = {
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";
          "ai" = "@conditional.outer";
          "ii" = "@conditional.inner";
          "al" = "@loop.outer";
          "il" = "@loop.inner";
          "ab" = "@block.outer";
          "ib" = "@block.inner";
        };
      };

      move = {
        enable = true;
        set_jumps = true;
        goto_next_start = {
          "]m" = "@function.outer";
          "]]" = "@class.outer";
          "]a" = "@parameter.inner";
        };
        goto_next_end = {
          "]M" = "@function.outer";
          "][" = "@class.outer";
        };
        goto_previous_start = {
          "[m" = "@function.outer";
          "[[" = "@class.outer";
          "[a" = "@parameter.inner";
        };
        goto_previous_end = {
          "[M" = "@function.outer";
          "[]" = "@class.outer";
        };
      };

      swap = {
        enable = true;
        swap_next = {
          "<leader>sa" = "@parameter.inner";
        };
        swap_previous = {
          "<leader>sA" = "@parameter.inner";
        };
      };
    };
  };

  # Make TS textobject moves repeatable with ; and ,
  extraConfigLua = ''
    local ok, ts_repeat_move = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
    if ok then
      vim.keymap.set({"n", "x", "o"}, ";", ts_repeat_move.repeat_last_move_next, { desc = "Repeat last TS move next" })
      vim.keymap.set({"n", "x", "o"}, ",", ts_repeat_move.repeat_last_move_previous, { desc = "Repeat last TS move prev" })
    end
  '';
}
