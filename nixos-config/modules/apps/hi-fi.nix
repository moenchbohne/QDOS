{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # still in the POC/WIP/tryout phase
    strawberry

    # together for bit perfect
    feishin
    mpv

    aonsoku
    # ampcast package urself
    supersonic-wayland
  ];
}