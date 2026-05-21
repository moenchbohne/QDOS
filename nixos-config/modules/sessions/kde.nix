{ config, lib, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
  ];

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs.kdePackages; [
    filelight
    audex
    isoimagewriter
    elisa
    kalk
  ];
}