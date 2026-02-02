{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.cifs-utils ];

  # mount Synology
  fileSystems."/home/quentin/synMOUNT" = {
    device = "//192.168.178.X/ShareName";
    fsType = "cifs";
    options = [ 
      # SYSTEMD BOOT BEHAVIOR
      "_netdev"                  # Wait for network before mounting
      "nofail"                   # Continue booting even if this mount fails
      "x-systemd.mount-timeout=10s" # Don't wait 90s (default) if server is down; fail fast

      # PERMISSIONS
      "uid=1000" 
      "gid=100"
      
      # CREDENTIALS
      "credentials=./syn.cred"
    ];
  };


  # mount Western Digital
  fileSystems."/home/quentin/wdMOUNT" = {
    device = "//192.168.178.X/ShareName";
    fsType = "cifs";
    options = [ 
      # SYSTEMD BOOT BEHAVIOR
      "_netdev"                  # Wait for network before mounting
      "nofail"                   # Continue booting even if this mount fails
      "x-systemd.mount-timeout=10s" # Don't wait 90s (default) if server is down; fail fast

      # PERMISSIONS
      "uid=1000" 
      "gid=100"
      
      # CREDENTIALS
      "credentials=./wd.cred"
    ];
  };
}