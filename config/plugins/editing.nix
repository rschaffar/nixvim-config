{ pkgs, ... }:
{
  plugins.comment.enable = true;

  plugins.refactoring = {
    enable = true;
    enableTelescope = true;
  };

  # vim-expand-region (no native nixvim support)
  extraPlugins = with pkgs.vimPlugins; [
    vim-expand-region
  ];
}
