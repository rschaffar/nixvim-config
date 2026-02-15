{ pkgs, ... }:
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
    ./plugins/git.nix
    ./plugins/dap.nix
    ./plugins/harpoon.nix
    ./plugins/which-key.nix
    ./plugins/mini.nix
    ./plugins/editing.nix
    ./plugins/ufo.nix
    ./plugins/glance.nix
    ./plugins/trouble.nix
    ./plugins/spectre.nix
    ./plugins/session.nix
    ./plugins/misc.nix
    ./plugins/render-markdown.nix
  ];

  extraConfigLuaPre = ''
    -- Force color output for plugins that check this variable to determine whether to use colors or not.
    -- Enabled because the glow plugin did not display colors
    vim.env.CLICOLOR_FORCE = "1"
  '';

  extraPackages = with pkgs; [
    # Formatters (not provided by LSP plugins)
    nixfmt
    stylua

    # Tools
    tree-sitter
    nodejs_22
    xclip
    wl-clipboard
    glow
    lazygit
    lazydocker
  ];
}
