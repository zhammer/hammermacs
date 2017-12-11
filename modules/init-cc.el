;; hammermacs init-cc

;; TODO: update comment mode to indent under function defintions
;; TODO: add cpp-switch-h-cpp functionality from exordium
(defun hmacs-cc-mode-config()
  "For use in `cc-mode-hook'."
  (c-set-style "stroustrup")
  (c-set-offset 'innamespace 0)
  (c-set-offset 'inextern-lang 0)
  (setq indent-tabs-mode nil))
(add-hook 'c-mode-common-hook 'hmacs-cc-mode-config)

(provide 'init-cc)
