;; no menu, tool buttons, scroll, custom splash
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-linum-mode t)
(setq initial-scratch-message ";; it's hammertime")
;; (x-focus-frame nil) this is causing an error in emacs --daemon

;; theme
(custom-set-variables
 '(custom-enabled-themes (quote (misterioso))))
(custom-set-faces)

(defconst exordium-before-init "before-init.el"
  "name of the before init file")

(defconst exordium-prefs "prefs.el"
  "name of the prefs file")

(defconst exordium-after-init "after-init.el"
  "name of the after init file")

;; Save any custom set variable in after-init.el rather than at the end of init.el:
(setq custom-file "~/.emacs.d/after-init.el")
