{ config, pkgs, lib, ... }:

{

home.packages = with pkgs; [
    # The main application
    kdePackages.krusader

    # 1. Visuals & Icons
    kdePackages.breeze-icons       # Critical: Fixes invisible/missing toolbar icons
    kdePackages.breeze             # The default KDE theme engine

    # 2. File System & Network Protocols (KIO)
    kdePackages.kio-extras         # Required for sftp://, smb://, network://, and trash://
    kdePackages.kio-admin          # Crucial: Allows you to edit root files safely via PolicyKit (admin://)

    # 3. Internal Krusader Tools
    kdePackages.ktexteditor        # Powers Krusader's built-in text viewer (F3) and editor (F4)
    kdePackages.kompare            # Required for the "Compare by Content" feature
    kdePackages.kdoctools          # Required for the internal help/manuals to load

    # qt control outside of KDE
    # kdePackages.qt6ct

    # 4. Standard Archivers (Krusader expects these to be in your PATH)
    p7zip
    unrar
    zip
    unzip
    kdePackages.kget # DL manager 
    krename # rename util
    rar # rar archieves

    # auto mount??
    kio-fuse
    kdePackages.kio
  ];

  # Force Qt/KDE apps to play nicely with Cinnamon's GTK environment
  qt = {
    enable = true;
    platformTheme.name = "gtk";   # Tells Qt apps to inherit GTK colors/fonts where possible
    style.name = "breeze";        # Uses the Breeze style so Krusader renders properly
  };
}