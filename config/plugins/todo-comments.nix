{
  plugins.todo-comments = {
    enable = true;
    settings = {
      signs = true;
      sign_priority = 8;
      highlight = {
        multiline = true;
        before = "";
        keyword = "wide";
        after = "fg";
        pattern = ''.*<(KEYWORDS)\s*:'';
        comments_only = true;
      };
      search = {
        command = "rg";
        args = [
          "--color=never"
          "--no-heading"
          "--with-filename"
          "--line-number"
          "--column"
        ];
        pattern = ''\b(KEYWORDS):'';
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "]t";
      action.__raw = "function() require('todo-comments').jump_next() end";
      options = {
        desc = "Next TODO comment";
      };
    }
    {
      mode = "n";
      key = "[t";
      action.__raw = "function() require('todo-comments').jump_prev() end";
      options = {
        desc = "Prev TODO comment";
      };
    }
    {
      mode = "n";
      key = "<leader>ft";
      action = "<cmd>TodoTelescope<CR>";
      options = {
        desc = "Find TODOs";
      };
    }
    {
      mode = "n";
      key = "<leader>xt";
      action = "<cmd>Trouble todo toggle<CR>";
      options = {
        desc = "Trouble TODOs";
      };
    }
  ];
}
