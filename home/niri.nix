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
  home.packages = with pkgs; [
    pkgs-unstable.swww
    imagemagick
    wl-mirror
    kanshi
    inputs.nfsm.packages.${pkgs.system}.nfsm
    inputs.nfsm.packages.${pkgs.system}.nfsm-cli
    mako
  ];
  xdg.configFile = {
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
}
