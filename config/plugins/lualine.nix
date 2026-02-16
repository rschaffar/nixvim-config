{
  plugins.lualine = {
    enable = true;
    settings = {
      options.theme = "gruvbox";
      tabline = {
        lualine_a = [
          {
            __unkeyed-1 = "buffers";
            mode = 4;
            max_length.__raw = "vim.o.columns * 2 / 3";
          }
        ];
        lualine_z = [ "tabs" ];
      };
    };
  };
}
