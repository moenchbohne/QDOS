{ config, lib, pkgs, ... }:

{
  services.flameshot = {
    enable = true;
    
    package = pkgs.flameshot;
  };


  services.flameshot.settings = {
    
  };
}