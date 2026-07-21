{
  config,
  pkgs,
  inputs,
  ...
}: let
  flakeLoc = "${config.xdg.configHome}/etc";
  symlinkDirectly = p: config.lib.file.mkOutOfStoreSymlink ("${flakeLoc}/home/" + p);
  gsettings-schemas = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.pname}-${pkgs.gsettings-desktop-schemas.version}";
in {
  services.gnome-keyring.enable = true;
  home.packages = with pkgs; [
    cliphist
    playerctl
    tofi
    udiskie
    wallust
    glib
    libnotify
    kanshi
    niri
    inputs.noctalia.packages."${pkgs.stdenv.hostPlatform.system}".default
    noctalia-shell
    wl-mirror
  ];
  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk4.theme = config.gtk.theme;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "gtk2";
  };
  systemd.user.sessionVariables.GSETTINGS_SCHEMAS = gsettings-schemas;
  xdg = {
    systemDirs = {
      data = [gsettings-schemas];
    };
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
      hypr = {
        source = symlinkDirectly "hypr";
      };
      kanshi = {
        source = ./kanshi;
      };
      niri = {
        source = symlinkDirectly "niri";
      };
      tofi = {
        source = ./tofi;
      };
      wallust = {
        source = ./wallust;
        recursive = true;
      };
      wallust-toml = {
        text =
          /*
          toml
          */
          ''
            [templates]
            alacritty = { template = "alacritty.toml", target = "${config.xdg.cacheHome}/wallust/alacritty.toml" }
            tty = { template = "tty.sh", target = "${config.xdg.cacheHome}/wallust/tty.sh" }
          '';
        target = "wallust/wallust.toml";
      };
      xdg-desktop-portal = {
        source = ./xdg-desktop-portal;
      };
    };
  };
}
