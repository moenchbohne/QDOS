{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.cifs-utils ];

  # --- Synology Mount ---
  fileSystems."/home/quentin/synMOUNT" = {
    device = "//192.168.178.20/SynologyShareName"; 
    fsType = "cifs";
    options = [ 
      "_netdev"
      "nofail"
      "x-systemd.mount-timeout=10s"

      "uid=1000" 
      "gid=100"
      
      "credentials=/etc/secrets/syn.cred"

      "vers=2.0" 
    ];
  };

  # --- Western Digital Mount ---
  fileSystems."/home/quentin/wdMOUNT" = {
    device = "//192.168.178.30/WDShareName";
    fsType = "cifs";
    options = [ 
      "_netdev"
      "nofail"
      "x-systemd.mount-timeout=10s"

      "uid=1000" 
      "gid=100"
      
      "credentials=/etc/secrets/wd.cred"

      "vers=3.0"
    ];
  };
}