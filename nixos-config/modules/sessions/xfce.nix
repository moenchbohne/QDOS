{ config, pkgs, lib, ... }:

{
  # lightDM
  # services.xserver.displayManager.lightdm = {};

  services.xserver = {
  # xserver
    enable = true;
    xkb.layout = "de";

  # XFCE
    desktopManager = {
      xterm.enable = false;

      xfce = {
        enable = true;
        enableScreensaver = true;
        enableXfwm = true;
        enableWaylandSession = false;
      };
    };
  };

  # xfconf
  programs.xfconf = {
    enable = true;
  };
} 