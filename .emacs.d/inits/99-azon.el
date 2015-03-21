(require 'request)

;; takes vector of words and phrases which is then joined and split again
;; to create an array of unique elements that can be rejoined into a string
;; of keywords
(defun azon-uniquify (vec)
  (insert
   (format "%s\n"
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

(defun azon-login ()
  (interactive)
  (request
   "https://www.amazon.com/ap/signin?_encoding=UTF8&openid.assoc_handle=usflex&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.ns.pape=http%3A%2F%2Fspecs.openid.net%2Fextensions%2Fpape%2F1.0&openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fwww.amazon.com%2Fgp%2Fyourstore%2Fhome%3Fie%3DUTF8%26ref_%3Dgno_signin"
   :parser 'buffer-string
   :success  (function* (lambda (&key data &allow-other-keys)
              (when data
                (with-current-buffer (get-buffer-create "*request demo*")
                  (erase-buffer)
                  (insert data)
                  (pop-to-buffer (current-buffer))))))))
