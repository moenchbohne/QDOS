{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qalculate-qt # calculator
<<<<<<< HEAD
    # ===== wifi =====
    geteduroam 
    speedtest
=======
    geteduroam # wifi
    # ----- c-Packages -----
    gcc
    gnumake
    stdenv
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
>>>>>>> 8f9c6a6c89ddbbff249e5b5a300816730d3c5bf3
>>>>>>> Stashed changes
=======
>>>>>>> 8f9c6a6c89ddbbff249e5b5a300816730d3c5bf3
>>>>>>> Stashed changes
  ];
}