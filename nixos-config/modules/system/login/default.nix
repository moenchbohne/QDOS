{ config, lib, pkgs, ... }:

# ===== ===== ===== Using regreet for now ===== ===== =====$

let
  # 1. Background Image
  wallpaper = ./0016.jpg;

  # 2. Visual Styling (Dark Mode & Modern Cursors)
  cursorThemeName = "Bibata-Modern-Classic";
  cursorThemePkg = pkgs.bibata-cursors;

  fontName = "Inter";
  fontPkg = pkgs.inter;

  gtkThemeName = "Adwaita-dark";
  gtkThemePkg = pkgs.gnome-themes-extra; 

  iconThemeName = "Adwaita";
  iconThemePkg = pkgs.adwaita-icon-theme;
in
{
  # --- Keyboard & Input Fixes ---
  services.xserver.xkb.layout = "de";
  environment.variables.XKB_DEFAULT_LAYOUT = "de";

  # --- REGREET CONFIGURATION ---
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
        fit = "Cover"; # Fill, Contain, Cover, ScaleDown
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

  environment.sessionVariables = {
    # This tells GNOME Settings that it is running on GNOME, 
    # fixing the crash/hang issue.
    XDG_CURRENT_DESKTOP = "GNOME";
  };

  # Also ensure dconf is enabled, as it is strictly required for 
  # GNOME Settings to save/read changes.
  programs.dconf.enable = true;

  # 1. Keyring Support (Platform Agnostic)
  # Allows automatic unlocking of Gnome Keyring and KWallet upon login.
  # Essential for a smooth experience in both Gnome and KDE.
  security.pam.services.greetd.enableGnomeKeyring = true;
  # Note: KWallet PAM integration is often handled by the desktop manager service,
  # but ensuring greetd has valid PAM entry is good.

  # 2. Dependencies
  environment.systemPackages = [
    cursorThemePkg
    fontPkg
    gtkThemePkg
    iconThemePkg
  ];

  # 3. Disable competing Display Managers
  services.displayManager.sddm.enable = lib.mkForce false;
  services.displayManager.gdm.enable = lib.mkForce false;
  
  # 4. Fallback TUI
  # services.greetd.settings.default_session.command = lib.mkForce "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.bash}/bin/bash";
}