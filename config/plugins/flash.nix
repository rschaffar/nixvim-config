{
  plugins.flash = {
    enable = true;
    settings = {
      labels = "asdfghjklqwertyuiopzxcvbnm";
      search = {
        mode = "fuzzy";
      };
      jump = {
        autojump = true;
      };
      label = {
        uppercase = false;
        rainbow = {
          enabled = true;
          shade = 5;
        };
      };
      modes = {
        search = {
          enabled = false; # don't hijack /
        };
        char = {
          jump_labels = true;
        };
        treesitter = {
          labels = "asdfghjklqwertyuiopzxcvbnm";
          label.before = [
            0
            0
          ];
          label.after = [
            0
            0
          ];
        };
      };
    };
  };

  keymaps = [
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action.__raw = "function() require('flash').jump() end";
      options = {
        desc = "Flash jump";
      };
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "S";
      action.__raw = "function() require('flash').treesitter() end";
      options = {
        desc = "Flash treesitter";
      };
    }
    {
      mode = "o";
      key = "r";
      action.__raw = "function() require('flash').remote() end";
      options = {
        desc = "Flash remote";
      };
    }
    {
      mode = [
        "o"
        "x"
      ];
      key = "R";
      action.__raw = "function() require('flash').treesitter_search() end";
      options = {
        desc = "Flash treesitter search";
      };
    }
    {
      mode = "c";
      key = "<C-s>";
      action.__raw = "function() require('flash').toggle() end";
      options = {
        desc = "Toggle Flash in search";
      };
    }
  ];
}
