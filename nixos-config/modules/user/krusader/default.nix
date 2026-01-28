# ITS STILL SYSTEM CODE TRANSLATE TO HM CODE

{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # the holy fm
    krusader

    # krusader integrated tools
    kdePackages.kget # DL manager 
    krename # rename util
    mlocate # ???
    busybox # diff util ?
    zip # zip archieves
    rar # rar archieves

    # auto mount??
    kio-fuse
    kdePackages.kio

    # qt control outside of KDE
    kdePackages.qt6ct
  ];
}