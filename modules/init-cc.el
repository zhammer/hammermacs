;; hammermacs init-cc

(with-no-warnings (require 'cl))

(defun bde-is-member-function-declaration () ;; From exordium
  "Return whether the line ending resembles the member function declaration."
  (re-search-forward
   (concat ") *\\(const\\)?"
           " *\\(noexcept\\|BSLS_CPP11_NOEXCEPT\\)?"
           " *\\(\\(= *\\(0\\|de\\(fault\\|lete\\)\\)\\)"
           "\\|BSLS_CPP11_DE\\(FAULT\\|LETED\\)"
           "\\|override\\|BSLS_CPP11_OVERRIDE\\)?"
           " *\\(&\\(&\\)?\\)?"
           " *; *$")
           (point-at-eol) t))

;; TODO: add cpp-switch-h-cpp functionality from exordium
(defun bde-comment-offset (element) ;; From Exordium
  "Custom line-up function for BDE comments.
Return a symbol for the correct indentation level at the
current cursor position, if the cursor is within a class definition:
1. + for method comments:
        int foo() const = 0;
            // tab goes here
        int bar() { return 0; }
            // tab goes here
2. column number of beginning of comment for data member comments:
        int d_data;     // my comment at whatever column I want
                        // tab goes here
        int d_someLongVariableName;
                        // my comment at whatever column I want
                        // tab goes here
3. nil otherwise."
  (case (caar c-syntactic-context)
    ((inclass innamespace)
     (save-excursion
       (let ((class-offset         ; extra offset for inner structs
              (c-langelem-col (car c-syntactic-context) t))
             (comment-column nil)) ; column number of last //
         (loop
          (beginning-of-line)
          (cond ((= (point) (point-min))
                 (return nil))
                ((re-search-forward "^ *//" (point-at-eol) t)
                 ;; looking at a comment line
                 (setq comment-column (- (current-column) 2))
                 (forward-line -1))
                ((bde-is-member-function-declaration)
                 ;; looking at end of method declaration
                 (return '+))
                ((re-search-forward "} *$" (point-at-eol) t)
                 ;; looking at end of inline method definition
                 (return '+))
                ((re-search-forward "; *//" (point-at-eol) t)
                 ;; looking at beginning of data member comment block
                 (return (- (current-column) 2 class-offset c-basic-offset)))
                ((and comment-column
                      (re-search-forward "[_A-Za-z0-9]+; *$"
                                         (point-at-eol) t))
                 ;; looking at end of (long?) data member declaration
                 (return (- comment-column class-offset c-basic-offset)))
                (t
                 (return nil)))))))
    (t nil)))


(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(defun hmacs-cc-mode-config()
  "For use in `cc-mode-hook'."
  (c-set-style "stroustrup")
  (c-set-offset 'innamespace 0)
  (c-set-offset 'inextern-lang 0)
  (c-set-offset 'access-label -2)
  (c-set-offset 'comment-intro 'bde-comment-offset)
  (setq indent-tabs-mode nil))
(add-hook 'c-mode-common-hook 'hmacs-cc-mode-config)

;; TODO: create cpp snippets. on opening header file, insert guards.
;; Then, move point to first line after guards.
;; TODO: y-or-n prompt to add namespace braces

(provide 'init-cc)
