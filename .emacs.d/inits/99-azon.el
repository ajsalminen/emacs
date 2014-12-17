(require 'request)

;; takes vector of words and phrases which is then joined and split again
;; to create an array of unique elements that can be rejoined into a string
;; of keywords
(defun azon-uniquify (vec)
  (insert
   (format "%s,\n"
           (mapconcat 'identity
                      (delete-dups
                       (split-string
                        (mapconcat 'identity
                                   (append vec nil) " "))) " "))))

(defun azon-keyword-lookup (kw)
  (interactive "sEnter keyword: ")
  (request
   "http://completion.amazon.com/search/complete"
   :params `(("method" . "completion")
             ("q" . ,kw)
             ("search-alias" . "digital-text")
             ("mkt" . "1"))
   :parser 'json-read
   :success (function*
             (lambda (&key data &allow-other-keys)
               (azon-uniquify (aref data 1))))))


