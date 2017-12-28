;; hammermacs init-pref

(defalias 'yes-or-no-p 'y-or-n-p)

(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* (
        (backupRootDir "~/.emacs.d/.emacs-backup/")
        (filePath fpath)
        (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~")))
        )
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath
  )
)

;; Backup files are consolidated into one tree structure in .emacs.d
(setq make-backup-file-name-function 'my-backup-file-name)

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

(provide 'init-pref)
