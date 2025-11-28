{ config, lib, pkgs, ... }:

{
  imports = [
    ./apps/mullvad.nix
  ];

  environment.systemPackages = with pkgs; [
    # music metadata
    picard
    puddletag
    kid3
    # movie metadata
    filebot
    # soundcloud
    scdl
    ffmpeg
    # Slsk und BitTorrent
    qbittorrent-enhanced
    nicotine-plus
  ];
}