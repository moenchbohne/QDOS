;;; --- Package Management ("Channels") ---

;; Initialize the package system
(require 'package)

;; Add the package archives (MELPA for bleeding-edge, ELPA for official)
(setq package-archives '(("melpa" . "[https://melpa.org/packages/](https://melpa.org/packages/)")
                         ("elpa" . "[https://elpa.gnu.org/packages/](https://elpa.gnu.org/packages/)")))

;; Load packages and activate them
(package-initialize)





;;; --- Bootstrap use-package (Your "Module System") ---

;; This code ensures that use-package is installed
;; It's the "module system" for our declarative config
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Now, we can load it
(require 'use-package)

;; Tell use-package to *always* try to install missing packages
(setq use-package-always-ensure t)





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