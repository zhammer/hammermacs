;; hammermacs init-edit

(delete-selection-mode 1)
(setq show-paren-delay 0)
(superword-mode 1)
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

(defun hmacs-shell-command-on-region (command)
  "Wrapper around shell-command-on-region to replace region with output by default."
  (interactive "MShell command on region: ")
  (shell-command-on-region (region-beginning) (region-end) command t t))

(global-set-key (kbd "M-|") 'hmacs-shell-command-on-region)
(global-set-key (kbd "M-]") 'yank)
(global-set-key (kbd "M-C-]") 'helm-show-kill-ring)

(provide 'init-edit)
