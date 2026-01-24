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
      libva-vdpau-driver            
      libvdpau-va-gl
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

   environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";

    NVD_BACKEND = "direct";

    MOZ_DISABLE_RDD_SANDBOX = "1";
   };

   environment.systemPackages = with pkgs; [
    nvtop
   ];

   environment.sessionVariables = {

    # Electron Wayland Force
    NIXOS_OZONE_WL = "1";

    # Firefox Wayland
    MOZ_ENABLE_WAYLAND = "1"; 
  };
}