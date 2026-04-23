{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;

    extensions = [
      "nix"
      "toml"
      "docker-compose"
      "java"
    ];

    extraPackages = with pkgs; [
      # nix fucking rocks
      nixd
      alejandra

      # toml + yaml
      taplo
      yaml-language-server

      # python
      pyright
      ruff

      #
      jdt-language-server
    ];

    userSettings = {
      # misc
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };

      # languages
      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
          formatter = "language_server";
        };
      };

      # LSPs
      lsp = {
        nixd = {
          binary = {
            path = "${pkgs.nixd}/bin/nixd";
          };
          settings = {
            formatting = {
              command = ["alejandra"];
            };
            nixpkgs = {
              expr = "import <nixpkgs> { }";
            };
            diagnostic = {
              suppress = [
                "unused_binding"
              ];
            };
          };
        };

        yaml-language-server = {
          settings = {
            yaml = {
              schemas = {
                kubernetes = [
                  "/*.k8s.yaml"
                  "/*.k8s.yml"
                ];
              };
            };
          };
        };
      };
    };
  };
}
