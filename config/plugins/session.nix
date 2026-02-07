{
  plugins.auto-session = {
    enable = true;
    settings = {
      suppressed_dirs = [
        "~/"
        "~/Downloads"
        "/"
      ];
      pre_save_cmds = [
        "Neotree close"
      ];
    };
  };
}
