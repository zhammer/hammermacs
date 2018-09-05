;; hammermacs init-gui

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-linum-mode t)
(column-number-mode 1)
(setq initial-scratch-message ";; it's hammertime")

;; nyan mode
(nyan-mode 1)
(setq nyan-animate-nyancat t)
(setq nyan-wavy-trail t)

(provide 'init-gui)
