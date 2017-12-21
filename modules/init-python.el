;; hammermacs init-python

(require 'hmacs-util)

(defun hmacs-already-private (word)
  "Regex to check if a superword in python is already private."
  (string-match "^_\\{1,2\\}\\w+" word))

;; TODO: can do different levels, _ to none, none to __, all combinations
(defun hmacs-py-privatize ()
  "Interactively prefix all occurences of a word in a python file with an underscore."
  (interactive)
  (save-excursion
    (save-restriction
      (save-match-data
	(let ((current-superword-mode superword-mode)))
	(unwind-protect
	    (progn
	      (superword-mode 1)
	      (let ((my-word (thing-at-point 'word t)))
		(if (not (or (null my-word) (hmacs-already-private my-word)))
		    (progn (goto-char (point-min))
			   (query-replace-regexp (hmacs-wrap-wordbreak my-word) "_\\&"))
		  (if (null my-word)
		      (print "No word selected.")
		    (print (format "Word is already private: '%s'." my-word))))
		))
	  (superword-mode current-superword-mode)))))
  )

(setq gud-pdb-command-name "python -m pdb")
(setq python-check-command "pylint")

(defun my-python-mode-config ()
  "For use in `python-mode-hook'."
  (local-set-key (kbd "C-c C-d") 'pdb)
  (local-set-key (kbd "C-c C-i") 'hmacs-py-privatize)
  (modify-syntax-entry ?_ "w")
  (setenv "LC_CTYPE" "UTF-8")
  (setenv "LC_ALL" "en_US.UTF-8")
  (setenv "LANG" "en_US.UTF-8")
  )
(add-hook 'python-mode-hook 'my-python-mode-config)

(provide 'init-python)
