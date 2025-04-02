{ config, lib, pkgs, pkgs-stable, inputs, ... }:

{
  imports = [
    ./modules/hardware-configuration.nix
    ./modules/cli.nix
    ./modules/virtualization.nix
    ./modules/java.nix
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

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true; 
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    virt-manager.enable = true;
    gamemode.enable = true;
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

  # Nvidia / Graphics 
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = with pkgs; [ 
      libva
      vulkan-loader
      driversi686Linux.amdvlk
    ];
    extraPackages = with pkgs; [ 
      # nvidia-vaapi-driver 
      vulkan-loader
      amdvlk 
    ];
  };
  services.xserver.videoDrivers = [ 
    # "nvidia" 
    "amdgpu" 
  ];
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   powerManagement.enable = true;
  #   powerManagement.finegrained = false;
  #   open = false;
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };

  # ===== Env Vars =====
  environment.variables = {
    DRI_PRIME = 1;
  };

  # List packages installed in system profile. 
  environment.systemPackages =

    # rolling release
    (with pkgs; [
      # POC/WIP
      wofi
      zellij
      nushell
      ghostty
      inputs.zen-browser.packages."${system}".specific
      # cli-util
      emacs-nox
      kitty
      starship
      ani-cli
      alsa-utils
      btop
      appimage-run
      git
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
      # gaming
      # lutris
      prismlauncher
      mangohud
      ryujinx-greemdev
      protonup
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
      spotify
      puddletag
      foliate
      ffmpeg
      scdl
      mixxx
      # python
      python3
      # office
      libreoffice
      texliveFull
      hunspell
      hunspellDicts.de_DE
      hunspellDicts.en_GB-ize
      # kde
      kdePackages.isoimagewriter
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
      freac
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

  # spicetify
  programs.spicetify =
   let
     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
   in
   {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      betterGenres
      addToQueueTop
     ];
     theme = lib.mkForce spicePkgs.themes.sleek;
     # colorScheme = "mocha";
   };

  # stylix
  stylix = {
    
    enable = true;
    image = ./red-sunset.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    targets.gtk.enable = true;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Emoji";
      };
    };

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 12;
    };
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
