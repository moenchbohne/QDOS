{ config, lib, pkgs, pkgs-stable, inputs, ... }:

{
  imports = [
    ./modules/hardware-configuration.nix
    ./modules/cli.nix
    ./modules/virtualization.nix
    ./modules/java.nix
    ./modules/gaming.nix
    ./modules/spotify.nix
    ./modules/graphics/amd.nix
  ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  boot.loader.timeout = 3;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [
    "sg" # SCSI for BlueRay
  ];

  # GRUB Theme

  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
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

  # Network
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

  # SDDM / Login
  services.xserver.displayManager.setupCommands="${lib.getExe pkgs.xorg.xrandr} --output DP-2 --off";
  services.displayManager.sddm.enable = true;

  # KDE
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
    kate
  ];

  # XFCE
  services.xserver = {
    enable = true;
    xkb.layout = "de";

    desktopManager.xfce = {
      enable = true;
      noDesktop = false;
      enableXfwm = true;
    };
  };

  # Configure console keymap
  console.keyMap = "de";

  # services.enable
  services = {
    emacs.enable = true;
    fwupd.enable = true;
    snap.enable = true;
  };

  # programs.enable
  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 16";
      };
    };

    firefox = {
      enable = true;
      package = pkgs.floorp;
    };

    kdeconnect.enable = true;
    adb.enable = true;
    vim.enable = true;
  };

  security ={
    sudo.extraConfig = "Defaults env_reset,pwfeedback"; # * terminal password
    rtkit.enable = true;
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

  # sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  # musnix
  musnix.enable = true;
 
  # User / quentin
  users = {
    defaultUserShell = pkgs.zsh;
    users.quentin = {
      isNormalUser = true;
      description = "quentin";
      extraGroups = [ 
        "audio" 
        "gamemode"  
        "networkmanager" 
        "wheel" 
        "mpd"
        "adbusers kvm"
      ];
    };
  };

  # List packages installed in system profile. 
  environment.systemPackages =
  # let
  #   doom-emacs = inputs.nix-doom-emacs.packages."${pkgs.system}".default.override { 
  #     doomPrivateDir = ../dotfiles/doom.d; 
  #   };
  # in

    # rolling release
    (with pkgs; [
      # POC/WIP
      # doom-emacs
      wofi
      zellij
      nushell
      ghostty
      # cli-util
      emacs-nox
      kitty
      starship
      ani-cli
      alsa-utils
      btop
      appimage-run
      git
      git-filter-repo
      ncmpcpp
      # big three + fzf
      zoxide
      eza
      bat
      fzf
      # unixp*rn
      starfetch
      fastfetch
      countryfetch
      cbonsai
      unimatrix
      pokeget-rs
      pipes-rs
      fortune-kind
      charasay
      lolcat
      snowmachine
      # themes + rice
      catppuccin-sddm
      base16-schemes
      sddm-astronaut
      # productivity
      localsend
      kando
      vscodium
      yazi
      musescore
      pavucontrol
      github-desktop
      angryipscanner
      qbittorrent-enhanced
      nicotine-plus
      gparted
      # creative
      darktable
      reaper
      tenacity
      # multimedia
      vlc
      handbrake
      makemkv
      libaacs
      libbluray
      puddletag
      foliate
      ffmpeg
      scdl
      asunder
      # mixxx
      # python
      python3
      # office
      libreoffice
      texliveFull
      (aspellWithDicts (dicts: with dicts; [
        de
        en
        en-computers
        en-science
      ]))
      # kde
      kdePackages.isoimagewriter
      kdePackages.audex
      # (vst) plugins 
      oxefmsynth
    ])

    ++

    # stable release
    (with pkgs-stable; [
      flacon
      qemu
      quickemu
      bottles
    ]);



  nixpkgs.config = {
    allowUnfree = true;
  };        

  # VPN
  services.resolved.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # Flatpak
  services.flatpak = {
    enable = true;
    remotes = [{ name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }];
  };

  qt =  {
    enable = true;
    platformTheme = lib.mkForce "kde";
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts-emoji
    fira-code-symbols
    migmix # Japanese Chars
    lxgw-wenkai # Chinese Chars
    nerd-fonts.jetbrains-mono # Terminal Font
  ];

  # ssh + ports
   networking.firewall = { 
    enable = true;
    # TCP
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedTCPPorts = [ 445 139 53317 ];
    # UDP
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPorts = [ 137 138 53317 ]; 
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
  nix = {
    settings.experimental-features = [ "flakes" "nix-command" ];
    optimise.automatic = true;
  };

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
    dates = "weekly";
  };

  system.stateVersion = "24.05"; 
}
