(require 'f)
(require 's)

(defun pandoc-to-text-in-dired ()
  (interactive)
  (let* ((doc-name (dired-file-name-at-point))
         (output-doc-name (concat (file-name-sans-extension doc-name) ".txt")))
    (shell-command (concat "pandoc " doc-name " -o " output-doc-name))))

(defun doc-to-text-in-dired ()
  (interactive)
  (let* ((doc-name (dired-file-name-at-point))
         (output-doc-name (concat (file-name-sans-extension doc-name) ".txt")))
    (shell-command (concat "textutil -convert txt " doc-name))))


(defun lowercase-file-in-dired ()
  (interactive)
  (let* ((doc-name (dired-file-name-at-point))
         (output-doc-name (s-downcase doc-name)))
    (rename-file doc-name output-doc-name t)))
