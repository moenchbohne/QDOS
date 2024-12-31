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
        inputs.musnix.nixosModules.musnix 
      ];
    };
  };
}
