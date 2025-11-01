{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: let
  flakeLoc = "${config.xdg.configHome}/etc";
  symlinkDirectly = p: config.lib.file.mkOutOfStoreSymlink ("${flakeLoc}/home/" + p);
in {
  services.gnome-keyring.enable = true;
  home.packages = with pkgs; [
    uwsm
    (lib.hiPrio (pkgs.runCommand "uuctl.desktop-hide" {} ''
      mkdir -p "$out/share/applications"
      cat "${uwsm}/share/applications/uuctl.desktop" > "$out/share/applications/uuctl.desktop"
      echo "Hidden=1" >> "$out/share/applications/uuctl.desktop"
    ''))
    hyprland
    pkgs-unstable.hyprnotify # should fix cpu issues?
    hyprpicker
    (
      pkgs.runCommand "hyprpolkitagent-fixed" {} ''
        mkdir -p $out/libexec
        cp ${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent $out/libexec/
      ''
    )
    (
      pkgs.writeShellApplication
      {
        name = "better-hyprshot";
        runtimeInputs = [coreutils jq slurp grim libnotify hyprpicker];
        text = builtins.readFile ./scripts/better-hyprshot.sh;
      }
    )
  ];
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        (pkgs.xdg-desktop-portal-hyprland.overrideAttrs (_: {
          postFixup = ''
            wrapProgram $out/libexec/xdg-desktop-portal-hyprland \
              --prefix PATH : ${libsForQt5.qt5.qtwayland}/bin
          '';
        }))
      ];
      configPackages = with pkgs; [
        hyprland
      ];
    };
    configFile = {
      hypr = {
        source = symlinkDirectly "hypr";
      };
      kanshi = {
        source = ./kanshi;
      };
    };
  };
}
