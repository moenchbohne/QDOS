{ config, pkgs, lib, ... }:
let 
  myAliases = {
    e ="emacsclient -nw -c -a 'emacs -nw' ";
    w ="curl wttr.in/Celle";
    ff="fastfetch";
    sf = "starfetch";
    cf = "countryfetch";
    qnh = "nh os switch /etc/nixos";
    qnhu = "nh os switch /etc/nixos --update";
    reb = "sudo nixos-rebuild switch --flake /etc/nixos";
    rep = "sudo nixos-rebuild switch --flake /etc/nixos --upgrade";
    nixcp = "cp -r /etc/nixos/* ~/GitRepos/QDOS/nixos-config";
    cpnix = "sudo cp -r GitRepos/QDOS/nixos-config/* /etc/nixos/";
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
