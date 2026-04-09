{
  config,
  pkgs,
  ...
}:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  environment.systemPackages = with pkgs; [
    jetbrains.idea-oss
  ];
}
