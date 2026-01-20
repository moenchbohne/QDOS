{ config, pkgs, lib, pkgs-stable, ... }:

let 
  myAliases = {
    e   = "emacsclient -nw -c -a 'emacs -nw'";
    x   = "exit";
    cc   = "clear";
    rr  = "rm -rf";
    ff = "fastfetch";
  
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
    initExtra = ''
      # random poke on start
      select_random() {
        printf "%s\0" "$@" | shuf -z -n1 | tr -d '\0'
      }

      pokes=("pokeget 487 -s --hide-name" "pokeget 382 -s --hide-name" "pokeget 384 -s --hide-name" "pokeget 383 -s --hide-name")

      selectedpoke=$(select_random "''${pokes[@]}")
      eval $selectedpoke
    '';
  };

  programs.nushell = {
    enable = true;
    shellAliases = myAliases;
    package = pkgs-stable.nushell;
    # configFile.source = ../../../dotfiles/nushell/config.nu;
    # envFile.source = ../../../dotfiles/nushell/env.nu;

    plugins = with pkgs-stable.nushellPlugins; [
    #  net broken
    #  units broken
    #  skim doch kein plugin :(    
      gstat
      formats
    #  highlight version conflict
    ];
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

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    configPath = "../../../dotfiles/starship/starship.toml";
  };
  
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
  };

  home.packages = with pkgs; [
    ripgrep      # Wichtig für grep Alternativen
    fd           # Wichtig für find Alternativen
    pciutils
    tldr
    powertop
    appimage-run
    btop
    git-filter-repo
    skim # for now...

    # Unix P*rn / Fun
    starfetch
    fastfetch
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