{ inputs, pkgs-stable, ... }:

{
  # 1. Import the Home Manager NixOS module
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # 2. Define the Home Manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    
    # Pass your special args down to Home Manager
    extraSpecialArgs = {
      inherit inputs pkgs-stable;
    };

    # NOTE: Adjust this path depending on where you save this module!
    # If this file is in ./common/home-manager.nix, the path below should step back up.
    users.quentin = import ../../../home/users/quentin/home.nix; 
  };
}