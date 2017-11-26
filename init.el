;; ~~ no menu, tool buttons, scroll, custom splash ~~

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-linum-mode t)
(setq initial-scratch-message ";; it's hammertime")
;; (x-focus-frame nil) this is causing an error in emacs --daemon

;; ~~ theme ~~
(custom-set-variables
 '(custom-enabled-themes (quote (misterioso))))
(custom-set-faces)

;; ~~ add elpa and melpa package archives ~~
(setq package-archives  '(("gnu" . "http://elpa.gnu.org/packages/")   ("melpa" . "http://melpa.org/packages/")))

;; ~~ pdb command ~~
(setq gud-pdb-command-name "python -m pdb")
