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
    texlive.combined.scheme-full
    multimarkdown
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    # Strictly declarative: Don't let VSCode modify the extensions dir
    mutableExtensionsDir = false;

    # ==========================================
    # EXTENSIONS (Strictly FOSS)
    # ==========================================
    extensions = with mp; [
      # UI & Themes
      # ntpeters.doom-one-theme
      # pkief.material-icon-theme
      oderwat.indent-rainbow

      # Git (Strictly FOSS replacements for GitLens)
      mhutchie.git-graph
      donjayamanne.githistory

      # Remote Server SSH capabilities (FOSS alternative)
      jeanp413.open-remote-ssh

      # Knowledge Base / Markdown
      foam.foam-vscode
      shd101wyy.markdown-preview-enhanced

      # Languages
      jnoortheen.nix-ide
      ms-python.python
      charliermarsh.ruff
      redhat.java
      vscjava.vscode-java-debug
      vscjava.vscode-java-test
      thenuprojectcontributors.vscode-nushell
      tamasfe.even-better-toml
      redhat.vscode-yaml
      haskell.haskell
      justusadam.language-haskell
      james-yu.latex-workshop
    ];

    # ==========================================
    # IMPORT EXTERNAL SETTINGS
    # ==========================================
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
}
