{ pkgs, ... }:
{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      bash = [ "shellcheck" ];
      sh = [ "shellcheck" ];
      python = [ "mypy" ];
      markdown = [ "markdownlint" ];
      javascript = [ "eslint_d" ];
      typescript = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
    };
    autoCmd = {
      event = [
        "BufWritePost"
        "BufReadPost"
        "InsertLeave"
      ];
      callback.__raw = ''
        function()
          require("lint").try_lint()
        end
      '';
    };
  };

  extraPackages = with pkgs; [
    shellcheck
    mypy
    markdownlint-cli
    eslint_d
  ];
}
