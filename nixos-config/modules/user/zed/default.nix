{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
    ];

    userSettings = {
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      lsp = {
        nil = {
          binary = {
            path = {
            /run/current-system/sw/bin/nil
            };
          };
        };
        nixd = {
          binary = {
            path = {
            /run/current-system/sw/bin/nil
            };
          };
        };
      };
    };
  };
}
