;; hammermacs init.el

;; ~~ setup packages ~~
(require 'package)
; list of packages to install
(setq package-list '(magit wrap-region helm-ebdb helm markdown-mode))
; set package archives
; TODO: combine into one list line. confused about the 't' symbol.
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
; not https due to bloomberg security certificate issues. try to automate this.
(package-initialize)
; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))
; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; ~~ gui display ~~
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-linum-mode t)
(setq initial-scratch-message ";; it's hammertime")

;; ~~ edit preferences ~~
(delete-selection-mode 1)
(setq show-paren-delay 0) ; must come before show-paren-mode enable
(show-paren-mode 1)
(electric-pair-mode 1)
(global-set-key (kbd "C-z") 'undo)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(defun camel-to-snake ()
  ;; TODO: camel-to-snake should first find all words that match the \\W[a-z]+\\([A-Z][a-z]+\\) regex.
  ;; Then perform this replace-regexp in those words. Matches to first regex should be counted as 'x performed.'
  (interactive)
  (progn (replace-regexp "\\(\\w\\)\\([A-Z]\\)" "\\1_\\2" nil (region-beginning) (region-end))
	 (downcase-region (region-beginning) (region-end))))

;; ~~ shortcuts ~~
(defun init-edit ()
  "Edit the 'user-init-file'"
  (interactive)
  (find-file user-init-file))

;; ~~ ido mode ~~
(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

;; ~~ eshell ~~
(add-hook
 'eshell-mode-hook
 (lambda ()
   (setenv "TERM" "emacs") ; add colors
   ))

;; ~~ magit ~~
(global-set-key (kbd "C-x g") 'magit-status)

;; ~~ python ~~
(setq gud-pdb-command-name "python -m pdb")
(setq python-shell-completion-native-enable nil)
(defun my-python-mode-config ()
  "For use in `python-mode-hook'."
  (local-set-key (kbd "C-c C-d") 'pdb)
  )
(add-hook 'python-mode-hook 'my-python-mode-config)

;; ~~ theme ~~
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(package-selected-packages (quote (magit wrap-region helm-ebdb helm markdown-mode)))
 '(x-focus-frame nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
