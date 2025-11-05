{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # music metadata
    picard
    puddletag
    kid3
    # soundcloud
    scdl
    # Slsk und BitTorrent
    qbittorrent-enhanced
    nicotine-plus
  ];
}