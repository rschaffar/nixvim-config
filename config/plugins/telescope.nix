{
  plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;

    settings.defaults = {
      wrap_results = true;
      path_display = [ "filename_first" ];
    };
  };
}
