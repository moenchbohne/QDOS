{ config, lib, pkgs, inputs, ... }:

{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    hyprpaper
    libnma-gtk4
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

  # portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # env-vars
  # environment.variables = {
  #   HYPRLAND_CONFIG = "/home/quentin/GitRepos/QDOS/dotfiles/hypr/"
  # };
}