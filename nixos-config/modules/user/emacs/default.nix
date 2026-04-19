{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    
  };

  home.Packages = with pkgs; [
    ##### LSPs #####
    nixd

    ##### Misc #####
  ];
}
