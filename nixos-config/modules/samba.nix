{ config, pkgs, ... }:

# AI-Generated

{
  # Enable Samba service
  services.samba = {
    enable = true;
    settings.global.security = "user";

    settings = {
      public = {
        path = "/home/quentin/Downloads";
        public = "yes";
        browseable = "yes";
        writable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "force user" = "quentin";
     };
    };
  };

  # Open firewall ports for Samba
  networking.firewall = {
    allowedTCPPorts = [ 445 139 137 ];
    allowedUDPPorts = [ 137 138 ];
  };
}