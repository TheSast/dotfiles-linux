{
  pkgs,
  lib,
  ...
}: {
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = let
          wayland-session-packages = with pkgs; [
            niri
            (pkgs.runCommand "hyprland-session-uwsm" {} ''
              mkdir -p $out/share/wayland-sessions
              sed 's|^Exec=.*|Exec=uwsm start -S -F Hyprland|' \
              ${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop \
              > $out/share/wayland-sessions/hyprland.desktop
            '')
          ];
          sessions = builtins.concatStringsSep ":" (
            builtins.map (p: "${p}/share/wayland-sessions") wayland-session-packages
          );
          # todo, add steam's gamescope session when available
        in "${lib.getExe pkgs.tuigreet} --remember --remember-user-session --sessions ${sessions}";
        user = "greeter";
      };
    };
  };
}
