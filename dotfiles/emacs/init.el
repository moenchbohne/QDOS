;;; --- Package Management ("Channels") ---

;; Initialize the package system
(require 'package)

;; Add the package archives (MELPA for bleeding-edge, ELPA for official)
(setq package-archives '(("melpa" . "[https://melpa.org/packages/](https://melpa.org/packages/)")
                         ("elpa" . "[https://elpa.gnu.org/packages/](https://elpa.gnu.org/packages/)")))

;; Load packages and activate them
(package-initialize)

;; ----- Woher? -----
(setq package-enable-at-startup nil
      inhibit-startup-message   t
      frame-resize-pixelwise    t  ; fine resize
      package-native-compile    t) ; native compile packages
(scroll-bar-mode -1)               ; disable scrollbar
(tool-bar-mode -1)                 ; disable toolbar
(tooltip-mode -1)                  ; disable tooltips
(set-fringe-mode 10)               ; give some breathing room
(menu-bar-mode -1)                 ; disable menubar
(blink-cursor-mode 0)              ; disable blinking cursor

;; Tell Emacs to put all "Customize" settings in a separate file
(setq custom-file (locate-user-emacs-file "custom-file.el"))
(load custom-file 'noerror)