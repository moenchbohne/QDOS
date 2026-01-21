{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;

    # This copies your local ./pngs/logo.png to ~/.config/fastfetch/pngs/logo.png
    # when you run home-manager switch
    package = pkgs.fastfetch; # Ensure package is installed
  };

  # Handle the file placement separately
  xdg.configFile."fastfetch/pngs/logo.png".source = ./pngs/logo.png;

  programs.fastfetch.settings = {
    logo = {
      type = "auto";
      # We point directly to the file we just deployed above
      source = "${config.xdg.configHome}/fastfetch/pngs/logo.png";
      height = 25;
      padding = {
        right = 3;
        top = 1;
      };
    };

    display = {
      separator = " ➜ ";
    };

    modules = [
      {
        type = "custom";
        format = "  [シミュレーション] ";
        keyColor = "blue";
      }
      {
        type = "custom";
        format = "┌────────────────────────────────────────────────────┐";
      }
      {
        type = "chassis";
        key = "  󰇺 Chassis";
        format = "{1} {2} {3}";
      }
      {
        type = "os";
        key = "  󰣇 OS";
        format = "{3}";
        keyColor = "red";
      }
      {
        type = "kernel";
        key = "   Kernel";
        format = "{2}";
        keyColor = "red";
      }
      {
        type = "packages";
        key = "  󰏗 Packages";
        keyColor = "green";
      }
      {
        type = "shell";
        key = "   Shell";
        keyColor = "green";
      }
      {
        type = "display";
        key = "  󰍹 Display";
        format = "{1}x{2} @ {3}Hz [{7}]";
        keyColor = "magenta";
      }
      {
        type = "terminal";
        key = "   Terminal";
        keyColor = "yellow";
      }
      {
        type = "wm";
        key = "  󱗃 WM";
        format = "{2}";
        keyColor = "yellow";
      }
      {
        type = "custom";
        format = "└────────────────────────────────────────────────────┘";
      }
      "break"
      {
        type = "title";
        key = "  ";
        format = "{6} {7} {8}";
      }
      {
        type = "custom";
        format = "┌────────────────────────────────────────────────────┐";
      }
      {
        type = "cpu";
        format = "{1} @ {7}";
        key = "   CPU";
        keyColor = "blue";
      }
      {
        type = "gpu";
        format = "{1} {2}";
        key = "  󰊴 GPU";
        keyColor = "blue";
      }
      {
        type = "gpu";
        format = "{3}";
        key = "   GPU Driver";
        keyColor = "magenta";
      }
      {
        type = "memory";
        key = "   Memory ";
        keyColor = "magenta";
      }
      {
        type = "disk";
        key = "  🖴 Disk";
        keyColor = "cyan";
      }
      {
        type = "command";
        key = "  󱦟 OS Age ";
        keyColor = "red";
        # Note: We simplified the 'find' command since we know exactly where the file is now.
        text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
      }
      {
        type = "uptime";
        key = "  󱫐 Uptime ";
        keyColor = "red";
      }
      {
        type = "custom";
        format = "└────────────────────────────────────────────────────┘";
      }
      {
        type = "colors";
        paddingLeft = 20;
        symbol = "circle";
      }
      "break"
    ];
  };
}