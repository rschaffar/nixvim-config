{ pkgs, ... }:
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
        "K" = "hover";
        "<leader>rr" = "rename";
      };
    };
  };

  plugins.schemastore = {
    enable = true;
    json.enable = true;
    yaml.enable = false;
  };

  extraPlugins = [ pkgs.vimPlugins.neodev-nvim ];

  extraConfigLua = ''
    require("neodev").setup()
    local border = "rounded"
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
    vim.diagnostic.config({ float = { border = border } })

    vim.api.nvim_create_user_command("Format", function()
      vim.lsp.buf.format()
    end, {})
  '';
}
