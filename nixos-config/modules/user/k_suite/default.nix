{pkgs, ...}: {
  programs.konsole = {
    enable = true;
  };

  home.packages = with pkgs; [
    # file manager
    krusader

    # utility
    # ...
  ];
}
