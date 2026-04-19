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
  :config (add-hook 'java-mode-hook 'lsp))

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
  (setq minimap-major-modes-match-alist '("\\(prog-\\|markdown-\\|text-\\)mode" . t))
  (setq minimap-update-delay 0.2))

(use-package grip-mode
  :ensure t
  :hook ((markdown-mode org-mode) . grip-mode)
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
  :ensure t
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (add-hook 'pdf-view-mode-hook (lambda () (auto-revert-mode 1))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(auctex company consult dashboard denote doom-modeline doom-themes
	    grip-mode lsp-java lsp-ui marginalia minimap nix-mode
	    orderless pdf-tools treemacs-magit vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
