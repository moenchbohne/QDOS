{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  boot = {

    plymouth = {
      enable = true;
      theme = "ibm";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" "ibm" "blockchain" ];
        })
      ];
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "poplar"; 
  # networking.wireless.enable = true; 

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.lightdm.greeters.slick.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit 
    epiphany
  ]);

  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # services.xserver.libinput.enable = true;
  services.emacs.enable = true;

  # Define a user account.
  users = {
    users.quentin = {
      isNormalUser = true;
      description = "quentin";
      extraGroups = [ "audio" "networkmanager" "wheel" ];
    };
    defaultUserShell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vesktop
    vscodium
    spotify
    obsidian
    kitty
    git
    prismlauncher
    vlc
    musescore
    floorp
    angryipscanner
    github-desktop
    blueman
    mkvtoolnix
    puddletag
    flacon
    foliate
    # gnome
    apple-cursor
    gnome-tweaks
    gnome-extension-manager
    # kde
    kdePackages.filelight
    valent
    # cli
    charasay
    fortune-kind
    lolcat
    pokeget-rs
    pipes-rs
    cbonsai
    fastfetch
    emacs
    starship
    pokeget-rs
    btop
    stow
    ani-cli
    unimatrix
    yazi
    tldr
    bat
    nh
    aha
    pciutils
    appimage-run
    # python
    python3
    # office
    libreoffice
    hunspell
    hunspellDicts.en_GB-ize
    hunspellDicts.de_DE
    texliveFull
    texstudio
    # POC
    parsec-bin
    pipx
    mpv
    qbittorrent
    eza
    powertop
    # nushell POC
    nushell
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "qbittorrent-4.6.4"
  ];

  # VPN
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  services.resolved.enable = true;

  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";

  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.jetbrains-mono
    nerd-fonts.zed-mono
  ];

  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUser = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  # nix settings

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
    dates = "weekly";
  };

  system.stateVersion = "24.05";

}
