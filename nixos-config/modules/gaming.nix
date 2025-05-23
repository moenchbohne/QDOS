{ config, lib, pkgs, ... }:

{
  # ===== Steam + GM =====
  programs = {

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true; 
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    gamemode.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lutris
    prismlauncher # Minecraft 
    mangohud 
    mangojuice
    ryujinx-greemdev 
    # ===== Compat =====
    protonup # Proton-GE
    protontricks
  ];

  # ===== GPU Error Fix =====
  environment.variables = {
    DRI_PRIME = 1;
  };
}
