{ config, pkgs, lib, pkgs-stable, ... }:

let 
  myAliases = {
    e   = "emacsclient -nw -c -a 'emacs -nw'";
    x   = "exit";
    cc   = "clear";
    rr  = "rm -rf";

    # fetches
    ff = "fastfetch";
    cf = "countryfetch";
    sf = "starfetch";
  
    dreb = "sudo nixos-rebuild switch --flake .#mangrove";
    lreb = "sudo nixos-rebuild switch --flake .#poplar";
    nhr  = "nh os switch ~/GitRepos/QDOS/nixos-config"; 
    
    l   = "eza --icons -l --git --no-time";      
    ll  = "eza --icons -l --git --header --time-style=long-iso";
    lt  = "eza --icons --tree --level=3";        
    la  = "eza --icons -l -a";                   

    cat = "bat --style=plain";
    less = "bat";              
  };
in
{
  imports = [
    ./shell-env/starship.nix
    ./shell-env/fastfetch.nix
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $- == *i* ]]; then
        exec nu
      fi
    '';
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = myAliases;
    initContent = ''
      # random poke on start
      select_random() {
        printf "%s\0" "$@" | shuf -z -n1 | tr -d '\0'
      }

      pokes=(
        "pokeget 487 -s --hide-name" # Giratina
        "pokeget 382 -s --hide-name" # Kyogre
        "pokeget 384 -s --hide-name" # Rayquaza
        "pokeget 383 -s --hide-name" # Groudon
        "pokeget 491 -s --hide-name" # Darkrai
        "pokeget 386 -s --hide-name" # Deoxys
        "pokeget 644 -s --hide-name" # Zektrom (Tims Pokemon)
        "pokeget 800 -s --hide-name" # Necrozma
        "pokeget 249 -s --hide-name" # Lugia
        "pokeget 483 -s --hide-name" # Dialga
        "pokeget 484 -s --hide-name" # Palkia
        # "pokeget 002 -s --hide-name" # Ivysaur
        # "pokeget 001 -s --hide-name" # Bulbasaur
      )

      selectedpoke=$(select_random "''${pokes[@]}")
      eval $selectedpoke
    '';
  };

  programs.nushell = {
    enable = true;
    shellAliases = myAliases;
    package = pkgs.nushell;
    # configFile.source = ../../../dotfiles/nushell/config.nu;
    # envFile.source = ../../../dotfiles/nushell/env.nu;

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

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.eza = {
    enable = true;
    enableNushellIntegration = false; 
    icons = "auto";
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
  };

  home.packages = with pkgs; [
    ripgrep      
    fd           
    pciutils
    tldr
    powertop
    appimage-run
    btop
    git-filter-repo
    skim # for now...

    # Unix P*rn / Fun
    starfetch
    countryfetch
    cbonsai
    unimatrix
    pokeget-rs
    pipes-rs
    fortune-kind
    charasay
    lolcat
    snowmachine
    asciiquarium-transparent
  ];
}