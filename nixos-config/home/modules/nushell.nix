{ config, lib, pkgs, ... }:

{
  program.nushell = {
    enable = true;

    # conf/env
    configFile.source = ../../../dotfiles/nushell/config.nu;
    envFile.source = ../../../dotfiles/nushell/env.nu;

    # plugins
    plugins = with pkgs.nushellPlugins; [
      net
      units
      skim
      gstat
      formats
      highlight
    ];

  };
}