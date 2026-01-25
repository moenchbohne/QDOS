  { config, lib, pkgs, ... }:
  
  {
    imports = [
      ./plymouth.nix
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/nvme0n1";
    boot.loader.grub.useOSProber = true;
    boot.loader.timeout = 5;
    boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;
    boot.initrd.kernelModules = [ 
      "vmd"
      "nvme"
      "ahci"
      "sd_mod"
    ];

    boot.initrd.availableKernelModules = [
      "vmd"
      "nvme"
      "ahci"
      "sd_mod"
    ];

    boot.kernelModules = [
      "sg" # SCSI for BlueRay
    ];
  }