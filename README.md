# Robert's Nixvim Config

A fully declarative Neovim configuration built as a [Nix flake](https://nixos.wiki/wiki/Flakes) using [nixvim](https://github.com/nix-community/nixvim). No manual plugin management — everything is reproducible and self-contained.

## Features

**LSP servers:** Lua, Nix, Bash, JSON, C/C++, Rust, Java, Python, Scala (Metals), LaTeX

**Treesitter grammars:** Nix, Vim, Bash, Lua, Python, JSON, Java, Rust, C, C++, Markdown, YAML, TOML, Scala

**Plugins:**
- Completion via nvim-cmp + Copilot
- Telescope for fuzzy finding
- Neo-tree file explorer
- Harpoon for quick file navigation
- DAP for debugging
- Git integration (lazygit)
- Glance for LSP peek definitions/references
- Search and replace with Spectre
- Code folding with nvim-ufo
- Session management
- Which-key for keybinding discovery
- Mini.nvim utilities
- Catppuccin colorscheme + Lualine statusline

## Usage

```bash
# Run directly
nix run github:rschaffar/nixvim-config

# Verify config builds without errors
nix flake check
```

To integrate into an existing flake, add this as an input and include the package in your environment.

## Structure

```
config/
├── default.nix          # Root module — imports everything, declares extra packages
├── options.nix          # Neovim options (tabs, line numbers, etc.)
├── keymaps.nix          # Global keybindings
├── autocmds.nix         # Autocommands
└── plugins/
    ├── lsp.nix          # LSP server configurations + keymaps
    ├── treesitter.nix   # Treesitter grammars
    ├── cmp.nix          # Completion engine
    ├── copilot.nix      # GitHub Copilot
    ├── telescope.nix    # Fuzzy finder
    ├── neo-tree.nix     # File explorer
    ├── dap.nix          # Debug Adapter Protocol
    ├── git.nix          # Git integration
    ├── harpoon.nix      # File navigation
    └── ...              # Colorscheme, statusline, editing, etc.
```
