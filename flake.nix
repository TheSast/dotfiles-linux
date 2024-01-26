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
