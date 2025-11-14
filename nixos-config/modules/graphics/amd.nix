{ config, pkgs, lib, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = with pkgs; [ 
      libva
      vulkan-loader
      driversi686Linux.amdvlk
      driversi686Linux.mesa
    ];
    extraPackages = with pkgs; [ 
      vulkan-loader
      mesa
      amdvlk 
    ];
  };
  services.xserver.videoDrivers = [  
    "amdgpu" 
  ];

  hardware.amdgpu = {
    opencl.enable = true;
    legacySupport.enable = true;
  };
}