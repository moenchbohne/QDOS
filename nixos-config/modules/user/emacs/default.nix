{pkgs, ...}: {
  # client emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  # demon emacs
  services.emacs = {
    enable = true;
    defaultEditor = true;
    
  };

  home.Packages = with pkgs; [
    ##### LSPs #####
    nixd

    ##### Misc #####
  ];
}
