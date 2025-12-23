{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # still in the POC/WIP/tryout phase
    strawberry
    feishin
    aonsoku
    # ampcast package urself
    supersonic-wayland
  ];
}