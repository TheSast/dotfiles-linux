{
  pkgs,
  ...
}:
{
  services.flatpak.enable = true;
  xdg.portal = {
    # this is only necessary due to config.services.flatpak.enable, otherwise it should be user-side
    enable = true;
    extraPortals = with pkgs; [
      emptyDirectory
    ];
  };
}
