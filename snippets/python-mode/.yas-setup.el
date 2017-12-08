(require 'yasnippet)

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

(defun hmacs-yas-first-letter (string)
  (if (null string)
      ""
    (substring string 0 1)))

(setq yas-buffer-local-condition yas-not-string-or-comment-condition)

(defun hmacs-yas-current-field-nested ()
  "Return t if current field is nested. Otherwise return nil."
  (let ((active-field (overlay-get yas--active-field-overlay 'yas--field)))
    (yas--field-parent-field active-field))
  )

(defun hmacs-yas-next-field-nested (&optional arg)
  "Return t if (arg) next field is nested. Otherwise return nil."
  (when (yas-active-snippets)
    (unless arg (setq arg 1))
    (let* ((snippet (car (yas-active-snippets)))
	   (active-field (overlay-get yas--active-field-overlay 'yas--field))
	   (next-field (yas--find-next-field arg snippet active-field)))
      (if next-field
	  (yas--field-parent-field next-field)
	nil))))

(defun hmacs-yas-next-field-after-advice ()
  "After 'next'ing to a field, if that field is a parent field, go to its nested (optional) field."
  (when (hmacs-yas-next-field-nested)
    (yas-next-field)
    (message "Optional field."))
  )

(defun hmacs-yas-skip-and-clear-or-delete-char-before-advice ()
  "If deleting a nested (optional) field, return to parent field and then delete."
  (when (hmacs-yas-current-field-nested)
    (yas-prev-field)))

(defun hmacs-yas-skip-and-clear-or-delete-char-after-advice ()
  "Make sure to skip into an optional field even if coming from a skip and clear."
  (when (hmacs-yas-next-field-nested)
    (yas-next-field)))

;; TODO: allow Ctrl-d from yas-choose-values
;; TODO: if inside string, allow ' or " chars without breaking interactivity
;; TODO: tab after choose

(advice-add 'yas-skip-and-clear-or-delete-char :before #'hmacs-yas-skip-and-clear-or-delete-char-before-advice)
(advice-add 'yas-skip-and-clear-or-delete-char :after #'hmacs-yas-skip-and-clear-or-delete-char-after-advice)
(advice-add 'yas-next-field-or-maybe-expand :after #'hmacs-yas-next-field-after-advice)
