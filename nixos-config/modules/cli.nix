{ config, pkgs, lib, ... }:
let 
  myAliases = {
    e ="emacsclient -nw -c -a 'emacs -nw' ";
    w ="curl wttr.in/Celle";
    ff="fastfetch";
    sf = "starfetch";
    cf = "countryfetch";
    dreb = "sudo nixos-rebuild switch --flake .#desktop";
    lreb = "sudo nixos-rebuild switch --flake .#laptop";
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
}