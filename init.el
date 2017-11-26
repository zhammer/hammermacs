;; hammermacs init.el

;; ~~ setup packages ~~
(require 'package)
(setq package-list '(markdown-mode helm wrap-region))
;; Question: how do i combine these into one line?
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; ~~ no menu, tool buttons, scroll, custom splash ~~
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-linum-mode t)
(setq initial-scratch-message ";; it's hammertime")

;; ~~ edit preferences ~~
(delete-selection-mode 1)
(setq show-paren-delay 0) ;; must come before show-paren-mode enable
(show-paren-mode 1)
(electric-pair-mode 1)

;; (defun insert-hard-brackets (&optional arg) ;; copied from insert-parentheses.
;;   ;; M-{ is already mapped. maybe i should just hook into insert (,[,{ commands.
;;   ;; if there is a region active, insert-pair of the bracket type
;;   "Enclose following ARG sexps in parentheses.
;; Leave point after open-paren.
;; A negative ARG encloses the preceding ARG sexps instead.
;; No argument is equivalent to zero: just insert `()' and leave point between.
;; If `parens-require-spaces' is non-nil, this command also inserts a space
;; before and after, depending on the surrounding characters.
;; If region is active, insert enclosing characters at region boundaries.

;; This command assumes point is not in a string or comment."
;;   (interactive "P")
;;   (insert-pair arg ?\[ ?\]))
;; (global-set-key (kbd "M-[") 'insert-hard-brackets)

;; ;; ~~ ido mode ~~
;; (ido-mode 1)
;; (setq ido-everywhere t)
;; (setq ido-enable-flex-matching t)

;; ~~ theme ~~
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(package-selected-packages (quote (wrap-region helm-ebdb helm markdown-mode)))
 '(x-focus-frame nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ~~ python ~~
(setq gud-pdb-command-name "python -m pdb")
(setq python-shell-completion-native-enable nil)
(defun my-python-mode-config ()
  "For use in `python-mode-hook'."
  (local-set-key (kbd "C-c C-d") 'pdb)
  )
(add-hook 'python-mode-hook 'my-python-mode-config)
