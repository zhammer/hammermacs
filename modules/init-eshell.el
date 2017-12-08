;; hammermacs init-eshell

(add-hook
 'eshell-mode-hook
 (lambda ()
   (setenv "TERM" "emacs") ; add colors
   ))

(provide 'init-eshell)
