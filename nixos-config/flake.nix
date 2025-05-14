{
# ===== Description =====
 
  description = "My little Snowflake";

# ===== Inputs =====

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix.url = "github:musnix/musnix"; 
    # stylix.url = "github:danth/stylix";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

# ===== Outputs =====

  outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs: 
  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    }; 
  in
  {

# ===== Hosts ===== 

    nixosConfigurations = {

# ===== Desktop =====

      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit inputs;
          inherit pkgs-stable; 
        };
        modules = [
          ./host/desktop/configuration.nix 
          ./host/desktop/hardware-configuration.nix
          inputs.musnix.nixosModules.musnix
          inputs.spicetify-nix.nixosModules.default
          inputs.nix-snapd.nixosModules.default
          inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.chaotic.nixosModules.default
          # inputs.stylix.nixosModules.stylix 
        ];
      };

# ===== Laptop =====

      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./host/laptop/configuration.nix
          ./host/laptop/hardware-configuration.nix
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };

# ===== Closing Brackets =====

    };
  };
}

