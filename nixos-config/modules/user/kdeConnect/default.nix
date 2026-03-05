{ config, lib, pkgs, ... }:

{
  services.kdeconnect = {
    enable = true;
    package = pkgs.valent;
    indicator = true;
  };
}