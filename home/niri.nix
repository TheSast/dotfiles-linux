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
    niri
    awww
    imagemagick
    wl-mirror
    kanshi
    inputs.nfsm.packages.${pkgs.stdenv.hostPlatform.system}.nfsm
    inputs.nfsm.packages.${pkgs.stdenv.hostPlatform.system}.nfsm-cli
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
        pkgs.niri
      ];
    };
    configFile = {
      niri = {
        source = symlinkDirectly "niri";
      };
      xdg-desktop-portal = {
        source = ./xdg-desktop-portal;
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
