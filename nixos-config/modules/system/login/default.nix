{ config, lib, pkgs, ... }:

# ===== ===== ===== Using regreet for now ===== ===== =====$

let
  # --- ASSETS & THEME CONFIGURATION ---
  # Define these here so you can swap themes quickly in one place.

  # 1. Background Image
  # Replace with your actual path: ./wallpapers/my-image.png
  # Or use a built-in one for testing:
  wallpaper = pkgs.nixos-icons + "/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

  # 2. Visual Styling (Dark Mode & Modern Cursors)
  # "Bibata" is a very popular, smooth cursor for Wayland.
  cursorThemeName = "Bibata-Modern-Classic";
  cursorThemePkg = pkgs.bibata-cursors;

  fontName = "Inter";
  fontPkg = pkgs.inter;

  # "Adwaita-dark" is the most stable/tested GTK4 theme for ReGreet.
  gtkThemeName = "Adwaita-dark";
  gtkThemePkg = pkgs.gnome-themes-extra; 

  iconThemeName = "Papirus-Dark";
  iconThemePkg = pkgs.papirus-icon-theme;
in
{
  # --- Keyboard & Input Fixes ---
  # Ensure the system and the greeter know we are using German layout
  services.xserver.xkb.layout = "de";
  environment.variables.XKB_DEFAULT_LAYOUT = "de";

  # --- REGREET CONFIGURATION ---
  # This module automatically configures 'greetd' and 'cage' (the compositor) for you.
  programs.regreet = {
    enable = true;

    # --- THEME SETTINGS ---
    theme = {
      package = gtkThemePkg;
      name = gtkThemeName;
    };
    iconTheme = {
      package = iconThemePkg;
      name = iconThemeName;
    };
    cursorTheme = {
      package = cursorThemePkg;
      name = cursorThemeName;
    };
    font = {
      package = fontPkg;
      name = fontName;
      size = 16;
    };

    # --- BEHAVIOR & APPEARANCE (settings.toml) ---
    settings = {
      background = {
        path = wallpaper;
        fit = "Cover"; # Options: Fill, Contain, Cover, ScaleDown
      };

      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = cursorThemeName;
        font_name = "${fontName} 16";
        icon_theme_name = iconThemeName;
        theme_name = gtkThemeName;
      };

      commands = {
        reboot = [ "systemctl" "reboot" ];
        poweroff = [ "systemctl" "poweroff" ];
      };
    };

    # --- COMPOSITOR SETTINGS (Stability) ---
    # These arguments are passed to 'cage' (the lightweight Wayland compositor).
    # -s: Enables VT switching (Crucial! Allows you to switch to TTY if login freezes)
    # -m last: Runs the greeter on the last connected monitor (Fixes laptop/dock issues)
    cageArgs = [ "-s" "-m" "last" ];
  };

  # --- SYSTEM INTEGRATION ---

  # 1. Keyring Support (Platform Agnostic)
  # Allows automatic unlocking of Gnome Keyring and KWallet upon login.
  # Essential for a smooth experience in both Gnome and KDE.
  security.pam.services.greetd.enableGnomeKeyring = true;
  # Note: KWallet PAM integration is often handled by the desktop manager service,
  # but ensuring greetd has valid PAM entry is good.

  # 2. Dependencies
  # Ensure the themes and fonts are actually installed system-wide so ReGreet can read them.
  environment.systemPackages = [
    cursorThemePkg
    fontPkg
    gtkThemePkg
    iconThemePkg
  ];

  # 3. Disable competing Display Managers
  # This ensures SDDM and GDM don't fight for control of the screen.
  services.displayManager.sddm.enable = lib.mkForce false;
  services.xserver.displayManager.gdm.enable = lib.mkForce false;
  
  # 4. Fallback TUI
  # If ReGreet ever breaks, you can uncomment this to fallback to a text greeter:
  # services.greetd.settings.default_session.command = lib.mkForce "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.bash}/bin/bash";
}