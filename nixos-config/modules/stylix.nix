{ config, pkgs, ... }:

{
  stylix = {
    
    enable = true;
    image = ./red-sunset.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    targets.gtk.enable = true;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Emoji";
      };
    };

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 12;
    };
  };
}