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
      background-opacity = 0.95;
      background-blur-radius = 20;

      ### Window & Tabs ###
      window-padding-x = 4;
      window-padding-y = 4;
      # window-save-state = true;
      confirm-close-surface = false;

      ### Mouse & Selection ###
      copy-on-select = true;
      right-click-action = "context-menu";

      ### Shell Integration ###
      shell-integration = "detect";
      shell-integration-features = true;

      ### Desktop ###
      desktop-notifications = false;
      bell-features = "no-audio,no-visual";

      ### Keybinds ###
      keybind = [
        "ctrl+shift+t=new_tab"
        "ctrl+shift+w=close_surface"
        "ctrl+tab=next_tab"
        "ctrl+shift+right=move_tab:1"
        "ctrl+shift+left=move_tab:-1"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        "ctrl+shift+r=reload_config"
        "ctrl+plus=increase_font_size:1.5"
        "ctrl+minus=decrease_font_size:1.5"
        "ctrl+0=reset_font_size"
      ];
    };
  };
}