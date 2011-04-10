(require 'json)
(require 'w3m-load)

(defvar anything-apple-docset-candidates nil)
(defcustom anything-apple-docset-open-w3m-other-buffer nil
  "")
(defcustom anything-apple-docset-path
  "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiOS4_2.iOSLibrary.docset"
  "")

(defun anything-apple-docset-json-path ()
  (format "%s%s" anything-apple-docset-path
          "/Contents/Resources/Documents/navigation/library.json"))

(defun anything-apple-docset-doc-absolute-path (doc-url)
  (let ((base-path (format "file://%s%s" anything-apple-docset-path
                           "/Contents/Resources/Documents/navigation/")))
    (car (split-string (format "%s%s" base-path doc-url) "#"))))

(defun anything-apple-docset-init ()
  (let* ((lib (anything-apple-docset-read-json-file (anything-apple-docset-json-path)))
         (docs (cdr (assq 'documents lib)))
         (cols (cdr (assq 'columns lib)))
         (url-index (cdr (assq 'url cols)))
         (name-index (cdr (assq 'name cols)))
         candidates)
    (do ((i 0 (+ 1 i)))
        ((>= i (length docs)))
      (let ((doc (elt docs i)))
        (push (cons (anything-apple-docset-unescape-name (elt doc name-index))
                    (anything-apple-docset-doc-absolute-path (elt doc url-index)))
              candidates)))
    (setf anything-apple-docset-candidates (nreverse candidates))))

(defun anything-apple-docset-read-json-file (path)
  (with-temp-buffer
    (insert-file-contents path)
    (goto-char (point-min))
    (while (search-forward "''" nil t) (replace-match "\"\""))
    (goto-char (point-min))
    (json-read)))

(defun anything-apple-docset-open-w3m (url)
  (cond
   (anything-apple-docset-open-w3m-other-buffer
    (let ((b (save-window-excursion (w3m-browse-url url nil) (get-buffer "*w3m*"))))
      (ignore-errors (save-selected-window (pop-to-buffer "*w3m*")))))
   (t
    (w3m-browse-url url nil))))

(defvar anything-c-source-apple-docset
  '((name . "Reference Library")
    (candidates . anything-apple-docset-candidates)
    (action . (("w3m" . anything-apple-docset-open-w3m)
               ("Default Browser" . browse-url)))))
;(anything-apple-docset-init)
;(setq anything-apple-docset-open-w3m-other-buffer t)
;(anything 'anything-c-source-apple-docset)


(defun anything-apple-docset-unescape-name (name)
  (replace-regexp-in-string "&quot;" "\""
   (replace-regexp-in-string "&amp;" "&"
    (replace-regexp-in-string "&lt;" "<"
     (replace-regexp-in-string "&gt;" ">" name)))))

(defun anything-apple-docset ()
  (interactive)
  (anything 'anything-c-source-apple-docset))

(provide 'anything-apple-docset)

