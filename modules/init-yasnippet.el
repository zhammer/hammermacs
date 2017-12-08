;; hammermacs init-yasnippet

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
;; TODO: after yas choose
;; TODO: after python function creation, add function hook to visit each arg and enter description

(provide 'init-yasnippet)
