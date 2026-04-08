{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../modules/system/boot/plymouth.nix
    # ../../modules/system/kdeConnect/default.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # NVIDIA
  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_535;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = with pkgs; [
      libva
      driversi686Linux.libva-vdpau-driver
    ];
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  networking.hostName = "quentinHCI";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };

  programs.kdeconnect = {
    enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
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
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # media-session.enable = true;
  };

  services.libinput.enable = true;

  users.users.quentin = {
    isNormalUser = true;
    description = "quentin";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Install firefox.
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    micro-full
    krusader
    github-desktop
    gparted
    git # why tf not installed by default???

    # moved over from old
    nh
    onlyoffice-desktopeditors
    popsicle
    vlc
    pritunl-client

    # editor war
    lapce
    cudatext
    obsidian

    kdePackages.isoimagewriter
  ];

  # GUI for OVPN
  systemd.packages = [
    pkgs.pritunl-client
  ];
  systemd.targets.multi-user.wants = [
    "pritunl-client.service"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
