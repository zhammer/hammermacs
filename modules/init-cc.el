;; hammermacs init-cc

;; TODO: add cpp-switch-h-cpp functionality from exordium
(defun hmacs-cc-mode-config()
  "For use in `cc-mode-hook'."
  (c-set-style "stroustrup")
  (c-set-offset 'innamespace 0)
  (c-set-offset 'inextern-lang 0))
(add-hook 'c-mode-common-hook 'hmacs-cc-mode-config)

;; ~~ helm ~~
(global-set-key (kbd "C-h a") 'helm-apropos)

(provide 'init-cc)
