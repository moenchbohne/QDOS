{pkgs, ...}: let
  myAliases = {
    eg = "emacsclient -c -a ''";
    e = "emacsclient -nw -a ''";
    x = "exit";
    cc = "clear";
    rr = "rm -rf"; # really remove
    ff = "fastfetch";

    dreb = "sudo nixos-rebuild switch --flake .#mangrove";
    lreb = "sudo nixos-rebuild switch --flake .#poplar";
    nhr = "nh os switch ~/GitRepos/QDOS/nixos-config";
    m = "cd ~/monorepo"; # move to monorepo

    l = "eza --icons -l --git --no-time";
    ll = "eza --icons -l --git --header --time-style=long-iso";
    lt = "eza --icons --tree --level=3";
    la = "eza --icons -l -a";

    cat = "bat --style=plain";
    less = "bat";
  };
in {
  programs.nushell = {
    enable = true;
    shellAliases = myAliases;
    package = pkgs.nushell;

    # envFile.source = ./env.nu;
    # configFile.source = ./config.nu;
    # loginFile.source = ./login.nu;

    plugins = with pkgs.nushellPlugins; [
      #  net broken
      #  units broken
      #  skim doch kein plugin :(
      gstat
      formats
      #  highlight version conflict
    ];

    extraConfig = ''
      $env.config.show_banner = false

      let poke_ids = [ 487 382 384 383 491 386 644 800 249 483 484 002 001 ]
      let selected = ($poke_ids | shuffle | first)
      pokeget $selected -s --hide-name
    '';
  };
}
