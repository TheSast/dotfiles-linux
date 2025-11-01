{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  ...
}: let
  flakeLoc = "${config.xdg.configHome}/etc";
  symlinkDirectly = p: config.lib.file.mkOutOfStoreSymlink ("${flakeLoc}/home/" + p);
in {
  services.gnome-keyring.enable = true;
  home.packages = with pkgs; [
    inputs.niri-blur.packages.${pkgs.system}.default
    pkgs-unstable.swww
    imagemagick
    wl-mirror
    kanshi
    inputs.nfsm.packages.${pkgs.system}.nfsm
    inputs.nfsm.packages.${pkgs.system}.nfsm-cli
    mako
  ];
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
      configPackages = [
        inputs.niri-blur.packages.${pkgs.system}.default
      ];
    };
    configFile = {
      niri = {
        source = symlinkDirectly "niri";
      };
      mako = {
        source = ./mako;
      };
      kanshi = {
        source = ./kanshi;
      };
    };
  };
}
