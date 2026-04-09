{
  config,
  pkgs,
  ...
}:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  environment.systemPackages = with pkgs; [
    jetbrains.idea-oss
  ];
}
