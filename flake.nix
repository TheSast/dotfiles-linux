{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      charlie = nixpkgs.lib.nixosSystem rec {
        inherit system;

        specialArgs = {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs system;
        };

        modules = [
          ./nixos/configuration.nix
          ./nixos/hardware-configuration.nix
        ];
      };
    };

    homeConfigurations = {
      charlie = inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit inputs system;
        };

        pkgs = import inputs.nixpkgs {
          inherit system;
        };

        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
