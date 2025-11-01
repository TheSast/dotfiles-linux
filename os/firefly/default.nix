{lib, ...}: {
  networking.hostName = "firefly";
  system.stateVersion = "25.05"; # WARNING: do not touchy
  boot.loader = {
    efi.canTouchEfiVariables = false;
    systemd-boot.enable = true;
  };
  hardware = {
    graphics.enable = true;
    nvidia.open = false;
  };
  services.xserver.videoDrivers = ["nvidia"];
  services.pipewire.pulse.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];
  programs = {
    steam.enable = true;
    steam.gamescopeSession.enable = true;
    gamemode.enable = true;
  };
}
