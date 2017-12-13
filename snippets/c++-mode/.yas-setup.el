;; hmacs c++-mode yas setup

(require 'cl)

(defvar hmacs-file-name-re "\\(?:\\(\\w+\\)_\\)?\\(\\w+\\)"
  "Regex for extracting package name of a file.
	\\1: package
	\\2: component
	\\3: filetype")

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
