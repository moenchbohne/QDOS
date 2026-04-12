{ ... }:

{
    home-manager.nixosModules.home-manager
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.quentin = import ./home/users/quentin/home.nix;
    home-manager.backupFileExtension = "bk";
    home-manager.extraSpecialArgs = {
      inherit inputs;
      inherit pkgs-stable;
    };
  }
}