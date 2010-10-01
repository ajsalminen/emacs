;;; ob-latex.el --- org-babel functions for latex "evaluation"

;; Copyright (C) 2009, 2010  Free Software Foundation, Inc.

;; Author: Eric Schulte
;; Keywords: literate programming, reproducible research
;; Homepage: http://orgmode.org
;; Version: 7.01trans

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Org-Babel support for evaluating LaTeX source code.
;;
;; Currently on evaluation this returns raw LaTeX code, unless a :file
;; header argument is given in which case small png or pdf files will
;; be created directly form the latex source code.

;;; Code:
(require 'ob)

(declare-function org-create-formula-image "org" (string tofile options buffer))
(declare-function org-splice-latex-header "org"
		  (tpl def-pkg pkg snippets-p &optional extra))
(declare-function org-export-latex-fix-inputenc "org-latex" ())
(add-to-list 'org-babel-tangle-lang-exts '("latex" . "tex"))

(defvar org-format-latex-header)
(defvar org-format-latex-header-extra)
(defvar org-export-latex-packages-alist)
(defvar org-export-latex-default-packages-alist)
(defvar org-export-pdf-logfiles)
(defvar org-latex-to-pdf-process)
(defvar org-export-pdf-remove-logfiles)
(defvar org-format-latex-options)
(defvar org-export-latex-packages-alist)

(defvar org-babel-default-header-args:latex
  '((:results . "latex") (:exports . "results"))
  "Default arguments to use when evaluating a LaTeX source block.")

(defun org-babel-expand-body:latex (body params &optional processed-params)
  "Expand BODY according to PARAMS, return the expanded body."
  (mapc (lambda (pair) ;; replace variables
          (setq body
                (replace-regexp-in-string
                 (regexp-quote (format "%S" (car pair)))
                 (if (stringp (cdr pair))
                     (cdr pair) (format "%S" (cdr pair)))
                 body))) (nth 1 (org-babel-process-params params)))
  (org-babel-trim body))

(defun org-babel-execute:latex (body params)
  "Execute a block of Latex code with Babel.
This function is called by `org-babel-execute-src-block'."
  (setq body (org-babel-expand-body:latex body params))
  (if (cdr (assoc :file params))
      (let* ((out-file (cdr (assoc :file params)))
	     (tex-file (org-babel-temp-file "latex-" ".tex"))
	     (border (cdr (assoc :border params)))
	     (fit (or (cdr (assoc :fit params)) border))
	     (height (and fit (cdr (assoc :pdfheight params))))
	     (width (and fit (cdr (assoc :pdfwidth params))))
	     (in-buffer (not (string= "no" (cdr (assoc :buffer params)))))
	     (org-export-latex-packages-alist
	      (append (cdr (assoc :packages params))
		      org-export-latex-packages-alist)))
        (cond
         ((string-match "\\.png$" out-file)
          (org-create-formula-image
           body out-file org-format-latex-options in-buffer))
         ((string-match "\\.pdf$" out-file)
	  (require 'org-latex)
	  (with-temp-file tex-file
	    (insert
	     (org-splice-latex-header
	      org-format-latex-header
	      (delq
	       nil
	       (mapcar
		(lambda (el)
		  (unless (and (listp el) (string= "hyperref" (cadr el)))
		    el))
		org-export-latex-default-packages-alist))
	      org-export-latex-packages-alist
	      org-format-latex-header-extra)
	     (if fit "\n\\usepackage[active, tightpage]{preview}\n" "")
	     (if border (format "\\setlength{\\PreviewBorder}{%s}" border) "")
	     (if height (concat "\n" (format "\\pdfpageheight %s" height)) "")
	     (if width  (concat "\n" (format "\\pdfpagewidth %s" width))   "")
	     (if org-format-latex-header-extra
		 (concat "\n" org-format-latex-header-extra)
	       "")
	     (if fit
		 (concat "\n\\begin{document}\n\\begin{preview}\n" body
			 "\n\\end{preview}\n\\end{document}\n")
	       (concat "\n\\begin{document}\n" body "\n\\end{document}\n")))
	    (org-export-latex-fix-inputenc))
          (when (file-exists-p out-file) (delete-file out-file))
          (rename-file (org-babel-latex-tex-to-pdf tex-file) out-file))
         ((string-match "\\.\\([^\\.]+\\)$" out-file)
          (error "can not create %s files, please specify a .png or .pdf file"
		 (match-string 1 out-file))))
        out-file)
    body))

(defun org-babel-latex-tex-to-pdf (file)
  "Generate a pdf file according to the contents FILE.
Extracted from `org-export-as-pdf' in org-latex.el."
  (let* ((wconfig (current-window-configuration))
         (default-directory (file-name-directory file))
         (base (file-name-sans-extension file))
         (pdffile (concat base ".pdf"))
         (cmds org-latex-to-pdf-process)
         (outbuf (get-buffer-create "*Org PDF LaTeX Output*"))
         output-dir cmd)
    (with-current-buffer outbuf (erase-buffer))
    (message (concat "Processing LaTeX file " file "..."))
    (setq output-dir (file-name-directory file))
    (if (and cmds (symbolp cmds))
	(funcall cmds (shell-quote-argument file))
      (while cmds
	(setq cmd (pop cmds))
	(while (string-match "%b" cmd)
	  (setq cmd (replace-match
		     (save-match-data
		       (shell-quote-argument base))
		     t t cmd)))
	(while (string-match "%f" cmd)
	  (setq cmd (replace-match
		     (save-match-data
		       (shell-quote-argument file))
		     t t cmd)))
	(while (string-match "%o" cmd)
	  (setq cmd (replace-match
		     (save-match-data
		       (shell-quote-argument output-dir))
		     t t cmd)))
	(shell-command cmd outbuf outbuf)))
    (message (concat "Processing LaTeX file " file "...done"))
    (if (not (file-exists-p pdffile))
	(error (concat "PDF file " pdffile " was not produced"))
      (set-window-configuration wconfig)
      (when org-export-pdf-remove-logfiles
	(dolist (ext org-export-pdf-logfiles)
	  (setq file (concat base "." ext))
	  (and (file-exists-p file) (delete-file file))))
      (message "Exporting to PDF...done")
      pdffile)))

(defun org-babel-prep-session:latex (session params)
  "Return an error because LaTeX doesn't support sesstions."
  (error "LaTeX does not support sessions"))

(provide 'ob-latex)

;; arch-tag: 1f13f7e2-26de-4c24-9274-9f331d4c6ff3

;;; ob-latex.el ends here