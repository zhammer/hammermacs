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
  (fill-region (hmacs-yas-line-beg 1) (hmacs-yas-line-end 4)))
