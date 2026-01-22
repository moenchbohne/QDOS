{ config, lib, pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;

    package = pkgs.thunderbird;

    profiles = {
      "quentin" = {
        isDefault = true;
      };
    };
  };

  home.packages = with pkgs; [
    birdtray # notification tray icon
  ];
}