{ config, pkgs, lib, pkgs-stable, ... }:

let 
  myAliases = {
    # --- Shorties ---
    e   = "emacsclient -nw -c -a 'emacs -nw'";
    x   = "exit";
    cc   = "clear";
    rr  = "rm -rf";
    ff = "fastfetch";
    
    # --- NixOS Magic ---
    dreb = "sudo nixos-rebuild switch --flake .#mangrove";
    lreb = "sudo nixos-rebuild switch --flake .#poplar";
    # fix: maybe ; instead of &&
    nhr  = "cd ~/GitRepos/QDOS/nixos-config && nh os switch ."; 
    
    # --- The "Sensible" Eza Integration ---
    # Wir überschreiben NICHT 'ls'. 
  
    l   = "eza --icons -l --git --no-time";      # short
    ll  = "eza --icons -l --git --header --time-style=long-iso"; # detail
    lt  = "eza --icons --tree --level=2";        # tree
    la  = "eza --icons -l -a";                   # hidden

    # --- Bat Integration ---
    # nushell = open
    cat = "bat --style=plain";
    less = "bat";              
  };
in
{
  # 1. SHELLS
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
      ../../../dotfiles/zsh/.zshrc
    '';
  };

  programs.nushell = {
    enable = true;
    shellAliases = myAliases;
    package = pkgs-stable.nushell;
    configFile.source = ../../../dotfiles/nushell/config.nu;
    envFile.source = ../../../dotfiles/nushell/env.nu;

    plugins = with pkgs-stable.nushellPlugins; [
    #  net broken
    #  units broken
    #  skim doch kein plugin :(    
      gstat
      formats
    #  highlight version conflict
    ];
  };

  # 2. TOOLS CONFIGURATION
  
  # Zoxide (Smarter CD)
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    options = [ "--cmd cd" ];
  };

  # Eza (Ls Replacement)
  programs.eza = {
    enable = true;
    enableNushellIntegration = false; 
    icons = "auto";
  };

  # Bat (Cat Replacement)
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };


  # Carapace
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Starship Prompt
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    configPath = "../../../dotfiles/starship/starship.toml";
  };
  
  # Yazi TUI Filemanager
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
  };



  # ====================================================================
  # 3. PACKAGES (CLI Candy & Tools)
  # ====================================================================
  home.packages = with pkgs; [
    # Core Tools
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