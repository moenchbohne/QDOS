{...}: {
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "*"={
        
      };

      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github/id_ed25519";
        identitiesOnly = true;
      };
      "gitlab.com" = {
        user = "git";
        identityFile = "~/.ssh/gitlab/id_ed25519";
        identitiesOnly = true;
      };
      "*.hci.uni-hannover.de 192.168.2.*" = {
        user = "hci_admin";
        identityFile = "~/.ssh/hci/id_ed25519";
        identitiesOnly = true;
        addKeysToAgent = "yes";
      };
    };
  };

  # persistent ssh private keys
  services.ssh-agent.enable = true;
}
