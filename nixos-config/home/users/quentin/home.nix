{pkgs, ...}: {
  home = {
    username = "quentin";
    homeDirectory = "/home/quentin";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    zettlr
  ];

  imports = [
    ../../../modules/user/rofi/default.nix
    ../../../modules/user/git/default.nix
    ../../../modules/user/uni-util/default.nix
    ../../../modules/user/shell_env/default.nix
    ../../../modules/user/flameshot/default.nix
    ../../../modules/user/thunderbird/default.nix
    ../../../modules/user/terminal/default.nix
    ../../../modules/user/zed/default.nix
  ];
}
