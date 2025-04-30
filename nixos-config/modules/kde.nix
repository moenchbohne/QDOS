{ config, lib, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
    kate
  ];

  program.kdeconnect.enable = true;

  environment.systemPackages = with pkgs.kdePackages; [
    filelight
    audex
    isoimagewriter
  ];
}