;; hammermacs init-dired-x

(require 'dired-x)

;; TODO: add key command to create non-dir file from dired-mode
(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files
			       "\\|^.*~$"
			       "\\|^.*\\.pyc$"
			       "\\|^.*\\.o$"))

(provide 'init-dired-x)
