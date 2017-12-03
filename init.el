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
(column-number-mode 1)
(setq initial-scratch-message ";; it's hammertime")

;; ~~ edit preferences ~~
(delete-selection-mode 1)
(setq show-paren-delay 0) ; must come before show-paren-mode enable
(show-paren-mode 1)
(electric-pair-mode 1)
(global-set-key (kbd "C-z") 'undo)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(define-key prog-mode-map (kbd "<return>") (function newline-and-indent))
(define-key prog-mode-map (kbd "<S-return>") (function newline))
(defun highlight-todos ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(FIXME\\):" 1 font-lock-warning-face prepend)
     ("\\<\\(TBD\\):" 1 font-lock-warning-face prepend)
     ("\\<\\(TODO\\):" 1 font-lock-warning-face prepend))))
(add-hook 'prog-mode-hook 'highlight-todos)

(defvar hammermacs-camel-search-regex "\\b[a-z]+\\([A-Z][a-z]+\\)+\\b"
  "Camelcase search regex. Should be used with a case-sensitive search.")

(defun hammermacs-get-uniq-regex-matches (regexp)
  (save-excursion
    (save-restriction
      (save-match-data
	(widen)
	(goto-char (point-min))
	(let ((matches)
	      (case-fold-search nil))
	  (while (re-search-forward regexp nil t)
	    (push (match-string-no-properties 0) matches))
	  (setq matches (seq-uniq matches))
	  matches
	  ))))
  )

(defun c-to-s ()
  ;; how the f*** can i use this as my query-replace-regexp replacement arg in non-interactive mode?
  (downcase (replace-regexp-in-string "[A-Z]" "_\\&" (match-string 0) t))
  )

(defun hammermacs-camel-to-snake ()
  (interactive)
  (save-excursion
    (save-restriction
      (save-match-data
	(widen)
	(goto-char (point-min))
	(let ((camel-words (hammermacs-get-uniq-regex-matches hammermacs-camel-search-regex))
	      (snake-case "")
	      (word ""))
	  ;; for word in camel-words: goto point-min, highlight word, y-n prompt to change; search through and replace
	  (while camel-words
	    (setq word (car camel-words))
	    (setq camel-words (cdr camel-words))
	    (goto-char (point-min))
	    (query-replace-regexp word "\\\\,(c-to-s)")
	    )
	  ))))
  )

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
(setq python-shell-completion-native-neable nil)
(defun my-python-mode-config ()
  "For use in `python-mode-hook'."
  (local-set-key (kbd "C-c C-d") 'pdb)
  )
(add-hook 'python-mode-hook 'my-python-mode-config)

;; ~~ helm ~~
(global-set-key (kbd "C-h a") 'helm-apropos)

;; ~~ dired ~~
(require 'dired-x)
;; TODO: remove '..' from dired omit. can be useful if you don't know the C-^ command for parentdir
(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files
			       "\\|^.*\\.pyc$"
			       "\\|^.*\\.o$"))

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
 '(font-lock-doc-face ((t (:foreground "gray49")))))
