(require 'request)

(defun azon-keyword-lookup (kw)
  (interactive "sEnter keyword: ")
  ;; (message "the kw: %s" ,kw)
  (request
   "http://completion.amazon.com/search/complete"
   :params `(("method" . "completion") ("q" . ,kw) ("search-alias" . "digital-text") ("mkt" . "1"))
   :parser 'json-read
   :success (function*
             (lambda (&key data &allow-other-keys)
               (insert (format "%s,\n" (mapconcat 'identity (delete-dups (split-string (mapconcat 'identity (append (aref data 1) nil) " "))) " ")))))))
