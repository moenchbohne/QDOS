{ config, pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    spotify
  ];

  # ===== Spicetify =====
  programs.spicetify =
   let
     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
   in
   {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      betterGenres
      addToQueueTop
     ];
     theme = lib.mkForce spicePkgs.themes.starryNight; # alt: text; retroBlur; hazy 
     # colorScheme = "mocha";
   };
}