{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs-nox
  ];

  services.emacs = {
    enable=true;
  };
}