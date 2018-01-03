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
(require 'init-theme)

(require 'init-python)
(require 'init-cc)

(require 'init-dired-x)
(require 'init-eshell)
(require 'init-helm)
(require 'init-ido)
(require 'init-magit)
(require 'init-yasnippet)

(require 'hmacs-util)

;; Save custom set variables to after-init-el rather than to init.el.
(setq custom-file "~/.emacs.d/after-init.el")
(when (file-exists-p "~/.emacs.d/after-init.el")
      (load custom-file))
