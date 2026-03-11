{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github/id_ed25519";
        identitiesOnly = true;
      };
    };

    
  };
}