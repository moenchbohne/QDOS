{ config, lib, pkgs, ... }: 

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs
  };
}