{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-fhs;

    extensions = [
      "nix"
    ];

    extraPackages = with pkgs; [
      # nix fucking rocks
      nixd
      nil
      nixfmt

      # toml + yaml
      taplo
      yaml-language-server

      # python
      pyright
      ruff
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
        };
        nixd = {
        };
      };
    };
  };
}
