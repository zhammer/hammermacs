;; hammermacs init-dired-x

(require 'dired-x)

;; TODO: add key command to create non-dir file from dired-mode
(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files
                               "\\|^__pycache__$"
			       "\\|^.*~$"
			       "\\|^.*\\.pyc$"
			       "\\|^.*\\.o$"
			       "\\|^00.*$"
			       "\\|^.*\\.tsk$"
			       "\\|^ported\\.linux$"))

(provide 'init-dired-x)
