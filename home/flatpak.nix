{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  home.packages = [
    pkgs-unstable.flatpak
  ];
  services = {
    flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      # only works for those that have allowAutoUpdate = true
      update.auto = {
        enable = true;
        onCalendar = "hourly";
      };
      packages = let
        forceExplicitAutoUpdate = builtins.map (
          item:
            if builtins.isString item
            then throw "Package entries must use a `commit`, a `sha256` or `allowAutoUpdate`"
            else let
              hasAutoUpdate = item ? allowAutoUpdate && item.allowAutoUpdate;
            in
              if hasAutoUpdate && (item ? commit || item ? sha256)
              then throw "`allowAutoUpdate` cannot be used together with `commit` or `sha256`."
              else if hasAutoUpdate
              then builtins.removeAttrs item ["allowAutoUpdate"]
              else item
        );
      in
        forceExplicitAutoUpdate [
          {
            appId = "no.mifi.losslesscut";
            commit = "6149edf7b898076ff81c1d55e52451fde0857494925f550daca90f9b77c4f391";
          }
          {
            appId = "io.github.celluloid_player.Celluloid";
            commit = "0696c5f2697218d566e51dbb81935e986621bf63c68d7a5a6bf0a574e6a6a22b";
          }
          {
            appId = "md.obsidian.Obsidian";
            commit = "092bb11df3c993bd41aebf29b91228e3dc47ebb918c0224cea792006f123e084";
          }
          {
            appId = "org.gnome.Evince";
            commit = "9f0403ef260ec7a60409742bc04348dc5d636cb7781ca03b589594e3437855ed";
          }
          {
            appId = "com.bitwarden.desktop";
            commit = "66d1f3b52e9c42a150089a47d69914bf68b58c05f1bd8fc9f932ea7f186c64b8";
          }
        ];
      overrides = {
        # borken atm https://github.com/gmodena/nix-flatpak/issues/205
        # pruneUnmanagedOverrides = 1rue;
        # settings = {
        global = {
          Context.sockets = [
            "wayland"
            "!x11"
            "!fallback-x11"
          ];
        };
        # };
      };
    };
  };
}
