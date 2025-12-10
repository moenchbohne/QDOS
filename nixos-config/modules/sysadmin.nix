{ config, lib, pkgs, ... }:

{
  imports = [
    ./cli.nix
  ];

  environment.systemPackages = with pkgs; [
    # === OVPN + WG === 
    pritunl-client # OVPN
    # eddie

    # === Utils ===
    dnsutils
    wireshark
    toybox
    inetutils
    
    # === browser ===
    librewolf
  ];
}