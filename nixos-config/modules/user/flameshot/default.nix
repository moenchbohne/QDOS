{ config, lib, pkgs, ... }:

{
  services.flameshot = {
    enable = true;
    
    package = pkgs.flameshot;
  };


  services.flameshot.settings = {
      General = {
              
        # savePath = "/home/user/Screenshots";
        
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;

        saveAsFileExtension = ".png";

        showDesktopNotification = true;
        showAbortNotification = false;

        # Whether to show the info panel in the center in GUI mode
        showHelp = true;
        showSidePanelButton = true;

        # wayland compat
        useGrimAdapter = true;
        disabledGrimWarning = true;
      };
  };

  home.packages = with pkgs; [
    grim
  ];
}