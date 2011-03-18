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

(defcustom ggread-account nil "your google account name (use full form ie XXXXX@gmail.com)" :group 'google-reader)
(defcustom ggread-password nil "your google password name" :group 'google-reader)

(defvar ggread-client-login-url "https://www.google.com/accounts/ClientLogin"
  "base url for Google authentication")

(defvar ggread-authentication-header-format "accountType=HOSTED_OR_GOOGLE&Email=%s&Passwd=%s&service=reader"
  "format for auth credential header for Google authentication")

(defvar ggread-auth-token-header-format "Authorization: GoogleLogin auth=%s"
  "header format for authenticated requests")

;; once users are able to specify url retrieval program the variables
;; http program functions below should be converted to defcustom

(defvar ggread-use-url-retrieve nil
  "If nil, use external command-line HTTP client instead.")

(defvar ggread-url-retrieval-program "curl"
  "NOT IMPLEMENTED: URL retrieving program used when `install-elisp-use-url-retrieve' is nil.
  you may want to try or the native program \"wget -q -O- %s\"")

(defvar ggread-auth-token-buffer-name "*google-reader auth token*"
  "this buffer is used for grabbing auth token")

(defvar ggread-edit-token-buffer-name "*google-reader edit token*"
  "this buffer is used for the edit token")

(defvar ggread-auth-token-string nil
  "this string will be used for all authentication requests")

;; Assorted vars needed to process data (these need to be set accordingly
;; once the modes are worked out but for now they will float around for
;; easier debugging

(defvar reading-list-data nil
  "this is where the reading list is stored as a list after bing parsed from json")


;;;;;;;;;;;;;;;;;;;;;
(defvar ggread-http-buffer "*Google Reader Http Response Buffer*"
  "buffer used to hold api request output")

;;  These are various urls needed to access the Google Reader api
(defvar ggread-api-base-url "https://www.google.com/reader/api/0/"
  "Base url for all Google api requests")

(defvar ggread-token-url "http://www.google.com/reader/api/0/token")

(defvar ggread-quickadd-format "%ssubscription/quickadd?quickadd=%s"
  "quick add format for subscriptions")

(defvar ggread-token-string nil)

(defvar ggread-default-fetch-number 5
  "default number of items to fetch per request")

(defvar ggread-reading-list-url-format "%sstream/contents/user/-/state/com.google/reading-list?xt=user/-/state/com.google/read&n=%d%s&client=scroll"
  "This url fetches unread items where %d is the number of items per fetch and %s is where the continuation string will go if any")

;; passing blank string at end since we're not using continuations yet
(defun ggread-reading-list-url ()
  (format ggread-reading-list-url-format ggread-api-base-url ggread-default-fetch-number ""))

(defun ggread-quickadd-url-string (url)
  (format ggread-quickadd-format ggread-api-base-url url))

(defun ggread-kill-buffer (buffer-name)
  (if (get-buffer buffer-name)
      (kill-buffer buffer-name)))

(defun ggread-refresh-buffer (buffer-name)
  (progn (ggread-kill-buffer buffer-name)
         (get-buffer-create buffer-name)))

(defun ggread-kill-token-buffer ()
  (ggread-kill-buffer ggread-auth-token-buffer-name))

(defun ggread-refresh-token-buffer ()
  (ggread-refresh-buffer ggread-auth-token-buffer-name))

(defun ggread-authenticate ()
  (ggread-refresh-token-buffer)
  (let* ((gr-header (format ggread-authentication-header-format ggread-account ggread-password)))
    ;; this calls a synchronous process ("curl, etc.") that writes output to temp buffer
    (call-process ggread-url-retrieval-program
                  nil
                  ggread-auth-token-buffer-name
                  nil
                  ggread-client-login-url
                  "--silent"
                  "-d"
                  gr-header)))


(defun ggread-set-auth-token ()
  (set-buffer (get-buffer ggread-auth-token-buffer-name))
  (goto-char (point-min))
  (re-search-forward "Auth=\\([a-zA-Z0-9-_]+\\)" nil t nil)
  (setq ggread-auth-token-string (match-string 1)))

(defun ggread-get-token ()
  (ggread-refresh-buffer ggread-edit-token-buffer-name)
  (ggread-get-url ggread-token-url ggread-edit-token-buffer-name))

(defun ggread-parse-edit-token (process event)
    (progn
      (set-buffer (get-buffer ggread-edit-token-buffer-name))
      (goto-char (point-min))
      (re-search-forward "\\([a-zA-Z0-9-_]+\\)$" nil t nil)
      (setq ggread-token-string (match-string 1))))

(defun ggread-set-token ()
  (let ((edit-token-process (ggread-get-token)))
    (set-process-sentinel edit-token-process 'ggread-parse-edit-token)))

(defun ggread-reset-auth-token ()
  (setq ggread-auth-token-string nil))

;; FIXME: accept additional post params as args
(defun ggread-get-url (url &optional buffer-name)
  (let* ((gr-header (format ggread-auth-token-header-format ggread-auth-token-string)))
    (start-process "ggread-get-url"
                   (if buffer-name
                       buffer-name
                     ggread-http-buffer)
                   ggread-url-retrieval-program
                   url
                   "--silent"
                   "--header"
                   gr-header)))

(defun ggread-reading-list-get ()
  (ggread-get-url (ggread-reading-list-url)))

(defun ggread-reading-list-parse ()
  "parses the fetched reading list (json format)"
  (set-buffer (get-buffer ggread-http-buffer))
  (setq reading-list-data (json-read-from-string (buffer-string)))
  (loop for item across (cdr (assoc 'items reading-list-data)) do
        (message (cdr (assoc 'title item)))))

;; FIXME: need to get T token for editing
;; FIXME: use "T" and "quickadd" as post params
(defun ggread-quickadd-url (url)
  (ggread-get-url (ggread-quickadd-url-string url)))

(defun ggread-setup-auth ()
  (progn
    (ggread-authenticate)
    (ggread-set-auth-token)
    (ggread-kill-token-buffer)))


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


;; the declarations below are for testing purposes
;; (ggread-authenticate)
;; (ggread-set-auth-token)

;; (ggread-reset-auth-token)
;; (message ggread-auth-token-string)
;; (ggread-setup-auth)

;; (ggread-reading-list-get)
;; (message (ggread-reading-list-url))
;; (message reading-list-data)
;; (ggread-reading-list-parse)
;; (ggread-quickadd-url-string  "http://blogs.itmedia.co.jp/osonoi/")
;; (ggread-quickadd-url "http://blogs.itmedia.co.jp/osonoi/")

;; (ggread-set-token)
;; (message ggread-token-string)


(provide 'ggread)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; google-reader.el ends here
