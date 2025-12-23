{ config, lib, pkgs, ... }:

{
  # for headless operation -> safe POSIX shell
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $- == *i* ]]; then
        exec nu
      fi
    '';
  };

  # if "user" is operator -> better shell is used
  programs.nushell = {
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

  # powerful completions
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}