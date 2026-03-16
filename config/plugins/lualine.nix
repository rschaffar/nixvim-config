{
  plugins.lualine = {
    enable = true;
    settings = {
      options.theme = "auto";
      sections = {
        lualine_x = [
          {
            __unkeyed-1.__raw = ''
              require("noice").api.status.mode.get
            '';
            cond.__raw = ''
              require("noice").api.status.mode.has
            '';
            color = {
              fg = "#ff9e64";
            };
          }
        ];
      };
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
