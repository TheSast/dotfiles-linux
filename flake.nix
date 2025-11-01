{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-blur = {
      url = "github:visualglitch91/niri/2bc06170c36d613dad88ccf26cec8ca5e379d76e";
      inputs.rust-overlay.follows = "";
    };
    nfsm = {
      url = "github:gvolpe/nfsm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
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
          ./os
          ./os/kafka
          ./os/kafka/hardware.nix
        ];
        specialArgs = {inherit inputs;};
      };
      firefly = nixpkgs.lib.nixosSystem {
        modules = [
          ./os
          ./os/firefly
          ./os/firefly/hardware.nix
        ];
        specialArgs = {inherit inputs;};
      };
    };

    homeConfigurations = {
      "u@kafka" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home
          ./home/kafka
        ];
        extraSpecialArgs = {inherit inputs pkgs-unstable;};
      };
      "u@firefly" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home
          ./home/firefly
        ];
        extraSpecialArgs = {inherit inputs pkgs-unstable;};
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
