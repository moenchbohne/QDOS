{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.cifs-utils ];

  # --- Synology Mount ---
  fileSystems."/home/quentin/synMOUNT" = {
    device = "//192.168.178.53/Quentin"; 
    fsType = "cifs";
    options = [ 
      "_netdev"
      "nofail"
      "x-systemd.mount-timeout=10s"

      "uid=1000" 
      "gid=100"

      "file_mode=0777"
      "dir_mode=0777"
      
      "credentials=/etc/secrets/syn.cred"

      "vers=2.0" 
    ];
  };

  # --- Western Digital Mount ---
  fileSystems."/home/quentin/wdMOUNT" = {
    device = "//192.168.178.143/media";
    fsType = "cifs";
    options = [ 
      "_netdev"
      "nofail"
      "x-systemd.mount-timeout=10s"

      "uid=1000" 
      "gid=100"

      "file_mode=0777"
      "dir_mode=0777"
      
      "credentials=/etc/secrets/wd.cred"

      "vers=3.0"
    ];
  };
}