{
  keymaps = [
    # === TELESCOPE (Find) ===
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      options = {
        desc = "Find Files";
      };
    }
    {
      mode = "n";
      key = "<leader>fa";
      action = "<cmd>Telescope find_files hidden=true<CR>";
      options = {
        desc = "Find All Files (incl. hidden)";
      };
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
      options = {
        desc = "Live Grep";
      };
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<CR>";
      options = {
        desc = "Find Buffers";
      };
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<CR>";
      options = {
        desc = "Find Help";
      };
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>Telescope oldfiles<CR>";
      options = {
        desc = "Recent Files";
      };
    }
    {
      mode = "n";
      key = "<leader>fc";
      action = "<cmd>Telescope commands<CR>";
      options = {
        desc = "Commands";
      };
    }
    {
      mode = "n";
      key = "<leader>fk";
      action = "<cmd>Telescope keymaps<CR>";
      options = {
        desc = "Keymaps";
      };
    }

    # === SPECTRE (Search/Replace) ===
    {
      mode = "n";
      key = "<leader>sr";
      action = "<cmd>lua require('spectre').toggle()<CR>";
      options = {
        desc = "Toggle Spectre";
      };
    }
    {
      mode = "n";
      key = "<leader>sw";
      action = "<cmd>lua require('spectre').open_visual({select_word=true})<CR>";
      options = {
        desc = "Search current word";
      };
    }
    {
      mode = "v";
      key = "<leader>sw";
      action = "<cmd>lua require('spectre').open_visual()<CR>";
      options = {
        desc = "Search selection";
      };
    }
    {
      mode = "n";
      key = "<leader>sp";
      action = "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>";
      options = {
        desc = "Search in current file";
      };
    }

    # === HARPOON (v2 API) ===
    {
      mode = "n";
      key = "<leader>ha";
      action.__raw = "function() require('harpoon'):list():add() end";
      options = {
        desc = "Harpoon add file";
      };
    }
    {
      mode = "n";
      key = "<leader>hh";
      action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
      options = {
        desc = "Harpoon menu";
      };
    }
    {
      mode = "n";
      key = "<leader>h1";
      action.__raw = "function() require('harpoon'):list():select(1) end";
      options = {
        desc = "Harpoon file 1";
      };
    }
    {
      mode = "n";
      key = "<leader>h2";
      action.__raw = "function() require('harpoon'):list():select(2) end";
      options = {
        desc = "Harpoon file 2";
      };
    }
    {
      mode = "n";
      key = "<leader>h3";
      action.__raw = "function() require('harpoon'):list():select(3) end";
      options = {
        desc = "Harpoon file 3";
      };
    }
    {
      mode = "n";
      key = "<leader>h4";
      action.__raw = "function() require('harpoon'):list():select(4) end";
      options = {
        desc = "Harpoon file 4";
      };
    }
    {
      mode = "n";
      key = "<leader>hn";
      action.__raw = "function() require('harpoon'):list():next() end";
      options = {
        desc = "Harpoon next";
      };
    }
    {
      mode = "n";
      key = "<leader>hp";
      action.__raw = "function() require('harpoon'):list():prev() end";
      options = {
        desc = "Harpoon prev";
      };
    }

    # === GIT ===
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>LazyGit<CR>";
      options = {
        desc = "Open LazyGit";
      };
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = "<cmd>Git<CR>";
      options = {
        desc = "Git status";
      };
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>Git blame<CR>";
      options = {
        desc = "Git blame";
      };
    }
    {
      mode = "n";
      key = "<leader>gd";
      action = "<cmd>Git diff<CR>";
      options = {
        desc = "Git diff";
      };
    }
    {
      mode = "n";
      key = "<leader>gc";
      action = "<cmd>Git commit<CR>";
      options = {
        desc = "Git commit";
      };
    }
    {
      mode = "n";
      key = "<leader>gp";
      action = "<cmd>Git push<CR>";
      options = {
        desc = "Git push";
      };
    }
    {
      mode = "n";
      key = "<leader>gl";
      action = "<cmd>Git log<CR>";
      options = {
        desc = "Git log";
      };
    }
    {
      mode = "n";
      key = "]h";
      action = "<cmd>Gitsigns next_hunk<CR>";
      options = {
        desc = "Next git hunk";
      };
    }
    {
      mode = "n";
      key = "[h";
      action = "<cmd>Gitsigns prev_hunk<CR>";
      options = {
        desc = "Prev git hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>ga";
      action = "<cmd>Gitsigns stage_hunk<CR>";
      options = {
        desc = "Git stage hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>gr";
      action = "<cmd>Gitsigns reset_hunk<CR>";
      options = {
        desc = "Git reset hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>gu";
      action = "<cmd>Gitsigns preview_hunk<CR>";
      options = {
        desc = "Git preview hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>gB";
      action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
      options = {
        desc = "Git toggle line blame";
      };
    }

    # Diffview
    {
      mode = "n";
      key = "<leader>gD";
      action = "<cmd>DiffviewOpen<CR>";
      options = {
        desc = "Diffview open";
      };
    }
    {
      mode = "n";
      key = "<leader>gh";
      action = "<cmd>DiffviewFileHistory %<CR>";
      options = {
        desc = "Diffview file history";
      };
    }
    {
      mode = "x";
      key = "<leader>gh";
      action = ":'<,'>DiffviewFileHistory<CR>";
      options = {
        desc = "Diffview line history";
      };
    }
    {
      mode = "n";
      key = "<leader>gH";
      action = "<cmd>DiffviewFileHistory<CR>";
      options = {
        desc = "Diffview history";
      };
    }
    {
      mode = "n";
      key = "<leader>gT";
      action = "<cmd>DiffviewToggleFiles<CR>";
      options = {
        desc = "Diffview toggle files";
      };
    }
    {
      mode = "n";
      key = "<leader>gF";
      action = "<cmd>DiffviewFocusFiles<CR>";
      options = {
        desc = "Diffview focus files";
      };
    }
    {
      mode = "n";
      key = "<leader>gR";
      action = "<cmd>DiffviewRefresh<CR>";
      options = {
        desc = "Diffview refresh";
      };
    }
    {
      mode = "n";
      key = "<leader>gP";
      action = "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>";
      options = {
        desc = "Diffview PR diff";
      };
    }
    {
      mode = "n";
      key = "<leader>gL";
      action = "<cmd>DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges<CR>";
      options = {
        desc = "Diffview PR commits";
      };
    }

    # === NEO-TREE (Explorer) ===
    {
      mode = "n";
      key = "<leader>et";
      action = "<cmd>Neotree toggle<CR>";
      options = {
        desc = "Toggle Neo-tree";
      };
    }
    {
      mode = "n";
      key = "<leader>ef";
      action = "<cmd>Neotree reveal<CR>";
      options = {
        desc = "Reveal current file";
      };
    }
    {
      mode = "n";
      key = "<leader>eo";
      action = "<cmd>Neotree focus<CR>";
      options = {
        desc = "Focus Neo-tree";
      };
    }

    # === GENERAL ===
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>w<CR>";
      options = {
        desc = "Save File";
      };
    }
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>q<CR>";
      options = {
        desc = "Quit";
      };
    }
    {
      mode = "n";
      key = "<leader>ac";
      action = "<cmd>CopilotToggle<CR>";
      options = {
        desc = "Toggle Copilot";
      };
    }
    {
      mode = "n";
      key = "<leader>/";
      action = "<cmd>nohlsearch<CR>";
      options = {
        desc = "Clear search highlight";
      };
    }
    {
      mode = "n";
      key = "<leader>n";
      action = "<cmd>set relativenumber!<CR>";
      options = {
        desc = "Toggle relative line numbers";
      };
    }
    {
      mode = "n";
      key = "<C-A-l>";
      action = "<cmd>Format<CR>";
      options = {
        desc = "Format code";
      };
    }

    # === YANK PATHS ===
    {
      mode = "n";
      key = "<leader>yp";
      action.__raw = "function() vim.fn.setreg('+', vim.fn.expand('%')) end";
      options = {
        desc = "Yank relative path";
      };
    }
    {
      mode = "n";
      key = "<leader>yP";
      action.__raw = "function() vim.fn.setreg('+', vim.fn.expand('%:p')) end";
      options = {
        desc = "Yank absolute path";
      };
    }
    {
      mode = "n";
      key = "<leader>yl";
      action.__raw = "function() vim.fn.setreg('+', vim.fn.expand('%') .. ':' .. vim.fn.line('.')) end";
      options = {
        desc = "Yank path with line";
      };
    }

    # === MARKDOWN ===
    {
      mode = "n";
      key = "<leader>mg";
      action = "<cmd>Glow<CR>";
      options = {
        desc = "Preview Markdown";
      };
    }
    {
      mode = "n";
      key = "<leader>mr";
      action = "<cmd>RenderMarkdown buf_toggle<CR>";
      options = {
        desc = "Toggle Markdown render";
      };
    }
    {
      mode = "n";
      key = "<leader>mp";
      action = "<cmd>RenderMarkdown preview<CR>";
      options = {
        desc = "Markdown side preview";
      };
    }

    # === TTS (Text-to-Speech) ===
    {
      mode = "v";
      key = "<leader>as";
      action.__raw = ''
        function()
          vim.cmd('normal! "zy')
          local text = vim.fn.getreg('z')
          if text == "" then
            vim.notify("No text selected", vim.log.levels.WARN)
            return
          end
          vim.notify("Speaking selection...", vim.log.levels.INFO)
          vim.system({'kokoro-say', text}, {detach = true})
        end
      '';
      options = {
        desc = "Speak selection (TTS)";
      };
    }

    # === EXPAND REGION ===
    {
      mode = [
        "n"
        "v"
      ];
      key = "+";
      action = "<Plug>(expand_region_expand)";
      options = {
        desc = "Expand region";
        remap = true;
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "_";
      action = "<Plug>(expand_region_shrink)";
      options = {
        desc = "Shrink region";
        remap = true;
      };
    }

    # === DIAGNOSTICS ===
    {
      mode = "n";
      key = "]w";
      action.__raw = "function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end";
      options = {
        desc = "Next warning";
      };
    }
    {
      mode = "n";
      key = "[w";
      action.__raw = "function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end";
      options = {
        desc = "Prev warning";
      };
    }
    {
      mode = "n";
      key = "]e";
      action.__raw = "function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end";
      options = {
        desc = "Next error";
      };
    }
    {
      mode = "n";
      key = "[e";
      action.__raw = "function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end";
      options = {
        desc = "Prev error";
      };
    }

    # === TROUBLE ===
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<CR>";
      options = {
        desc = "Trouble diagnostics";
      };
    }
    {
      mode = "n";
      key = "<leader>xb";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
      options = {
        desc = "Trouble buffer diagnostics";
      };
    }
    {
      mode = "n";
      key = "<leader>xs";
      action = "<cmd>Trouble symbols toggle focus=false<CR>";
      options = {
        desc = "Trouble document symbols";
      };
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = "<cmd>Trouble qflist toggle<CR>";
      options = {
        desc = "Trouble quickfix";
      };
    }
    {
      mode = "n";
      key = "<leader>xl";
      action = "<cmd>Trouble loclist toggle<CR>";
      options = {
        desc = "Trouble location list";
      };
    }

    # === DEBUG (DAP) ===
    {
      mode = "n";
      key = "<leader>tc";
      action = "<cmd>lua require('dap').continue()<CR>";
      options = {
        desc = "Debug: Continue";
      };
    }
    {
      mode = "n";
      key = "<leader>to";
      action = "<cmd>lua require('dap').step_over()<CR>";
      options = {
        desc = "Debug: Step over";
      };
    }
    {
      mode = "n";
      key = "<leader>ti";
      action = "<cmd>lua require('dap').step_into()<CR>";
      options = {
        desc = "Debug: Step into";
      };
    }
    {
      mode = "n";
      key = "<leader>tO";
      action = "<cmd>lua require('dap').step_out()<CR>";
      options = {
        desc = "Debug: Step out";
      };
    }
    {
      mode = "n";
      key = "<leader>tb";
      action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
      options = {
        desc = "Debug: Toggle breakpoint";
      };
    }
    {
      mode = "n";
      key = "<leader>tB";
      action.__raw = "function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end";
      options = {
        desc = "Debug: Conditional breakpoint";
      };
    }
    {
      mode = "n";
      key = "<leader>tl";
      action = "<cmd>lua require('dap').run_last()<CR>";
      options = {
        desc = "Debug: Run last";
      };
    }
    {
      mode = "n";
      key = "<leader>tr";
      action = "<cmd>lua require('dap').repl.open()<CR>";
      options = {
        desc = "Debug: REPL";
      };
    }
    {
      mode = "n";
      key = "<leader>tq";
      action = "<cmd>lua require('dap').terminate()<CR>";
      options = {
        desc = "Debug: Terminate";
      };
    }
    {
      mode = "n";
      key = "<leader>tu";
      action = "<cmd>lua require('dapui').toggle()<CR>";
      options = {
        desc = "Debug: Toggle UI";
      };
    }

    # === SPLITS ===
    {
      mode = "n";
      key = "<C-w>\"";
      action = "<cmd>split<CR>";
      options = {
        desc = "Horizontal split";
      };
    }
    {
      mode = "n";
      key = "<C-w>%";
      action = "<cmd>vsplit<CR>";
      options = {
        desc = "Vertical split";
      };
    }

    # === BETTER INDENTING ===
    {
      mode = "v";
      key = "<";
      action = "<gv";
      options = {
        desc = "Indent left";
      };
    }
    {
      mode = "v";
      key = ">";
      action = ">gv";
      options = {
        desc = "Indent right";
      };
    }

    # === MOVE TEXT ===
    {
      mode = "v";
      key = "<A-j>";
      action = ":m '>+1<CR>gv=gv";
      options = {
        desc = "Move text down";
      };
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":m '<-2<CR>gv=gv";
      options = {
        desc = "Move text up";
      };
    }

    # === SCROLLING ===
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
      options = {
        desc = "Scroll down and center";
      };
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
      options = {
        desc = "Scroll up and center";
      };
    }

    # === UFO FOLDING ===
    {
      mode = "n";
      key = "zR";
      action = "<cmd>lua require('ufo').openAllFolds()<CR>";
      options = {
        desc = "Open all folds";
      };
    }
    {
      mode = "n";
      key = "zM";
      action = "<cmd>lua require('ufo').closeAllFolds()<CR>";
      options = {
        desc = "Close all folds";
      };
    }

    # === GLANCE ===
    {
      mode = "n";
      key = "<leader>lgd";
      action = "<cmd>Glance definitions<CR>";
      options = {
        desc = "Glance definitions";
      };
    }
    {
      mode = "n";
      key = "<leader>lgr";
      action = "<cmd>Glance references<CR>";
      options = {
        desc = "Glance references";
      };
    }
    {
      mode = "n";
      key = "<leader>lgt";
      action = "<cmd>Glance type_definitions<CR>";
      options = {
        desc = "Glance type definitions";
      };
    }
    {
      mode = "n";
      key = "<leader>lgi";
      action = "<cmd>Glance implementations<CR>";
      options = {
        desc = "Glance implementations";
      };
    }

    # === REFACTORING ===
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>rt";
      action = "<cmd>Telescope refactoring refactors<CR>";
      options = {
        desc = "Select refactor";
      };
    }
    {
      mode = "x";
      key = "<leader>re";
      action = ":Refactor extract ";
      options = {
        desc = "Extract function";
      };
    }
    {
      mode = "x";
      key = "<leader>rf";
      action = ":Refactor extract_to_file ";
      options = {
        desc = "Extract to file";
      };
    }
    {
      mode = "x";
      key = "<leader>rv";
      action = ":Refactor extract_var ";
      options = {
        desc = "Extract variable";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>ri";
      action = "<cmd>Refactor inline_var<CR>";
      options = {
        desc = "Inline variable";
      };
    }
    {
      mode = "n";
      key = "<leader>rI";
      action = "<cmd>Refactor inline_func<CR>";
      options = {
        desc = "Inline function";
      };
    }
    {
      mode = "n";
      key = "<leader>rb";
      action = ":Refactor extract_block ";
      options = {
        desc = "Extract block";
      };
    }
    {
      mode = "n";
      key = "<leader>rB";
      action = ":Refactor extract_block_to_file ";
      options = {
        desc = "Extract block to file";
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>rp";
      action = "<cmd>lua require('refactoring').debug.print_var()<CR>";
      options = {
        desc = "Debug: print variable";
      };
    }
    {
      mode = "n";
      key = "<leader>rP";
      action = "<cmd>lua require('refactoring').debug.printf({below=false})<CR>";
      options = {
        desc = "Debug: printf";
      };
    }
    {
      mode = "n";
      key = "<leader>rc";
      action = "<cmd>lua require('refactoring').debug.cleanup({})<CR>";
      options = {
        desc = "Debug: cleanup prints";
      };
    }

    # === LSP SYMBOLS (Telescope) ===
    {
      mode = "n";
      key = "<leader>ls";
      action = "<cmd>Telescope lsp_document_symbols<CR>";
      options = {
        desc = "Document symbols";
      };
    }
    {
      mode = "n";
      key = "<leader>lS";
      action = "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>";
      options = {
        desc = "Workspace symbols";
      };
    }

    # === TMUX NAVIGATOR ===
    {
      mode = "n";
      key = "<M-h>";
      action = "<cmd>TmuxNavigateLeft<CR>";
      options = {
        desc = "Navigate left";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<M-j>";
      action = "<cmd>TmuxNavigateDown<CR>";
      options = {
        desc = "Navigate down";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<M-k>";
      action = "<cmd>TmuxNavigateUp<CR>";
      options = {
        desc = "Navigate up";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<M-l>";
      action = "<cmd>TmuxNavigateRight<CR>";
      options = {
        desc = "Navigate right";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<M-\\>";
      action = "<cmd>TmuxNavigatePrevious<CR>";
      options = {
        desc = "Navigate previous";
        silent = true;
      };
    }
  ];
}
