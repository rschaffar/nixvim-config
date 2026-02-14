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
      jdtls.enable = true;
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
        # Standard LSP goto bindings
        "gd" = "definition";
        "gD" = "declaration";
        "gi" = "implementation";
        "gr" = "references";
        "K" = "hover";

        # Leader variants (kept as alternatives)
        "<leader>ld" = "definition";
        "<leader>lD" = "declaration";
        "<leader>li" = "implementation";
        "<leader>lt" = "type_definition";
        "<leader>lh" = "hover";
        "<leader>lr" = "references";
        "<leader>rr" = "rename";
      };
      diagnostic."<leader>d" = "open_float";
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
