{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (flameshot.override { enableWlrSupport = true; })
  ];
}