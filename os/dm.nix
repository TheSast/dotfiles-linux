{
  pkgs,
  lib,
  inputs,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = let
          wayland-session-packages = with pkgs; [
            inputs.niri-blur.packages.${pkgs.system}.default
            (pkgs.runCommand "hyprland-session-uwsm" {} ''
              mkdir -p $out/share/wayland-sessions
              sed 's|^Exec=.*|Exec=uwsm start -S -F Hyprland|' \
              ${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop \
              > $out/share/wayland-sessions/hyprland.desktop
            '')
          ];
          sessions = builtins.concatStringsSep ":" (builtins.map (p: "${p}/share/wayland-sessions") wayland-session-packages);
        in "${lib.getExe pkgs.greetd.tuigreet} --remember --remember-user-session --sessions ${sessions}";
        user = "greeter";
      };
    };
  };
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
