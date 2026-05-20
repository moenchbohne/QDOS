{pkgs, ...}: {
  # client emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  # symlink the config
  xdg.configFile."emacs/init.el".source = ./init.el;

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
