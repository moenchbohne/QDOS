{ config, pkgs, ... }:

# AI-Generated

{
  # Enable Samba service
  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      map to guest = Bad User
      guest account = nobody
    '';
    
    shares = {
      transfer = {
        path = "/srv/samba/transfer";
        "guest ok" = "yes";
        "read only" = "no";
        "browseable" = "yes";
        "create mask" = "0666";
        "directory mask" = "0777";
      };
    };
  };

  # Open firewall ports for Samba
  networking.firewall = {
    allowedTCPPorts = [ 445 139 137 ];
    allowedUDPPorts = [ 137 138 ];
  };
}