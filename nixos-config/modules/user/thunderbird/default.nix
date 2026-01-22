{ config, lib, pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;

    package = pkgs.thunderbird;
  };

  home.packages = with pkgs; [
    birdtray # notification tray icon
  ];
}