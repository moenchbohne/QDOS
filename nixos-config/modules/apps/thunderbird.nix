{ config, pkgs, lib, ... }:

{
  programs.thunderbird = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    birdtray
  ];
}