# Robert's Nixvim Config

A fully declarative Neovim configuration built as a [Nix flake](https://nixos.wiki/wiki/Flakes) using [nixvim](https://github.com/nix-community/nixvim). No manual plugin management — everything is reproducible and self-contained.

## Features

**LSP servers:** Lua, Nix, Bash, JSON, JavaScript/TypeScript, C/C++, Rust, Java, C#/.NET (Roslyn), Python, Scala (Metals), LaTeX

**Treesitter grammars:** Nix, Vim/Vimdoc, Bash, Lua, Python, JSON, Java, C#, Rust, C/C++, Markdown, YAML, TOML, Scala, JavaScript/TypeScript/TSX/JSDoc

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

C# language features use [roslyn.nvim](https://github.com/seblyng/roslyn.nvim) with the Roslyn server from Nixpkgs. A .NET SDK must be on `PATH` (SDK 10+ is recommended); launching Neovim from the project's development shell lets `global.json` select the intended SDK.

```bash
# Run the full config directly
nix run github:rschaffar/nixvim-config

# Run the light config for headless / low-bandwidth machines
nix run github:rschaffar/nixvim-config#light

# Verify both configs build without errors
nix flake check
```

The `light` output disables the heaviest bundled tooling (Java, C#/.NET, C/C++, Python, Scala, JS/TS, Bash, Nix LSP stacks, DAP helpers, Git tooling, and extra desktop utilities) while keeping the core editor/plugins.

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
