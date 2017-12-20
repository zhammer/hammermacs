;; hammermacs init-edit

(delete-selection-mode 1)
(setq show-paren-delay 0)
(show-paren-mode 1)
(electric-pair-mode 1)
(global-set-key (kbd "C-z") 'undo)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(define-key prog-mode-map (kbd "<return>") (function newline-and-indent))
(define-key prog-mode-map (kbd "<S-return>") (function newline))
(setq-default indent-tabs-mode nil)
(defun highlight-todos ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(FIXME\\):" 1 font-lock-warning-face prepend)
     ("\\<\\(TBD\\):" 1 font-lock-warning-face prepend)
     ("\\<\\(TODO\\):" 1 font-lock-warning-face prepend))))
(add-hook 'prog-mode-hook 'highlight-todos)

(defun init-edit ()
  "Edit the 'user-init-file'"
  (interactive)
  (find-file user-init-file))

(provide 'init-edit)
