{pkgs, ...}: let
  myAliases = {
    eg = "emacsclient -c -a ''";
    e = "emacsclient -nw -a ''";
    x = "exit";
    cc = "clear";
    rr = "rm -rf";
    ff = "fastfetch";

    dreb = "sudo nixos-rebuild switch --flake .#mangrove";
    lreb = "sudo nixos-rebuild switch --flake .#poplar";
    nhr = "nh os switch ~/GitRepos/QDOS/nixos-config";

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
    # configFile.source = ./config.nu;
    # envFile.source = ./env.nu;

    plugins = with pkgs.nushellPlugins; [
      #  net broken
      #  units broken
      #  skim doch kein plugin :(
      gstat
      formats
      #  highlight version conflict
    ];

    extraConfig = ''
      # Disable the startup banner
      $env.config.show_banner = false

      # --- Random Poke on Start ---
      let poke_ids = [
          487 # Giratina
          382 # Kyogre
          384 # Rayquaza
          383 # Groudon
          491 # Darkrai
          386 # Deoxys
          644 # Zektrom (Tims Pokemon)
          800 # Necrozma
          249 # Lugia
          483 # Dialga
          484 # Palkia
          # 002 # Ivysaur
          # 001 # Bulbasaur
      ]

      # Select random ID and run pokeget
      let selected = ($poke_ids | shuffle | first)
      pokeget $selected -s --hide-name
    '';
  };
}
