{ pkgs ? import <nixpkgs> {} }:

# DEV environment für X's /e/OS

pkgs.mkShell {
  # Specify the packages to include
  buildInputs = [
    pkgs.android-tools
    pkgs.zsh
  ];

  # Set ZSH as the default shell
  shell = "${pkgs.zsh}/bin/zsh";

  # Custom shell initialization
  shellHook = ''
    export SHELL=${pkgs.zsh}/bin/zsh
    exec $SHELL
  '';
}
