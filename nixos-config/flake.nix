{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix.url = "github:musnix/musnix"; 
    stylix.url = "github:danth/stylix";
    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs: 
  let 
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    pkgs-stable = nixpkgs-stable.legacyPackages.x86_64-linux; 
  in
  {
    nixosConfigurations.mangrove = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { 
        inherit inputs;
        inherit pkgs-stable; 
      };
      modules = [
        ./configuration.nix
        ./modules/hardware-configuration.nix
        ./modules/virtualization.nix
        ./modules/mpd.nix
        ./modules/samba.nix
        inputs.musnix.nixosModules.musnix
        inputs.stylix.nixosModules.stylix 
        inputs.spicetify-nix.nixosModules.default
        inputs.nix-snapd.nixosModules.default
      ];
    };
  };
}
