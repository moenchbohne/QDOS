{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qalculate-qt # calculator
    # ===== wifi =====
    geteduroam 
    speedtest
    # ----- c-Packages -----
    gcc
    gnumake
    stdenv
  ];
}