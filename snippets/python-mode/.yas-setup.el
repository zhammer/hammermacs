(defun hmacs-yas-line-beg (&optional offset)
  "Get the position at the beginning of line {offset} after yas-snippet-beg"
  (setq offset (1+ (or offset 0)))
  (save-excursion
    (goto-char yas-snippet-beg)
    (line-beginning-position offset)
    )
  )

(defun hmacs-yas-line-end (&optional offset)
  "Get the position at the end of line {offset} after yas-snippet-beg"
  (setq offset (1+ (or offset 0)))
  (save-excursion
    (goto-char yas-snippet-end)
    (line-beginning-position offset)
    )
  )

(defun hmacs-parse-args-exit-hook ()
  "Hook for parse_args yas-after-exit"
  (let ((doc-start (hmacs-yas-line-beg 1))
	(doc-end (hmacs-yas-line-beg 4)))
    ;;(message (concat "Docstring start: " (number-to-string doc-start)))
    ;;(message (concat "Docstring end: " (number-to-string doc-end)))
    (fill-region doc-start doc-end t t nil)))

;; (split-string STRING &optional SEPARATORS OMIT-NULLS TRIM)

(defvar hmacs-yas-pyargs-trimregex "\\W+\\|=.*"
  "Regex for trimming characters from start and end of python function arguments.")

(defun hmacs-yas-pyargs-docstring ()
  (save-match-data
    (when (yas-text)
      (let ((output "\n\nArgs:")
	    (args (split-string yas-text "," t hmacs-yas-pyargs-trimregex)))
	(concat output
		(mapconcat (lambda (arg)
			     (format "\n        %s:" arg))
			   args
			   ""))
	))))

(defun hmacs-yas-def-exit-hook ()
  "After exiting from the 'def' yas snippet, tab through args to add descriptions"
  (save-excursion
    (save-match-data
      (goto-char yas-snippet-beg)
      (when (re-search-forward "Args:" nil t)
      (next-line)
      (while (string-match "\\s-+\\w+:$" (thing-at-point 'line t))
	(end-of-line)
	;; TODO: this
	(insert "#TODO")
	(next-line))))))
