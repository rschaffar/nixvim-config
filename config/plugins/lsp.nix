{
  pkgs,
  lib,
  light ? false,
  ...
}:
{
  plugins.lsp = {
    enable = true;

    servers = {
      lua_ls = {
        enable = true;
        settings.Lua = {
          diagnostics.globals = [ "vim" ];
          workspace.checkThirdParty = false;
          telemetry.enable = false;
        };
      };
    }
    // lib.optionalAttrs (!light) {
      nixd = {
        enable = true;
        settings.nixd = {
          nixpkgs.expr = "import <nixpkgs> { }";
          formatting.command = [ "nixfmt" ];
        };
      };

      bashls.enable = true;
      jsonls.enable = true;
      ts_ls = {
        enable = true;
        settings = {
          typescript.inlayHints = {
            includeInlayParameterNameHints = "all";
            includeInlayParameterNameHintsWhenArgumentMatchesName = false;
            includeInlayFunctionParameterTypeHints = true;
            includeInlayVariableTypeHints = true;
            includeInlayVariableTypeHintsWhenTypeMatchesName = false;
            includeInlayPropertyDeclarationTypeHints = true;
            includeInlayFunctionLikeReturnTypeHints = true;
            includeInlayEnumMemberValueHints = true;
          };
          javascript.inlayHints = {
            includeInlayParameterNameHints = "all";
            includeInlayParameterNameHintsWhenArgumentMatchesName = false;
            includeInlayFunctionParameterTypeHints = true;
            includeInlayVariableTypeHints = true;
            includeInlayVariableTypeHintsWhenTypeMatchesName = false;
            includeInlayPropertyDeclarationTypeHints = true;
            includeInlayFunctionLikeReturnTypeHints = true;
            includeInlayEnumMemberValueHints = true;
          };
        };
      };
      eslint.enable = true;

      clangd = {
        enable = true;
        cmd = [
          "clangd"
          "--background-index"
          "--clang-tidy"
        ];
      };

      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
        settings.rust-analyzer = {
          cargo.buildScripts.enable = true;
          procMacro.enable = true;
        };
      };

      texlab.enable = true;
      metals.enable = true;

      basedpyright = {
        enable = true;
        settings.basedpyright = {
          typeCheckingMode = "basic";
          analysis = {
            autoImportCompletions = true;
            autoSearchPaths = true;
            diagnosticMode = "workspace";
            useLibraryCodeForTypes = true;
          };
        };
      };

      ruff.enable = true;
    };

    keymaps = {
      lspBuf = {
        "gD" = "declaration";
        "<leader>rr" = "rename";
      };
    };
  };

  plugins.schemastore = {
    enable = !light;
    json.enable = !light;
    yaml.enable = false;
  };

  extraPlugins = [ pkgs.vimPlugins.neodev-nvim ];

  extraConfigLua = ''
    require("neodev").setup()
    local border = "rounded"
    vim.diagnostic.config({ float = { border = border } })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspBorderMappings", { clear = true }),
      callback = function(args)
        local opts = { buffer = args.buf, silent = true }

        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover({ border = border })
        end, vim.tbl_extend("force", opts, { desc = "LSP hover" }))

        vim.keymap.set("i", "<C-s>", function()
          vim.lsp.buf.signature_help({ border = border })
        end, vim.tbl_extend("force", opts, { desc = "LSP signature help" }))
      end,
    })

    vim.api.nvim_create_user_command("Format", function()
      vim.lsp.buf.format()
    end, {})

    vim.keymap.set("n", "<C-M-j>", function()
      local file = vim.api.nvim_buf_get_name(0)
      vim.cmd("write")
      local result = vim.system({ "my-java-format", file }, { text = true }):wait()
      if result.code ~= 0 then
        vim.notify(result.stderr ~= "" and result.stderr or result.stdout, vim.log.levels.ERROR)
        return
      end
      vim.cmd("checktime")
    end, { desc = "Format Java with my-java-format" })
  '';
}
