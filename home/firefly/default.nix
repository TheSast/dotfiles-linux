{pkgs, ...}: {
  home.stateVersion = "25.05"; # WARNING: do not touchy
  home.packages = with pkgs; [
    xwayland-satellite
    mangohud
    protonup
  ];
}
