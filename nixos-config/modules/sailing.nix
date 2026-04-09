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
    # soundcloud
    scdl
    ffmpeg
    # Slsk und BitTorrent
    qbittorrent-enhanced
    nicotine-plus
    slsk-batchdl
    # general dwld
    varia
  ];
}