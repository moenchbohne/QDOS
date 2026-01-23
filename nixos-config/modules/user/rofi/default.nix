{ config, lib, pkgs, inputs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    plugins = with pkgs; [ 
      rofi-calc
      rofimoji
    ]; 
    extraConfig = {
      modi = "drun,run,window,ssh";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      display-drun = "Apps";
      display-window = "Switch";
    };
  };
}