{pkgs, ...}: {
  home.packages = with pkgs; [
    # === Utils ===
    dnsutils
    wireshark
    toybox
    inetutils

    # === browser ===
    librewolf

    # === scan ===
    nmapzen
  ];
}
