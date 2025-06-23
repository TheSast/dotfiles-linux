{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages."${system}";
    pkgs-unstable = nixpkgs-unstable.legacyPackages."${system}";
    pkgsForAllSystems = f:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ] (system: f nixpkgs.legacyPackages.${system});
  in {
    nixosConfigurations = {
      charlie = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          ./nixos/hardware-configuration.nix
        ];
      };
    };

    homeConfigurations = {
      u = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/home.nix
        ];
        extraSpecialArgs = {inherit pkgs-unstable;};
      };
    };
    devShells = pkgsForAllSystems (pkgs: {
      hypr =
        pkgs.mkShell.override {
          stdenv = pkgs.stdenvNoCC;
        } {
          packages = with pkgs; [
            hyprls
          ];
        };
    });
  };
}
