{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, ...}@inputs: 
  let 
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in 
  {
    nixosConfigurations.poplar = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix 
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
      ];
    };
  };
}
