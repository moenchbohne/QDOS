{ lib, config, pkgs, ... }: 

{
  # gdm config
  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "gnome";

  # core gnome config
  services.desktopManager.gnome = {
    enable = true;
  };

  services.gnome = {
    core-apps.enable = true;
    core-developer-tools.enable = false;
    games.enable = false;
  };

  # exclude packages
  environment.gnome.excludePackages = with pkgs; [
    # MT
  ];

  # gnome shell extensions
  environment.systemPackages = with pkgs; [
    # shell extensions
      # MT

    # gnome packages
    gnome-extension-manager
    gnome-tweaks
  ];

  # fix for seahorse
  programs.ssh.askPassword = lib.mkForce "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
}