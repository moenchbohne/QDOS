{ config, lib, pkgs, ... }:

{
  services = {
    resolved.enable = true;

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };
}