;; hammermacs hmacs-util

(defvar hmacs-camel-search-regex "\\b[a-z]+\\([A-Z][a-z]+\\)+\\b"
  "Camelcase search regex. Should be used with a case-sensitive search.")

(defun hmacs-get-uniq-regex-matches (regexp)
  "Return a uniq list of all matches to a given regex in the current buffer."
  (save-excursion
    (save-restriction
      (save-match-data
	(widen)
	(goto-char (point-min))
	(let ((matches)
	      (case-fold-search nil))
	  (while (re-search-forward regexp nil t)
	    (push (match-string-no-properties 0) matches))
	  (setq matches (seq-uniq matches))
	  matches
	  ))))
  )

(defun hmacs-c-to-s (word)
  "Return the snake_case version of a camelCase word."
  (let ((case-fold-search nil))
    (downcase (replace-regexp-in-string "[A-Z]" "_\\&" word t)))
  )

(defun hmacs-camel-to-snake ()
  "Interactively replace camelCase words in the current buffer to snake_case."
  (interactive)
  (save-excursion
    (save-restriction
      (save-match-data
	(widen)
	(goto-char (point-min))
	(let ((camel-words (hmacs-get-uniq-regex-matches hmacs-camel-search-regex))
	      (snake-case "")
	      (word ""))
	  (while camel-words
	    (setq word (car camel-words))
	    (setq camel-words (cdr camel-words))
	    (goto-char (point-min))
	    (query-replace-regexp word (hmacs-c-to-s word))
	    )
	  ))))
  )

(defun hmacs-wrap-wordbreak (regex)
  "Wrap a regex with word break chars."
  (concat "\\b" regex "\\b"))

(provide 'hmacs-util)
