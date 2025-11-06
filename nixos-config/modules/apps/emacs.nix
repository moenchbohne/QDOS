{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # emacs package
    emacs-nox

    # language server
    nixd
  ];

  services.emacs = {
    enable=true;
  };
}