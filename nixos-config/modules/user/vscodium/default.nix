{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    # some settings
    mutableExtensionsDir = false;

    # Extensions
    extensions = with pkgs.vscode-extensions; [
    ];
  };
}
