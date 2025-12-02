{ lib, config, pkgs, ... }: 

{
  # core gnome config
  services.displayManager.gdm.enable = true;
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
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.arc-menu
    gnomeExtensions.vitals

    # gnome packages
    gnome-extension-manager
  ];

  # fix for seahorse
  programs.ssh.askPassword = lib.mkForce true;
}