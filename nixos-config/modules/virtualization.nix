{ config, pkgs, ... }:

# AI-Generated

{
  virtualisation = {
    # Enable Podman with Docker compatibility layer
    podman = {
      enable = true;
      dockerCompat = true; # Create `docker` alias for Podman
      defaultNetwork.settings.dns_enabled = true;
      autoPrune = { # Automatic cleanup
        enable = true;
        dates = "weekly";
      };
    };

    # Libvirt (Virt Manager/QEMU backend)
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true; # Run QEMU with root privileges
        swtpm.enable = true; # TPM emulation support
      };
    };
  };

  # Enable necessary kernel modules
  boot.kernelModules = [ "kvm-amd" "kvm-intel" "vhost_net" ];
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
  '';

  # Virtualization packages
  environment.systemPackages = with pkgs; [
    virt-manager # GUI for managing virtual machines
    libvirt-glib # Libvirt GLib bindings
    spice # SPICE protocol support
    spice-gtk # SPICE client
    win-spice # Windows SPICE tools
    virt-viewer # VM viewer
    
    # QEMU and related tools
    qemu_kvm
    qemu-utils # qemu-img, qemu-io, etc
    
    # Container tools
    docker-compose
    podman-compose
  ];

  # User groups for virtualization access
  users.users.quentin = {
    extraGroups = [
      "libvirtd" # Libvirt group
      "kvm" # KVM acceleration
      "qemu-libvirtd" # QEMU permissions
    ];
  };

  # Enable DNS resolution in containers
  services.resolved.enable = true;

  # Optional: Enable firewall for Docker/Podman
  networking.firewall = {
    trustedInterfaces = [ "podman0" ];
  };
}