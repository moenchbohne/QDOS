{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme1n1";
  boot.loader.grub.useOSProber = true;

  boot = {
    plymouth = {
      enable = true;
      theme = "blockchain";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "ibm" "blockchain" "pixels" ];
        })
      ];
    };
  };

  # Kernel
  # boot.kernelPackages = pkgs.linuxPackages_zen;

  # Hostname
  networking.hostName = "mangrove"; 

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

  # SDDM config
  services.displayManager.sddm.enable = true;
  services.xserver.displayManager.setupCommands="${lib.getExe pkgs.xorg.xrandr} --output DP-2 --off";
  services.displayManager.sddm.autoNumlock = true;

  # Enable Desktop Environment
  services.desktopManager.plasma6.enable = true;

  # shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.nushell.enable = true;
  programs.powershell.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Services
  services.flatpak.enable = true;
  services.emacs.enable = true;
  services.fwupd.enable = true;
  # services.jack.jackd.enable = true;

  # * terminal password
  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";
  
  # coolercontrol
  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };

  # printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # bluetooth
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
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
  sound.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "ZedMono" "0xProto" ]; })
  ];
 
  # Define a user 
  users.users.quentin = {
    isNormalUser = true;
    description = "quentin";
    extraGroups = [ "networkmanager" "wheel" "docker" "audio" "libvirtd"];
  };

  # Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Podman
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Waydroid
  virtualisation.waydroid.enable = true;

  # virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Nvidia / Graphics 
  hardware.opengl = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy;
  };
  programs.coolercontrol.nvidiaSupport = true;

  # List packages installed in system profile. 
  environment.systemPackages = with pkgs; [
    # cli-util
    emacs
    alacritty
    starship
    ani-cli
    alsa-utils
    btop
    appimage-run
    thefuck
    # big three + fzf
    zoxide
    eza
    bat
    fzf
    # unixp*rn
    fastfetch
    cbonsai
    unimatrix
    pokeget-rs
    pipes-rs
    # gaming
    steam
    lutris
    bottles
    prismlauncher
    # productivity
    vscodium
    vesktop
    distrobox
    brave
    whatsapp-for-linux
    git
    qemu
    quickemu
    qastools
    musescore
    pavucontrol
    qbittorrent
    kdePackages.isoimagewriter
    spotify
    # multimedia
    vlc
    handbrake
    makemkv
    libaacs
    libbluray
    freac
    # office
    libreoffice
    texliveFull
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_GB-ize
    # kde
    kdePackages.kdeconnect-kde
  ];

  # steam
  programs.steam = {
   enable = true;
   remotePlay.openFirewall = true;
   dedicatedServer.openFirewall = true; 
   localNetworkGameTransfers.openFirewall = true;
  };

  # network
   networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];  
    allowedUDPPortRanges = allowedTCPPortRanges;  
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; 
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  # nix config
  # nix.settings.experimental-features = [ "nix-command" "flakes"];
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  system.autUpgrade = {
    enable = true;
    channel = "hhtps://nixos.org/channels/nixos-unstable";
    dates = "weekly";
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05"; 
}
