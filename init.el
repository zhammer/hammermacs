;; hammermacs init.el

;; ~~ setup packages ~~
(require 'package)
; list of packages to install
(setq package-list '(yasnippet magit wrap-region helm-ebdb helm markdown-mode))
; set package archives
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
;; TODO: modelineposn mode
(defalias 'yes-or-no-p 'y-or-n-p)
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

(defvar hmacs-camel-search-regex "\\b[a-z]+\\([A-Z][a-z]+\\)+\\b"
  "Camelcase search regex. Should be used with a case-sensitive search.")

(defun hmacs-get-uniq-regex-matches (regexp)
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

(defun hmacs-c-to-s (word)
  (let ((case-fold-search nil))
    (downcase (replace-regexp-in-string "[A-Z]" "_\\&" word t)))
  )

(defun hmacs-camel-to-snake ()
  (interactive)
  (save-excursion
    (save-restriction
      (save-match-data
	(widen)
	(goto-char (point-min))
	(let ((camel-words (hmacs-get-uniq-regex-matches hmacs-camel-search-regex))
	      (snake-case "")
	      (word ""))
	  (while camel-words
	    (setq word (car camel-words))
	    (setq camel-words (cdr camel-words))
	    (goto-char (point-min))
	    (query-replace-regexp word (hmacs-c-to-s word))
	    )
	  ))))
  )

(defun hmacs-wrap-wordbreak (regex)
  "Wrap a regex with word break chars"
  (concat "\\b" regex "\\b"))

(defun hmacs-already-private (word)
  "Regex to check if a superword in python is already private."
  (string-match "^_\\{1,2\\}\\w+" word))

(defun hmacs-py-privatize ()
  ;; TODO: can do different levels, _ to none, none to __, all combinations
  ;; TODO: save original state of superword-mode
  (interactive)
  (save-excursion
    (save-restriction
      (save-match-data
	(let ((current-superword-mode superword-mode)))
	(unwind-protect
	    (progn
	      (superword-mode 1)
	      (let ((my-word (thing-at-point 'word t)))
		(if (not (or (null my-word) (hmacs-already-private my-word)))
		    (progn (goto-char (point-min))
			   (query-replace-regexp (hmacs-wrap-wordbreak my-word) "_\\&"))
		  (if (null my-word)
		      (print "No word selected.")
		    (print (format "Word is already private: '%s'." my-word))))
		))
	  (superword-mode current-superword-mode)))))
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
;;(setq python-shell-completion-native-enable nil)
(setq python-check-command "pylint")
(defun my-python-mode-config ()
  "For use in `python-mode-hook'."
  (local-set-key (kbd "C-c C-d") 'pdb)
  (local-set-key (kbd "C-c C-i") 'hmacs-py-privatize)
  (modify-syntax-entry ?_ "w")
  )
(add-hook 'python-mode-hook 'my-python-mode-config)

;; ~~ c++ ~~
;; TODO: add cpp-switch-h-cpp functionality from exordium
(defun hmacs-cc-mode-config()
  "For use in `cc-mode-hook'."
  (define-key c-mode-base-map [(control tab)] 'cpp-switch-h-cpp) ;; TODO: this should maybe be moved to initialization hook.. also weird C-TAB syntax
  (c-set-style "stroustrup")
  (c-set-offset 'innamespace 0)
  (c-set-offset 'inextern-lang 0))
(add-hook 'c-mode-common-hook 'hmacs-cc-mode-config)

;; ~~ helm ~~
(global-set-key (kbd "C-h a") 'helm-apropos)

;; ~~ dired ~~
(require 'dired-x)
;; TODO: remove '..' from dired omit. can be useful if you don't know the C-^ command for parentdir
(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files
			       "\\|^.*~$"
			       "\\|^.*\\.pyc$"
			       "\\|^.*\\.o$"))

;; ~~ yasnippet ~~
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-prompt-functions '(yas-ido-prompt
                             yas-completing-prompt))
(with-eval-after-load 'yasnippet
  (setq yas-snippet-dirs (remq 'yas-installed-snippets-dir yas-snippet-dirs))
  (yas-reload-all t)
  )
;; TODO: can check if field is nested with yas--field-parent-field
;; TODO: inline autocomplete for yas-choose
;; TODO: after python function creation, add function hook to visit each arg and enter description

;; ~~ theme ~~
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(package-selected-packages
   (quote
    (yasnippet magit wrap-region helm-ebdb helm markdown-mode)))
 '(x-focus-frame nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-doc-face ((t (:foreground "gray49")))))
