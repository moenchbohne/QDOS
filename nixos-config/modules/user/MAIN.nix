{ config, pkgs, lib, ... }:

let 
  myAliases = {
    # --- Shorties ---
    e   = "emacsclient -nw -c -a 'emacs -nw'";
    x   = "exit";
    cc   = "clear"; # In Nu ist 'clear' oft schon eingebaut, aber schadet nicht
    rr  = "rm -rf";
    ff = "fastfetch";
    
    # --- NixOS Magic ---
    dreb = "sudo nixos-rebuild switch --flake .#mangrove";
    lreb = "sudo nixos-rebuild switch --flake .#poplar";
    # Nutze ';' statt '&&' in Nu Strings, wenn du sicher sein willst, 
    # aber Nu versteht mittlerweile oft auch &&.
    nhr  = "cd ~/GitRepos/QDOS/nixos-config; nh os switch ."; 
    
    # --- The "Sensible" Eza Integration ---
    # Wir überschreiben NICHT 'ls'. 
    # 'ls' bleibt Nushell-Native für Datenverarbeitung (ls | where size > 1gb)
    
    # Nur zum "Gucken" nehmen wir eza:
    l   = "eza --icons -l --git --no-time";      # Kurze Liste
    ll  = "eza --icons -l --git --header --time-style=long-iso"; # Detail Liste
    lt  = "eza --icons --tree --level=2";        # Tree view
    la  = "eza --icons -l -a";                   # Alles (auch hidden)

    # --- Bat Integration ---
    # 'cat' ist okay zu überschreiben, da wir zum Daten-Verarbeiten 'open' nutzen.
    cat = "bat --style=plain"; # Plain ist gut für Copy-Paste
    less = "bat";              # Bat ist auch ein Pager
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
    autosuggestions.enable = true;
    shellAliases = myAliases;
  };

  programs.nushell = {
    enable = true;
    shellAliases = myAliases;
    configFile.source = ../../../dotfiles/nushell/config.nu;
    envFile.source = ../../../dotfiles/nushell/env.nu;

    # HIER IST ES WIEDER:
    plugins = with pkgs.nushellPlugins; [
      net
      units
      skim      # <--- Zurück an seinem rechtmäßigen Platz
      gstat
      formats
      highlight
    ];
  };

  # 2. TOOLS CONFIGURATION
  
  # Zoxide (Smarter CD)
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    options = [ "--cmd cd" ];
    # Wir lassen zoxide NICHT automatisch 'cd' ersetzen, 
    # sondern nutzen explizit 'z' und 'zi'. 
    # Warum? Weil Nushells 'cd' auch error handling hat. 
    # Aber viele lieben 'options = ["--cmd cd"]'. Geschmackssache.
    # Ich lasse es hier Standard (alias z=zoxide)
  };

  # Eza (Ls Replacement)
  programs.eza = {
    enable = true;
    # WICHTIG: enableNushellIntegration = false!
    # Sonst setzt Home Manager automatisch "alias ls = eza",
    # und das wollen wir ja gerade vermeiden!
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
  
  # ... Rest (Carapace, Starship, FZF, Yazi wie gehabt) ...

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