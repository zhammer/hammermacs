;; hammermacs init-magit

(global-set-key (kbd "C-x g") 'magit-status)
(setq magit-diff-section-arguments '("--ignore-space-change" "--ignore-all-space" "--no-ext-diff"))

(provide 'init-magit)
