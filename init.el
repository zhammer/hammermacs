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
