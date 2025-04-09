{ config, pkgs, lib, ... }:
let 
  myAliases = {
    e ="emacsclient -nw -c -a 'emacs -nw' ";
    w ="curl wttr.in/Celle";
    ff="fastfetch";
    sf = "starfetch";
    cf = "countryfetch";
    ccf = "countryfetch china";
    qnh = "nh os switch /home/quentin/GitRepos/QDOS/nixos-config";
    qnhu = "nh os switch /home/quentin/GitRepos/QDOS/nixos-config --update";
    reb = "sudo nixos-rebuild switch --flake /home/quentin/GitRepos/QDOS/nixos-config";
    rep = "sudo nixos-rebuild switch --flake /home/quentin/GitRepos/QDOS/nixos-config --upgrade";
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