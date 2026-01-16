{ config, pkgs, lib, pkgs-stable, ... }:

{
  # Metadaten müssen sein
  home.username = "quentin";
  home.homeDirectory = "/home/quentin";

  # Wichtig: State Version (ähnlich wie bei NixOS)
  home.stateVersion = "25.11"; # oder was gerade aktuell ist

  # Programme aktivieren
  programs.home-manager.enable = true; # HM verwaltet sich selbst

  home.packages = with pkgs; [
    zettlr
  ];

  imports = [
    ../../../modules/user/shell-env.nix
  ];

  programs.git = {
    enable = true;
  };

  programs.cava.enable = true;
}