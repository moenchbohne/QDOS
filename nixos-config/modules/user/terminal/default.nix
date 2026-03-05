{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    systemd = {
      enable = true;
    };

    settings = {
      ### Font & Appearance ###
      font-family = "JetBrains Mono";
      font-size = 12;
      background-opacity = 0.26;
      background-blur-radius = 20;

      ### Window & Tabs ###
      window-padding-x = 4;
      window-padding-y = 4;
      confirm-close-surface = false;

      ### Mouse & Selection ###
      copy-on-select = true;
      right-click-action = "context-menu";

      ### Shell Integration ###
      shell-integration = "detect";
      shell-integration-features = true;

      ### Desktop ###
      desktop-notifications = false;
      bell-features = "no-audio";

      ### Keybinds ###
      keybind = [
        "ctrl+shift+t=new_tab"
        "ctrl+shift+w=close_surface"
        "ctrl+tab=next_tab"
        "ctrl+shift+right=next_tab"
        "ctrl+shift+left=previous_tab"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        "ctrl+shift+a=select_all"
        "ctrl+shift+r=reload_config"
        "ctrl+plus=increase_font_size:1.5"
        "ctrl+minus=decrease_font_size:1.5"
        "ctrl+0=reset_font_size"
      ];
    };
  };
}