;;; ~/.config/emacs/early-init.el
;;; This file loads *before* anything else to speed up startup.

;; --- Disable UI elements we don't need ---
;; We do this *early* so Emacs doesn't waste time drawing them
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; --- Disable the splash screen ---
(setq inhibit-startup-screen t)

;; --- Tweak Garbage Collection ---
;; We'll make the garbage collector less aggressive during startup
;; and more aggressive after startup.
(setq gc-cons-threshold (* 100 1024 1024)) ; 100MB
(setq read-process-output-max (* 1024 1024)) ; 1MB

;; This function will run *after* init.el is loaded
(defun my-defer-gc ()
  "Reset GC thresholds after startup."
  (setq gc-cons-threshold (* 2 1024 1024))) ; 2MB
(add-hook 'emacs-startup-hook #'my-defer-gc)