{ config, pkgs, lib, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = with pkgs; [ 
      libva
      vulkan-loader
      driversi686Linux.mesa
    ];
    extraPackages = with pkgs; [ 
      vulkan-loader
      mesa
    ];
  };
  services.xserver.videoDrivers = [  
    "amdgpu" 
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.amdgpu = {
    opencl.enable = true;
    legacySupport.enable = true;
  };
}