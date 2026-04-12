{pkgs, ...}: {
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github/id_ed25519";
        identitiesOnly = true;
      };
      "192.168.xyz.abc" = {
        user = "admin";
        identityFile = "~/.ssh/suse_at_hci/id_ed25519";
        identitiesOnly = true;
      };
    };
  };
}
