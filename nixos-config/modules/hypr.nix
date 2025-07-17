{ config, lib, pkgs, inputs, ... }:

{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    hyprpaper
    # notis
    dunst
    libnotify
    # launcher
    wofi
    # network
    networkmanagerapplet
    # filemanager
    krusader
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}