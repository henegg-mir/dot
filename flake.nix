{
  description = "Egg's config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-2505.url = "github:nixos/nixpkgs/nixos-25.05";
    lix = {
      url = "git+https://git.lix.systems/lix-project/lix";
      flake = false;
    };
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.lix.follows = "lix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-2505,
      lix-module,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlay-2505 = final: prev: {
        stable = import nixpkgs-2505 {
          inherit system;
          config.allowUnfree = true;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
          ];
        };
        overlays = [
          overlay-2505
        ];
      };
      lib = nixpkgs;
    in
    {
      nixosConfigurations = {
        azathoth = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./azathoth/configuration.nix
            lix-module.nixosModules.default
          ];
        };
        zamacona = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./zamacona/configuration.nix
            lix-module.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        azathoth = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            server = false;
          };
          modules = [
            ./home.nix
            lix-module.nixosModules.default
          ];
        };
        zamacona = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            server = true;
          };
          modules = [
            ./home.nix
            lix-module.nixosModules.default
          ];
        };
      };
    };
}
