;; hammermacs init.el

;; (package-initialize)
;; Note: (package-initialize) called in init-package

(defvar hmacs-modules-path (concat user-emacs-directory "modules/")
  "Path to hammermacs modules directory.")
(add-to-list 'load-path hmacs-modules-path)

(require 'init-package)
(require 'init-gui)
(require 'init-edit)
(require 'init-pref)

(require 'init-python)
(require 'init-cc)

(require 'init-dired-x)
(require 'init-eshell)
(require 'init-helm)
(require 'init-ido)
(require 'init-magit)
(require 'init-yasnippet)

(require 'hmacs-util)

;; TODO: Figure out appropriate place for this
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(package-selected-packages
   (quote
    (yasnippet magit wrap-region helm-ebdb helm markdown-mode)))
 '(x-focus-frame nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-doc-face ((t (:foreground "gray49")))))
