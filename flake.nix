{
  description = "Robert's Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem =
        { system, lib, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};

          mkNixvimModule = light: {
            inherit system;
            module = {
              imports = [ ./config ];

              # Keep Nixvim on this flake's nixpkgs revision and allow only
              # the unfree language server required by copilot.lua.
              nixpkgs = {
                source = inputs.nixpkgs;
                config.allowUnfreePredicate = pkg: lib.getName pkg == "copilot-language-server";
              };
            };
            extraSpecialArgs = {
              inherit light;
            };
          };

          nixvimModule = mkNixvimModule false;
          lightNixvimModule = mkNixvimModule true;

          nvim = nixvim'.makeNixvimWithModule nixvimModule;
          nvimLight = nixvim'.makeNixvimWithModule lightNixvimModule;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
            light = nixvimLib.check.mkTestDerivationFromNixvimModule lightNixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
            light = nvimLight;
          };
        };
    };
}
