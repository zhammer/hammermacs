

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; ~~ no menu, tool buttons, scroll, custom splash ~~
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-linum-mode t)
(setq initial-scratch-message ";; it's hammertime")

;; ~~ theme ~~
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(x-focus-frame nil) ;; how do i get this to work w/ emacs daemon?
 '(custom-enabled-themes (quote (misterioso)))
 '(package-selected-packages (quote (markdown-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ~~ add elpa and melpa package archives ~~
(setq package-archives  '(("gnu" . "http://elpa.gnu.org/packages/")   ("melpa" . "http://melpa.org/packages/")))
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; ~~ python ~~
(setq gud-pdb-command-name "python -m pdb")
(setq python-shell-completion-native-enable nil)
(defun my-python-mode-config ()
  "For use in `python-mode-hook'."
  (local-set-key (kbd "C-c C-d") 'pdb)
  )

;; add to hook
(add-hook 'python-mode-hook 'my-python-mode-config)
