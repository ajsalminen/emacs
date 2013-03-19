;;; go-mode-load.el --- Major mode for the Go programming language

;;; Commentary:

;; To install go-mode, add the following lines to your .emacs file:
;;   (add-to-list 'load-path "PATH CONTAINING go-mode-load.el" t)
;;   (require 'go-mode-load)
;; After this, go-mode will be used for files ending in '.go'.

;; To compile go-mode from the command line, run the following
;;   emacs -batch -f batch-byte-compile go-mode.el

;; See go-mode.el for documentation.

;;; Code:

;; To update this file, evaluate the following form
;;   (let ((generated-autoload-file buffer-file-name)) (update-file-autoloads "go-mode.el"))


;;;### (autoloads (godoc gofmt-before-save gofmt go-mode) "go-mode"
;;;;;;  "../../../../../.emacs.d/site-lisp/go-mode.el" (20802 60655
;;;;;;  0 0))
;;; Generated autoloads from ../../../../../.emacs.d/site-lisp/go-mode.el

(autoload 'go-mode "go-mode" "\
Major mode for editing Go source text.

This provides basic syntax highlighting for keywords, built-ins,
functions, and some types.  It also provides indentation that is
\(almost) identical to gofmt.

\(fn)" t nil)

(add-to-list 'auto-mode-alist (cons "\\.go$" #'go-mode))

(autoload 'gofmt "go-mode" "\
Pipe the current buffer through the external tool `gofmt`.
Replace the current buffer on success; display errors on failure.

\(fn)" t nil)

(autoload 'gofmt-before-save "go-mode" "\
Add this to .emacs to run gofmt on the current buffer when saving:
 (add-hook 'before-save-hook #'gofmt-before-save)

\(fn)" t nil)

(autoload 'godoc "go-mode" "\
Show go documentation for a query, much like M-x man.

\(fn QUERY)" t nil)

;;;***

(provide 'go-mode-load)
