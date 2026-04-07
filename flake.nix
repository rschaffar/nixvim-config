{
  description = "Robert's Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    kokoro-tts = {
      url = "github:rschaffar/kokoro-tts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { system, lib, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};

          mkNixvimModule = light: {
            inherit system;
            module = import ./config;
            extraSpecialArgs = {
              inherit light;
              kokoro-say =
                if !light && inputs.kokoro-tts.packages ? ${system} then
                  inputs.kokoro-tts.packages.${system}.default
                else
                  null;
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
