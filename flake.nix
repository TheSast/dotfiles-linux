{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
      kafka = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          ./nixos/hardware-configuration.nix
          {
            nix = {
              channel.enable = false;
              settings.use-registries = false;
              settings.flake-registry = "";
              nixPath = [];
            };
          }
        ];
      };
    };

    homeConfigurations = {
      u = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/home.nix
          {
            nix = {
              settings.use-registries = false;
              settings.flake-registry = "";
              keepOldNixPath = false;
              nixPath = [];
            };
          }
        ];
        extraSpecialArgs = {inherit pkgs-unstable;};
      };
    };
    formatter."${system}" = pkgs.alejandra;
    devShells = pkgsForAllSystems (pkgs: {
      shell =
        pkgs.mkShell.override {
          stdenv = pkgs.stdenvNoCC;
        } {
          packages = with pkgs; [
            shellcheck
            nodePackages.bash-language-server
            shellharden
            shfmt
          ];
        };
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
