{ config, lib, pkgs, ... }:

{
  program.nushell = {
    enable = true;

    # conf/env
    configFile.source = ../../;
    envFile.source = ../../;

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