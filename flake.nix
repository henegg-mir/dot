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

    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-2505,
      nixos-hardware,
      #lix-module,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlay-2505 = final: prev: {
        stable = import nixpkgs-2505 {
          inherit system;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "gradle-7.6.6"
          ];
        };
        overlays = [
          overlay-2505
          inputs.millennium.overlays.default
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
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-gpu-intel
            nixos-hardware.nixosModules.common-pc-laptop
            nixos-hardware.nixosModules.common-pc-laptop-ssd
            #lix-module.nixosModules.default
          ];
        };
        zamacona = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./zamacona/configuration.nix
            #lix-module.nixosModules.default
          ];
        };
        yorith = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./yorith/configuration.nix
            #lix-module.nixosModules.default
          ];
        };

      };

      homeConfigurations = {
        azathoth = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            server = false;
            desktop = false;
          };
          modules = [
            ./home.nix
            #lix-module.nixosModules.default
          ];
        };
        zamacona = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            server = true;
            desktop = false;
          };
          modules = [
            ./home.nix
            #lix-module.nixosModules.default
          ];
        };
        yorith = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            server = false;
            desktop = true;
          };
          modules = [
            ./home.nix
            #lix-module.nixosModules.default
          ];
        };
      };
    };
}
