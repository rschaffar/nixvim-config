{
  plugins.cmp = {
    enable = true;

    settings = {
      snippet.expand = ''
        function(args)
          require('luasnip').lsp_expand(args.body)
        end
      '';

      experimental.ghost_text = true;

      mapping = {
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<C-p>" = "cmp.mapping.select_prev_item()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-x><C-o>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<Tab>" = ''
          cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            if cmp.visible() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" })
        '';
        "<S-Tab>" = ''
          cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" })
        '';
      };

      window = {
        completion.border = "rounded";
        documentation.border = "rounded";
      };

      sources = [
        { name = "copilot"; }
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
    };
  };

  plugins.luasnip = {
    enable = true;
    fromVscode = [ { } ];
  };

  plugins.lspkind = {
    enable = true;
    settings = {
      mode = "symbol_text";
      cmp = {
        enable = true;
        max_width = 50;
        ellipsis_char = "...";
      };
    };
  };

  plugins.friendly-snippets.enable = true;
}
