# home.nix
{ config, pkgs, ... }:

{
  # Metadaten müssen sein
  home.username = "quentin";
  home.homeDirectory = "/home/quentin";

  # Wichtig: State Version (ähnlich wie bei NixOS)
  home.stateVersion = "25.11"; # oder was gerade aktuell ist

  # Programme aktivieren
  programs.home-manager.enable = true; # HM verwaltet sich selbst

  # Hier kommen deine Module rein
  imports = [
    # ../modules/nushell.nix
  ];

  # Beispiel direkt hier
  programs.git = {
    enable = true;
  };

  programs.cava.enable = true;
}