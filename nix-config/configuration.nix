{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  boot.loader.timeout = 3;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;

  boot.loader.grub.theme = pkgs.stdenv.mkDerivation { # works, hail mary!!!
    pname = "distro-grub-themes";
    version = "3.1";
    src = pkgs.fetchFromGitHub {
      owner = "AdisonCavani";
      repo = "distro-grub-themes";
      rev = "v3.1";
      hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
    };
    installPhase = "cp -r customize/nixos $out";
  };

  # start-up commands
  powerManagement.powerUpCommands = "";

  # Hostname
  networking = {
    hostName = "mangrove";
    networkmanager.enable = true;
  }; 

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
  services.xserver.displayManager.setupCommands="${lib.getExe pkgs.xorg.xrandr} --output DP-2 --off"; # works, hail mary!!!
  services.displayManager.sddm.autoNumlock = true;

  # Enable Desktop Environment
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # services
  services = {
    flatpak.enable = true;
    emacs.enable = true;
    fwupd.enable = true;
  };
  # services.jack.jackd.enable = true;

  # programs.enable
  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
    };
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5";
      };
    };
  };

  # * terminal password
  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";
  
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
    noto-fonts-emoji
    fira-code-symbols
    migmix # Japanese Chars
    lxgw-wenkai # Chinese Chars
    (nerdfonts.override { fonts = [ "ZedMono" "JetBrainsMono" "0xProto" ]; })
  ];
 
  # Users
  users = {
    users.quentin = {
      isNormalUser = true;
      description = "quentin";
      extraGroups = [ "networkmanager" "wheel" "docker" "audio" "libvirtd"];
    };
    defaultUserShell = pkgs.zsh;
  };

  # Virt
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  virtualisation.libvirtd.enable = true;

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
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

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
    fortune-kind
    charasay
    lolcat
    # themes
    apple-cursor
    # gaming
    steam
    lutris
    bottles
    prismlauncher
    # productivity
    vscodium
    vesktop
    distrobox
    floorp
    git
    qastools
    musescore
    pavucontrol
    github-desktop
    obsidian
    angryipscanner
    qbittorrent
    virt-manager-qt
    # multimedia
    vlc
    handbrake
    makemkv
    libaacs
    libbluray
    freac
    spotify
    filebot
    # office
    libreoffice
    texliveFull
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_GB-ize
    # kde
    kdePackages.kdeconnect-kde
    kdePackages.isoimagewriter
    krusader
    # VMs
    qemu
    quickemu
    quickgui
    # POC/WIP
    blanket
    tmux
    nushell
    kitty
  ];
  
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "qbittorrent-4.6.4" ];
  };        

  # VPN POC (Für einen Monat gepayed)
  services.resolved.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # steam
  programs.steam = {
   enable = true;
   remotePlay.openFirewall = true;
   dedicatedServer.openFirewall = true; 
   localNetworkGameTransfers.openFirewall = true;
  };

  # ssh + ports
   networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];  
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ]; 
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
  nix.settings.experimental-features = [ "nix-command" ];
  nix.optimise.automatic = true;

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
    dates = "weekly";
  };

  system.stateVersion = "24.05"; 
}