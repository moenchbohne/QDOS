{ config, pkgs, lib, ... }:

{  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = with pkgs; [ 
      libva
      vulkan-loader
      driversi686Linux.libva-vdpau-driver
      driversi686Linux.mesa
    ];
    extraPackages = with pkgs; [ 
      nvidia-vaapi-driver 
      vulkan-loader
      mesa 
    ];
  };

  services.xserver.videoDrivers = [ 
    "nvidia"  
  ];

  hardware.nvidia = {
     modesetting.enable = true;
     powerManagement.enable = true;
     powerManagement.finegrained = false;
     open = false;
     nvidiaSettings = true;
     package = config.boot.kernelPackages.nvidiaPackages.stable;
   };
}