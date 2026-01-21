{ config, lib, pkgs, ... }:

{
  programs.starship = {
    enable = true;

    enableNushellIntegration = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      palette = "light";

      # The prompt format string
      # We use lib.concatStrings for clarity to replicate the multi-line logic
      format = builtins.concatStringsSep "" [
        "[╭╴](fg:arrow)"
        "$username"
        "$directory"
        "$time"
        "("
        " $git_branch"
        " $git_status"
        ")"
        "("
        " $python"
        " $conda"
        " $nodejs"
        ")"
        "$cmd_duration"
        "\n" # The line break before the character
        "[╰─](fg:arrow)$character"
      ];

      # PALETTES
      palettes = {
        old = {
          arrow = "#353535";
          os = "#3778BF";
          os_admin = "#6A040F";
          directory = "#3F37C9";
          node = "green";
          time = "#177E89";
          git = "#B02B10";
          git_status = "#8B1D2C";
          python = "#3776AB";
          conda = "#3EB049";
          java = "#861215";
          rust = "#C33C00";
          clang = "#00599D";
          duration = "yellow";
          text_color = "#EDF2F4";
          text_light = "#EDF2F4";
        };
        normal = {
          arrow = "#353535";
          os = "#2C3032";
          os_admin = "#6A040F";
          directory = "#363C3E";
          time = "#474D5C";
          node = "#F1DEA9";
          git = "#D0DBDA";
          git_status = "#DFEBED";
          python = "#F5CB5C";
          conda = "#3EB049";
          java = "#861215";
          rust = "#C33C00";
          clang = "#00599D";
          duration = "#F4FBFF";
          text_color = "#EDF2F4";
          text_light = "#26272A";
        };
        light = {
          arrow = "#BF40BF";
          os = "#F7768E";
          os_admin = "#ACBEF1";
          directory = "#FF9578";
          time = "#FFDC72";
          git = "#F5F5F5";
          git_status = "#72FFD5";
          clang = "#67E3FF";
          java = "#FF52A3";
          python = "#B4F9F8";
          node = "#81FF85";
          conda = "#BAF5C0";
          duration = "#91FFE7";
          text_color = "#26272A";
          text_light = "#26272A";
        };
      };

      # MODULE SETTINGS

      username = {
        style_user = "os";
        style_root = "os_admin";
        format = "[]($style)[  $user](bg:$style fg:text_color)[]($style)";
        disabled = false;
        show_always = true;
      };

      character = {
        success_symbol = "[\\$](fg:arrow)";
        error_symbol = "[\\$](fg:red)";
      };

      directory = {
        format = " [](fg:directory)[  $path ]($style)[$read_only]($read_only_style)[](fg:directory)";
        truncation_length = 2;
        style = "fg:text_color bg:directory";
        read_only_style = "fg:text_color bg:directory";
        before_repo_root_style = "fg:text_color bg:directory";
        truncation_symbol = "…/";
        truncate_to_repo = true;
        read_only = "  ";
      };

      time = {
        disabled = false;
        format = " [](fg:time)[ $time]($style)[](fg:time)";
        time_format = "%H:%M";
        style = "fg:text_color bg:time";
      };

      cmd_duration = {
        format = " [](fg:duration)[ $duration]($style)[](fg:duration)";
        style = "fg:text_light bg:duration";
        min_time = 500;
      };

      git_branch = {
        format = " [](fg:git)[$symbol$branch](fg:text_light bg:git)[](fg:git)";
        symbol = " ";
      };

      git_status = {
        format = "([ ](fg:git_status)[ $all_status$ahead_behind ]($style)[](fg:git_status))";
        style = "fg:text_light bg:git_status";
      };

      docker_context = {
        symbol = " "; # Replaced <U+F308> with actual icon for safety
        format = "via [$symbol$context]($style) ";
        style = "blue bold";
        only_with_files = true;
        detect_files = [ "docker-compose.yml" "docker-compose.yaml" "Dockerfile" ];
        detect_folders = [];
        disabled = false;
      };

      package = {
        disabled = true;
      };

      java = {
        format = "[ ](fg:java)[$symbol$version](bg:java fg:text_color)[](fg:java)";
        version_format = "\${raw}"; # Escaped for Nix
        symbol = " ";
        disabled = true;
      };

      nodejs = {
        format = "[ ](fg:node)[$symbol$version]($style)[](fg:node)";
        style = "bg:node fg:text_light";
        symbol = " ";
        version_format = "\${raw}";
        disabled = false;
      };

      rust = {
        format = "[ ](fg:rust)[$symbol$version](bg:rust fg:text_color)[](fg:rust)";
        symbol = " ";
        version_format = "\${raw}";
        disabled = true;
      };

      python = {
        disabled = false;
        # Note: Nix requires escaping ${} as \${} to prevent interpolation
        format = "[ ](fg:python)[\${symbol}\${pyenv_prefix}(\${version} )(\\($virtualenv\\))]($style)[](fg:python)";
        symbol = " ";
        version_format = "\${raw}";
        style = "fg:text_light bg:python";
      };

      conda = {
        format = "[ ](fg:conda)[$symbol$environment]($style)[](fg:conda)";
        style = "bg:conda fg:text_color";
        ignore_base = false;
        disabled = false;
        symbol = " ";
      };

      nix_shell = {
        symbol = " "; # Replaced <U+F2DC> with standard Nix icon
      };

      c = {
        format = "[ ](fg:clang)[$symbol($version(-$name) )](bg:clang fg:text_color)[](fg:clang)";
        symbol = " ";
        version_format = "\${raw}";
        disabled = true;
      };

      # The [os.symbols] section must be nested in os = { ... }
      os = {
        symbols = {
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Gentoo = " ";
          Linux = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          openSUSE = " ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          Redox = " ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Windows = " ";
        };
      };
    };
  };
}