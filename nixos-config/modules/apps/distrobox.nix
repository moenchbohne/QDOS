{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    distrobox
    distrobox-tui
    distroshelf
  ];
}