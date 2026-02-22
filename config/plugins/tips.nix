{
  # Tip of the Day - shows a random keybinding or Neovim tip on startup
  extraConfigLua = ''
    local _tips_general = {
      "Use ci\" to change text inside double quotes",
      "Use ci( to change text inside parentheses",
      "Use ca{ to change around curly braces (including the braces)",
      "Use di[ to delete text inside square brackets",
      "Use vi' to visually select text inside single quotes",
      "Use <C-a> / <C-x> to increment / decrement a number under the cursor",
      "Use gv to reselect the last visual selection",
      "Use g; and g, to jump through the changelist (previous/next edit location)",
      "Use <C-o> and <C-i> to jump backward/forward through the jumplist",
      "Use :earlier 5m to undo all changes from the last 5 minutes",
      "Use :later 5m to redo changes undone by :earlier",
      "Use zz / zt / zb to center / top / bottom the current line on screen",
      "Use * and # to search forward/backward for the word under the cursor",
      "Use gd to go to the local definition of the word under the cursor",
      "Use gf to open the file path under the cursor",
      "Use qa to start recording macro into register a, then q to stop, @a to replay",
      "Use @@ to replay the last executed macro",
      "Use \". to access the last inserted text register",
      "Use \"+ to access the system clipboard register",
      "Use :%s/old/new/gc to search and replace with confirmation across the file",
      "Use :g/pattern/d to delete all lines matching a pattern",
      "Use :v/pattern/d to delete all lines NOT matching a pattern",
      "Use J to join the current line with the next one",
      "Use gJ to join lines without adding a space",
      "Use = in visual mode to auto-indent selected lines",
      "Use <C-w>= to equalize all split window sizes",
      "Use :set spell to enable spellcheck, ]s / [s to jump between misspellings",
      "Use z= on a misspelled word to see spelling suggestions",
      "Use . to repeat the last change — works with most editing commands",
      "Use xp to transpose two characters (delete + paste)",
      "Use daw to delete a word including surrounding whitespace",
      "Use diw to delete a word without surrounding whitespace",
      "Use CTRL-r \" in insert mode to paste from the default register",
      "Use CTRL-r = in insert mode to insert the result of an expression",
      "Use gu / gU with a motion to lowercase / uppercase text (e.g., gUiw)",
      "Use ~ to toggle case of the character under the cursor",
      "Use :bufdo to execute a command in all open buffers",
      "Use q: to open the command-line window with your command history",
      "Use :noh (or your <leader>/ mapping) to clear search highlighting",
    }

    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Show a random tip of the day",
      once = true,
      callback = function()
        vim.defer_fn(function()
          -- Collect keybinding tips from all normal-mode keymaps with descriptions
          local keybind_tips = {}
          for _, km in ipairs(vim.api.nvim_get_keymap("n")) do
            if km.desc and km.desc ~= "" then
              local lhs = km.lhs:gsub(" ", "<leader>")
              table.insert(keybind_tips, "Keybind:  " .. lhs .. "  →  " .. km.desc)
            end
          end

          -- Combine both pools
          local all_tips = {}
          for _, t in ipairs(_tips_general) do
            table.insert(all_tips, t)
          end
          for _, t in ipairs(keybind_tips) do
            table.insert(all_tips, t)
          end

          if #all_tips > 0 then
            math.randomseed(os.time())
            local tip = all_tips[math.random(#all_tips)]
            vim.notify(tip, vim.log.levels.INFO, { title = "Tip of the Day" })
          end
        end, 500)
      end,
    })
  '';
}
