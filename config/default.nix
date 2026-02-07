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
    ./plugins/spectre.nix
    ./plugins/session.nix
    ./plugins/misc.nix
  ];

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
