{ config, pkgs, lib, ... }:
let 
  myAliases = {
    e ="emacsclient -nw -c -a 'emacs -nw' ";
    w ="curl wttr.in/Celle";
    ff="fastfetch";
    sf = "starfetch";
    cf = "countryfetch";
    cc="clear";
    x="exit";
    rr="rm -rf";
    nhr="nh os switch ~/GitRepos/QDOS/nixos-config";
    dreb = "sudo nixos-rebuild switch --flake .#mangrove";
    lreb = "sudo nixos-rebuild switch --flake .#poplar";
    rel = "source ~/.zshrc";
    build = "nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { } '";
    doom = "sudo nix run github:nix-community/nix-doom-emacs";

    # ===== replace old shit =====
    cd = "z";
    cdi = "zi";
    cat= "bat";
    ls= "eza --icons -l";
    lt= "eza --icons -l -T -L=3";
  };
in
{
  # ZSH
  programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      shellAliases = myAliases;
    };

  environment.systemPackages = with pkgs; [
    # big three + fzf
    zoxide
    eza
    bat
    fzf

    # cli util
    pciutils
    tldr
    yazi
    powertop
    appimage-run
    starship
    btop
    git
    git-filter-repo

    # unixp*rn
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

  # enable * term PW
  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";
}