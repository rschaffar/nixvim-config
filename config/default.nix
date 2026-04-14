{
  pkgs,
  lib,
  kokoro-say,
  light ? false,
  ...
}:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
    ./plugins/colorscheme.nix
    ./plugins/lualine.nix
    ./plugins/telescope.nix
    ./plugins/neo-tree.nix
    ./plugins/treesitter.nix
    ./plugins/lsp.nix
    ./plugins/cmp.nix
    ./plugins/copilot.nix
    ./plugins/harpoon.nix
    ./plugins/which-key.nix
    ./plugins/mini.nix
    ./plugins/editing.nix
    ./plugins/ufo.nix
    ./plugins/glance.nix
    ./plugins/trouble.nix
    ./plugins/noice.nix
    ./plugins/grug-far.nix
    ./plugins/session.nix
    ./plugins/flash.nix
    ./plugins/todo-comments.nix
    ./plugins/undotree.nix
    ./plugins/treesitter-textobjects.nix
    ./plugins/lint.nix
    ./plugins/indent-blankline.nix
    ./plugins/misc.nix
    ./plugins/render-markdown.nix
    ./plugins/tips.nix
  ]
  ++ lib.optionals (!light) [
    ./plugins/java.nix
    ./plugins/git.nix
    ./plugins/dap.nix
  ];

  extraConfigLuaPre = ''
    -- Force color output for plugins that check this variable to determine whether to use colors or not.
    -- Enabled because the glow plugin did not display colors
    vim.env.CLICOLOR_FORCE = "1"
  '';

  extraPackages =
    (with pkgs; [
      # Formatters (not provided by LSP plugins)
      nixfmt

      # Tools
      tree-sitter
    ])
    ++ lib.optionals (!light) (with pkgs; [
      nodejs_22
      xclip
      wl-clipboard
      glow
      lazygit
      lazydocker
    ])
    ++ lib.optional (!light && kokoro-say != null) kokoro-say;
}
