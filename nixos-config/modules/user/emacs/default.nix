{
  config,
  pkgs,
  ...
}: {
  # client emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    # THE NIXOS TRAP: Let Nix handle packages that build native C binaries.
    # If package.el tries to compile pdf-tools on its own, it will fail
    # because it lacks gcc, poppler, and pkg-config in the environment.
    extraPackages = epkgs: [
      epkgs.pdf-tools
    ];
  };

  # symlink the config
  xdg.configFile."emacs/init.el".source = ./init.el;

  # demon emacs
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    ##### LSPs #####
    nixd # Nix
    jdt-language-server # Java (lsp-java)
    texlab # LaTeX (add-hook 'LaTeX-mode-hook 'lsp-deferred)

    ##### Tooling Required by your init.el #####
    multimarkdown # You set `markdown-command "multimarkdown"`
    grip # Needed for the `grip-mode` VSCode previewer
    jdk # lsp-java needs a Java runtime in your $PATH to spin up

    ##### LaTeX Distribution #####
    texliveMedium # Needed by AUCTeX to actually compile .tex to PDF

    ##### Fonts & Icons #####
    nerd-fonts.symbols-only # Needed for `nerd-icons` to render correctly in Dashboard/Modeline

    ##### Optional (Highly Recommended for Consult/Vertico) #####
    ripgrep # The engine behind consult-ripgrep and modern search
    fd # Makes file finding exponentially faster
  ];
}
