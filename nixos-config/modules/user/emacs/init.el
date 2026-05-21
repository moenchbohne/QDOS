;; ==========================================
;; 1. PACKAGE MANAGEMENT
;; ==========================================
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

;; ==========================================
;; 2. SANE DEFAULTS & UI CLEANUP
;; ==========================================

;; ==========================================
;; AUTO-SAVE & BACKUP CLEANUP (VS Code Style)
;; ==========================================

;; 1. Stop Emacs from cluttering your projects with backup files (file~)
;;    and traditional auto-save files (#file#). You have Git for backups!
(setq make-backup-files nil)
(setq auto-save-default nil)

;; 2. Enable modern auto-saving to the actual visited file
(auto-save-visited-mode 1)

;; 3. Set the idle delay (in seconds) before Emacs saves the file.
;;    2 or 3 seconds is usually the sweet spot.
(setq auto-save-visited-interval 2)

;; Optional: Silence the "Saved <file>" message in the minibuffer
;; so it doesn't distract you every 2 seconds.
(setq auto-save-visited-predicate
      (lambda ()
        (let ((inhibit-message t))
          (save-buffer))))

;; --- LINE NUMBERS ---
;; Set the style to relative (current line is absolute, others are relative)
(setq display-line-numbers-type 'relative)

;; Enable line numbers for programming and text/org modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)

(setq inhibit-startup-message t)
(menu-bar-mode -1)

;; GUI-specific cleanups
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (set-fringe-mode 10))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(global-auto-revert-mode 1) ;; Auto-update buffers if file changes on disk

;; Silence background native-compilation warnings
(setq native-comp-async-report-warnings-errors 'silent)

;; ==========================================
;; AUTO-PAIRING BRACKETS & QUOTES
;; ==========================================
;; Automatically pair (), [], {}, and ""
(electric-pair-mode 1)

;; ==========================================
;; SYSTEM CLIPBOARD INTEGRATION
;; ==========================================

;; Tell Emacs to use the system clipboard for C-w, M-w, and C-y
(setq select-enable-clipboard t)

;; Also interact with the primary selection (highlight to copy, middle-click to paste)
(setq select-enable-primary t)

;; If you copy something outside Emacs, and then "kill" (cut) something inside Emacs,
;; save the outside copied text to the Emacs history so it isn't lost forever.
(setq save-interprogram-paste-before-kill t)

;; When cycling through your paste history (M-y), also update the system clipboard
(setq yank-pop-change-selection t)

;; ==========================================
;; 3. AESTHETICS, ICONS, & THEMES
;; ==========================================
(use-package nerd-icons
  :ensure t)

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config (setq doom-modeline-height 35))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-banner-logo-title "System Ready. Welcome to Emacs.")
  (setq dashboard-startup-banner 'official)
  (setq dashboard-items '((recents . 5) (bookmarks . 5) (projects . 5)))
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-item-shortcuts '((recents . "r") (bookmarks . "m") (projects . "p"))))

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

;; ==========================================
;; 4. MINIBUFFER & COMPLETION (Vertico)
;; ==========================================
(use-package vertico
  :init (vertico-mode))

(use-package marginalia
  :after vertico
  :init (marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; ==========================================
;; MODERN SEARCHING (Consult)
;; ==========================================
(use-package consult
  :ensure t
  :bind
  ;; Override the default search with the modern Consult search
  (("C-s" . consult-line)))

;; ==========================================
;; 5. FILE TREE & GIT
;; ==========================================
(use-package treemacs
  :ensure t
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t t"   . treemacs)))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

;; ==========================================
;; 6. DEVELOPMENT, LSP, & AUTOCOMPLETE
;; ==========================================
(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init (setq lsp-keymap-prefix "C-c l"))

(use-package lsp-ui
  :commands lsp-ui-mode)

;; Java
(use-package lsp-java
  :config
  (setq lsp-java-server-install-dir (expand-file-name "~/.nix-profile/share/java/jdtls/"))
  (add-hook 'java-mode-hook 'lsp))

;; Nix
;; test and and and and and and and
(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'"
  :config (add-hook 'nix-mode-hook 'lsp-deferred))

;; ==========================================
;; 7. MARKDOWN & KNOWLEDGE BASE
;; ==========================================
(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :config (setq markdown-command "multimarkdown"))

(use-package denote
  :config
  (setq denote-directory (expand-file-name "~/Documents/Notes"))
  (setq denote-file-type 'markdown-yaml)
  :bind
  (("C-c n n" . denote)
   ("C-c n i" . denote-link)
   ("C-c n b" . denote-backlinks)))

;; ==========================================
;; 8. VSCODIUM REPLICATOR (Minimap & Preview)
;; ==========================================
(use-package minimap
  :ensure t
  :config
  (setq minimap-window-location 'right)
  (setq minimap-width-fraction 0.15)
  (setq minimap-major-modes-match-alist '("\\(prog-\\|markdown-\\|text-\\|org-\\)mode" . t))
  (setq minimap-update-delay 0.2))

(use-package grip-mode
  :ensure t
  :hook ((markdown-mode) . grip-mode)
  :config
  (setq grip-preview-use-webkit nil)
  (setq grip-update-after-change t))

;; ==========================================
;; 9. LATEX & NATIVE PDFs
;; ==========================================
(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq TeX-PDF-mode t))

(add-hook 'LaTeX-mode-hook 'lsp-deferred)

(use-package pdf-tools
  :ensure nil
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (add-hook 'pdf-view-mode-hook (lambda () (auto-revert-mode 1))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ==========================================
;; NATIVE ORG SETTINGS
;; ==========================================
(use-package org
  :hook (org-mode . org-indent-mode)
  :config
  (setq org-hide-emphasis-markers t)) ;; Make "+", etc. disappear


;; ==========================================
;; ORG-APPEAR (Dynamic WYSIWYG Editing)
;; ==========================================
(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode)
  :config
  ;; Reveal emphasis markers (*bold*, /italic/, ~code~) when cursor is inside them
  (setq org-appear-autoemphasis t)

  ;; Reveal links ([[link][name]]) when the cursor is over them
  (setq org-appear-autolinks t)

  ;; Reveal subscripts and superscripts (like in math E=mc^2)
  (setq org-appear-autosubmarkers t)

  ;; Reveal LaTeX entities (like \alpha)
  (setq org-appear-autoentities t)

  ;; Add a tiny delay (in seconds) so the text doesn't frantically flash
  ;; raw code if you are just using the arrow keys to fly past a word.
  (setq org-appear-delay 0.15))

;; ==========================================
;; PRETTY ORG HEADINGS
;; ==========================================
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :custom
  ;; You can change these to whatever symbols you prefer!
  (org-bullets-bullet-list '("◉" "○" "●" "◈" "◇" "•")))

;; ==========================================
;; 10. BUILT-IN IDE ENHANCEMENTS
;; ==========================================

;; Type over highlighted text to replace it (like modern editors)
(delete-selection-mode 1)

;; Remember exactly where the cursor was when reopening a file
(save-place-mode 1)

;; Treat camelCaseWords as separate words for navigation (M-f / M-b)
(global-subword-mode 1)

;; Instantly highlight matching parentheses/brackets
(show-paren-mode 1)
(setq show-paren-delay 0.0)

;; Automatically clean up invisible trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Subtly highlight the line your cursor is currently resting on
(global-hl-line-mode 1)

;; ==========================================
;; 11. ESSENTIAL IDE PACKAGES
;; ==========================================

;; The ultimate cheat sheet: pops up keybinding options if you pause typing
(use-package which-key
  :ensure t
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.5))

;; Color-codes nested brackets so you can actually read Lisp and Nix
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Modern, syntax-highlighted replacements for Emacs' built-in help (C-h)
(use-package helpful
  :ensure t
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-c C-d" . helpful-at-point))) ;; Bonus: Check docs for whatever is under cursor

;; Visual undo tree (tames the confusing default Emacs undo ring)
(use-package vundo
  :ensure t
  :bind ("C-x u" . vundo))


;; ==========================================
;; 12. CONFIGURATION MANAGEMENT
;; ==========================================

(defun edit-config ()
  "Instantly open the Emacs configuration file."
  (interactive)
  ;; 'user-init-file' is a built-in variable that always knows exactly
  ;; where your config lives, regardless of your OS or Nix setup.
  (find-file user-init-file))

(defun reload-config ()
  "Reload the Emacs configuration file without restarting."
  (interactive)
  (load-file user-init-file)
  (message "System Ready. Configuration reloaded successfully!"))

;; Bind them to fast, memorable shortcuts
;; C-c c = "Config"
;; C-c r = "Reload"
(global-set-key (kbd "C-c c") 'edit-config)
(global-set-key (kbd "C-c r") 'reload-config)


;; ==========================================
;; 13. MAKING EMACS "NORMAL" (The Hybrid Setup)
;; ==========================================

;; --- RIGHT-CLICK CONTEXT MENU ---
;; This is exactly what you are looking for! It gives you a modern
;; right-click menu to copy, paste, undo, and manipulate text.
(context-menu-mode 1)

;; --- MODERN SHORTCUTS (CUA Mode) ---
;; Enables standard Ctrl+C (copy), Ctrl+V (paste), Ctrl+X (cut), and Ctrl+Z (undo).
;; It also lets you naturally type over highlighted text to replace it.
(cua-mode t)

;; --- COMMAND PALETTE ---
;; Binds Ctrl+Shift+P to your Vertico/Consult M-x prompt,
;; functioning exactly like the VS Code or Lapce command palette.
(global-set-key (kbd "C-S-p") 'execute-extended-command)

;; --- MOUSE SUPPORT ---
;; Ensures the mouse works reliably (even if you launch Emacs in a terminal)
;; and makes the scroll wheel smooth rather than jumpy.
(xterm-mouse-mode 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)

;; --- EASY WINDOW SWITCHING ---
;; Use Shift + Arrow Keys to move your cursor between split windows seamlessly.
(windmove-default-keybindings)

;; ==========================================
;; 14. NUSHELL & LSP INTEGRATION
;; ==========================================

;; 1. Install the syntax highlighting mode for .nu files
(use-package nushell-mode
  :ensure t
  :mode "\\.nu\\'"
  ;; 2. Automatically launch the Language Server when opening a Nushell file
  :hook (nushell-mode . lsp-deferred))

;; 3. Tell Emacs how to talk to Nushell's built-in LSP
;; (Nushell actually has a language server built right into its own CLI binary!)
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(nushell-mode . "nushell"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("nu" "--lsp"))
                    :major-mode 'nushell-mode
                    :server-id 'nu-lsp)))
