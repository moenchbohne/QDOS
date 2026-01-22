{ config, pkgs, lib, pkgs-stable, inputs, ... }:

{
  home = {
    username = "quentin";
    homeDirectory = "/home/quentin";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    zettlr
  ];

  imports = [
    ../../../modules/user/shell-env.nix
    ../../../modules/user/rofi.nix
    # ../../../modules/user/shell-env/default.nix
    ../../../modules/user/flameshot/default.nix
    ../../../modules/user/thunderbird/default.nix
  ];

  programs.git = {
    enable = true;
  };

  programs.cava.enable = true;
}