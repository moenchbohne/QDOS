{ config, lib, pkgs, inputs, ... }:

{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    hyprpaper
  ]
}