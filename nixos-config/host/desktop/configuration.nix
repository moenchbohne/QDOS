{ config, lib, pkgs, pkgs-stable, inputs, ... }:

{
  imports = [
    ../../modules/cli.nix
    ../../modules/virtualization.nix
    ../../modules/java.nix
    ../../modules/gaming.nix
    ../../modules/daw.nix
    ../../modules/uni.nix
    ../../modules/graphics/amd.nix
    ../../modules/apps/mullvad.nix
    ../../modules/apps/krusader.nix
    ../../modules/apps/spotify.nix
    ../../modules/kde.nix
  ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  boot.loader.timeout = 3;
  # boot.kernelPackages = pkgs.linuxPackages_6_16;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.initrd.kernelModules = [ 
    "amdgpu"
    # -----
    "vmd"
    "nvme"
    "ahci"
    "sd_mod" 
  ];
  boot.initrd.availableKernelModules = [
    "vmd"
    "nvme"
    "ahci"
    "sd_mod"
  ];
  boot.kernelModules = [
    "sg" # SCSI for BlueRay
  ];
  
  # Please Fix 
  hardware.enableRedistributableFirmware = true;

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

  # XFCE
  services.xserver = {
    enable = true;
    xkb.layout = "de";
  };

  # Configure console keymap
  console.keyMap = "de";

  # services.enable
  services = {
    emacs.enable = true;
    fwupd.enable = true;
    # snap.enable = true;
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
      package = pkgs.floorp-bin;
    };

    adb.enable = true;
    vim.enable = true;
  };

  security ={
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

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-gtk3-1.1.07"
    "electron-36.9.5"
  ];

  # List packages installed in system profile. 
  environment.systemPackages =
    # rolling release
    (with pkgs; [
      # POC/WIP
      opensoundmeter
      wofi
      zellij
      nushell
      ghostty
      ventoy-full-gtk
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
      asciiquarium-transparent
      # themes + rice
      catppuccin-sddm
      base16-schemes
      sddm-astronaut
      # productivity
      masterpdfeditor4
      localsend
      kando
      vscodium
      yazi
      musescore
      pavucontrol
      github-desktop
      # angryipscanner
      qbittorrent-enhanced
      nicotine-plus
      picard
      slsk-batchdl
      kid3-qt
      aonsoku
      feishin
      gparted
      # creative
      darktable
      audacity
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
      onlyoffice-desktopeditors
      texliveFull
      (aspellWithDicts (dicts: with dicts; [
        de
        en
        en-computers
        en-science
      ]))
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
    noto-fonts-color-emoji
    fira-code-symbols
    migmix # Japanese Chars
    lxgw-wenkai # Chinese Chars
    nerd-fonts.jetbrains-mono # Terminal Font
    maple-mono.NL-CN # Mono Space 
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
