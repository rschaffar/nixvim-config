{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
      vim
      vimdoc
      bash
      lua
      python
      json
      java
      rust
      c
      cpp
      markdown
      markdown_inline
      yaml
      toml
      scala
    ];
  };
}
