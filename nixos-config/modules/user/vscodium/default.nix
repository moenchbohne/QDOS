{pkgs, ...}: let
  mp = pkgs.vscode-marketplace;
in {
  # Install the language servers and binaries system-wide (or user-wide)
  # so VSCodium can find them in your PATH.
  home.packages = with pkgs; [
    nixd
    alejandra
    taplo
    yaml-language-server
    pyright
    ruff
    jdt-language-server
    # texlive.combined.scheme-full
    multimarkdown
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = false;

    profiles.default = {
      extensions = with mp; [
        # UI & Themes
        # ntpeters.doom-one-theme
        # pkief.material-icon-theme
        oderwat.indent-rainbow

        mhutchie.git-graph
        donjayamanne.githistory

        # jeanp413.open-remote-ssh

        foam.foam-vscode
        shd101wyy.markdown-preview-enhanced

        jnoortheen.nix-ide
        ms-python.python
        charliermarsh.ruff
        redhat.java
        vscjava.vscode-java-debug
        vscjava.vscode-java-test
        # thenuprojectcontributors.vscode-nushell
        tamasfe.even-better-toml
        redhat.vscode-yaml
        haskell.haskell
        justusadam.language-haskell
        james-yu.latex-workshop
      ];

      userSettings = builtins.fromJSON (builtins.readFile ./settings.jsonc);

      # Emacs-style keybindings
      keybindings = [
        {
          key = "ctrl+shift+p";
          command = "workbench.action.showCommands";
        }
        {
          key = "alt+0";
          command = "workbench.view.explorer";
        }
      ];
    };
  };
}
