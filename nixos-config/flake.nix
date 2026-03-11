{
  # ===== Description =====

  description = "My Little Snowflake";

  # ===== Inputs =====

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix.url = "github:musnix/musnix";

    stylix.url = "github:danth/stylix";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ===== Outputs =====

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:
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

      nixosConfigurations = {

        # ===== Desktop =====

        mangrove = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/desktop/configuration.nix
            ./hosts/desktop/hardware-configuration.nix
            inputs.spicetify-nix.nixosModules.default
            inputs.nix-snapd.nixosModules.default
            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.chaotic.nixosModules.default
            # inputs.stylix.nixosModules.stylix
            inputs.musnix.nixosModules.musnix
          ];
        };

        # ===== Laptop =====

        poplar = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/laptop/configuration.nix
            ./hosts/laptop/hardware-configuration.nix

            # HW and spicetify modules
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
            inputs.spicetify-nix.nixosModules.default

            # fucking HM magic
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.quentin = import ./home/users/quentin/home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit pkgs-stable;
              };
            }
          ];
        };

        # ===== Work =====

        hci_quentin = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit pkgs-stable;
          };
          modules = [
            ./hosts/work/configuration.nix
            ./hosts/work/hardware-configuration.nix

            # fucking HM magic
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.quentin = import ./home/users/quentin/home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit pkgs-stable;
              };
            }
          ];
        };
      };
    };
}
