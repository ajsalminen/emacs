;;; google-reader.el ---
;;
;; Filename: google-reader.el
;; Description: A mode for google reader
;; Author: Sam Baron
;; Maintainer: Sam Baron
;; Created: Tue Nov 23 12:44:54 2010 (+0900)
;; Version: 0.1
;; Last-Updated:
;;           By:
;;     Update #: 0
;; URL: https://github.com/baron/google-reader.el
;; Keywords: Google Reader, RSS, News
;; Compatibility: Only tested on Carbon Emacs 22
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;  Not really sure if or when this will be ready for consumption
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'ggauth)
(require 'cl)
(require 'json)

(setq ggauth-authentication-header-format "accountType=HOSTED_OR_GOOGLE&Email=%s&Passwd=%s&service=reader")

;; Assorted vars needed to process data (these need to be set accordingly
;; once the modes are worked out but for now they will float around for
;; easier debugging

(defvar reading-list-data nil
  "this is where the reading list is stored as a list after bing parsed from json")

;;  These are various urls needed to access the Google Reader api
(defvar ggread-api-base-url "https://www.google.com/reader/api/0/"
  "Base url for all Google api requests")

(defvar ggread-token-url "http://www.google.com/reader/api/0/token")

(defvar ggread-quickadd-format "%ssubscription/quickadd?quickadd=%s"
  "quick add format for subscriptions")

(defvar ggread-default-fetch-number 50
  "default number of items to fetch per request")

(defvar ggread-reading-list-url-format "%sstream/contents/user/-/state/com.google/reading-list?xt=user/-/state/com.google/read&n=%d%s&client=scroll"
  "This url fetches unread items where %d is the number of items per fetch and %s is where the continuation string will go if any")

;; passing blank string at end since we're not using continuations yet
(defun ggread-reading-list-url ()
  (format ggread-reading-list-url-format ggread-api-base-url ggread-default-fetch-number ""))

(defun ggread-quickadd-url-string (url)
  (format ggread-quickadd-format ggread-api-base-url url))

(defun ggread-reading-list-get ()
  (ggauth-get-url (ggread-reading-list-url)))

(defun ggread-reading-list-parse ()
  "parses the fetched reading list (json format)"
  (set-buffer (get-buffer ggauth-http-buffer))
  (print (decode-coding-string (buffer-string) 'utf-8))
  (setq reading-list-data (json-read-from-string (buffer-string)))
  (loop for item across (cdr (assoc 'items reading-list-data)) do
        ;; (message "%s" item)
        (message (decode-coding-string (cdr (assoc 'title item)) 'utf-8))
        (let ((content (cdr (assoc 'content (assoc 'summary item)))))
          (if content
            (message "%s" (decode-coding-string content 'utf-8))))

        ;; (message (decode-coding-string (mapconcat 'identity (cdr (assoc 'categories item)) "|") 'utf-8))
        ;; (message (cdr (assoc 'url item)))
        ;; (message (cdr (assoc 'author item)))
        )
  )

;; FIXME: need to get T token for editing
;; FIXME: use "T" and "quickadd" as post params
(defun ggread-quickadd-url (url)
  (ggread-get-url (ggread-quickadd-url-string url)))

;; This stuff requires w3m
;; TODO: make it optional/conditional

(require 'w3m)

;; TODO: all it does is echoes the links
;; TODO: allow the selection of region
(defun ggread-quickadd-links ()
  (interactive)
  (save-excursion
    (let ((buffer (current-buffer))
          (prev (point))
          (url (w3m-url-valid (w3m-anchor (point))))
          (prevurl nil))
      (unless url
        (progn
          (w3m-next-anchor)
          (setq url (w3m-url-valid (w3m-anchor (point))))))
      (when url
        (setq prevurl url)
        (message url)
        (ggread-quickadd-url (url))
        (while (progn
                 (w3m-next-anchor)
                 (and (> (point) prev)
                      (< (point) (point-max))))
          (setq prev (point))
          (when (setq url (w3m-url-valid (w3m-anchor)))
            (progn
              (message url)
              (unless (string= url prevurl)
                (ggread-quickadd-url (url))
                (message "same as last"))
              (setq prevurl url))))))))


(defun ggread-mode ()
  "setup Google Reader"
  (interactive)
  (kill-all-local-variables))


;; the declarations below are for testing purposes
(ggauth-authenticate)
(ggauth-set-auth-token)
(ggread-reading-list-get)
(ggread-reading-list-parse)



;; (ggread-reset-auth-token)
;; (message ggread-auth-token-string)
;; (ggread-setup-auth)

;; (message (ggread-reading-list-url))

;; (message reading-list-data)

;; (ggread-quickadd-url-string  "http://blogs.itmedia.co.jp/osonoi/")
;; (ggread-quickadd-url "http://blogs.itmedia.co.jp/osonoi/")

;; (ggread-set-token)
;; (message ggread-token-string)


(provide 'ggread)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; google-reader.el ends here
