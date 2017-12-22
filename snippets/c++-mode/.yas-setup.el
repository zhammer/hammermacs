;; hmacs c++-mode yas setup

(require 'cl)
(defvar hmacs-file-name-re "\\(?:\\([a-zA-Z_]+\\)_\\)?\\(\\w+\\)"
  "Regex for extracting package name of a file.
	\\1: package
	\\2: component
   Note: [\w_] syntax wouldn't work, so has to use a-zA-Z in package capture group.")

(defun hmacs-extract-package-name ()
  "Get the package name of a cpp filename. If no package name, return empty string."
  (let ((file-name (file-name-base (or buffer-file-name ""))))
    (when (string-match hmacs-file-name-re file-name)
      (match-string 1 file-name))
    ))

(defun hmacs-extract-component-name ()
  "Get the component name of a c++ filename. If no component name, return empty string."
  (let ((file-name (file-name-base (or buffer-file-name ""))))
    (if (string-match hmacs-file-name-re file-name)
	(match-string 2 file-name)
      nil)
    ))

(defun hmacs-gen-headerguard-name ()
  (let ((package-name (hmacs-extract-package-name))
	(component-name (hmacs-extract-component-name)))
    (mapconcat 'upcase (remove-if #'null (list package-name component-name)) "_")))


;; TODO: get package name
;; TODO: get component name

;; TODO: get ifndefguard name
