{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qalculate-qt # calculator
    geteduroam # wifi
    # ----- c-Packages -----
    gcc
    gnumake
    stdenv
  ];
}