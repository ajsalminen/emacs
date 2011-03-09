;;; gauth.el ---
;;
;; Filename: gauth.el
;; Description:
;; Author: baron
;; Maintainer:
;; Created: Wed Mar  9 00:41:59 2011 (+0900)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 0
;; URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
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

(require 'cl)
(require 'json)

(defcustom gauth-account nil "your google account name (use full form ie XXXXX@gmail.com)" :group 'gauth)
(defcustom gauth-password nil "your google password name" :group 'gauth)

(defvar gauth-client-login-url "https://www.google.com/accounts/ClientLogin"
  "base url for Google authentication")

(defvar gauth-service-name "cl"
  "name of service to authenticate")

(defvar gauth-authentication-header-format (format "accountType=HOSTED_OR_GOOGLE&Email=%s&Passwd=%s&service=%s" gauth-service-name)
  "format for auth credential header for Google authentication")

(defvar gauth-auth-token-header-format "Authorization: GoogleLogin auth=%s"
  "header format for authenticated requests")

(defvar gauth-auth-token-buffer-name "*gauth auth token*"
  "this buffer is used for grabbing auth token")

(defvar gauth-edit-token-buffer-name "*gauth edit token*"
  "this buffer is used for the edit token")

(defvar gauth-auth-token-string nil
  "this string will be used for all authentication requests")

;; buffer to hold auth response
(defvar gauth-http-buffer "*Google Auth Http Response Buffer*"
  "buffer used to hold api request output")

(defvar gauth-token-string nil)

(defun gauth-kill-buffer (buffer-name)
  (if (get-buffer buffer-name)
      (kill-buffer buffer-name)))

(defun gauth-refresh-buffer (buffer-name)
  (progn (gauth-kill-buffer buffer-name)
         (get-buffer-create buffer-name)))

(defun gauth-kill-token-buffer ()
  (gauth-kill-buffer gauth-auth-token-buffer-name))

(defun gauth-refresh-token-buffer ()
  (gauth-refresh-buffer gauth-auth-token-buffer-name))

(defun gauth-authenticate ()
  (gauth-refresh-token-buffer)
  (let* ((gr-header (format gauth-authentication-header-format gauth-account gauth-password)))
    ;; this calls a synchronous process ("curl, etc.") that writes output to temp buffer
    (call-process gauth-url-retrieval-program
                  nil
                  gauth-auth-token-buffer-name
                  nil
                  gauth-client-login-url
                  "--silent"
                  "-d"
                  gr-header)))


(defun gauth-set-auth-token ()
  (set-buffer (get-buffer gauth-auth-token-buffer-name))
  (goto-char (point-min))
  (re-search-forward "Auth=\\([a-zA-Z0-9-_]+\\)" nil t nil)
  (setq gauth-auth-token-string (match-string 1)))

(defun gauth-get-token ()
  (gauth-refresh-buffer gauth-edit-token-buffer-name)
  (gauth-get-url gauth-token-url gauth-edit-token-buffer-name))

(defun gauth-parse-edit-token (process event)
  (progn
    (set-buffer (get-buffer gauth-edit-token-buffer-name))
    (goto-char (point-min))
    (re-search-forward "\\([a-zA-Z0-9-_]+\\)$" nil t nil)
    (setq gauth-token-string (match-string 1))))

(defun gauth-set-token ()
  (let ((edit-token-process (gauth-get-token)))
    (set-process-sentinel edit-token-process 'gauth-parse-edit-token)))

(defun gauth-reset-auth-token ()
  (setq gauth-auth-token-string nil))

;; FIXME: accept additional post params as args
(defun gauth-get-url (url &optional buffer-name)
  (let* ((gr-header (format gauth-auth-token-header-format gauth-auth-token-string)))
    (start-process "gauth-get-url"
                   (if buffer-name
                       buffer-name
                     gauth-http-buffer)
                   gauth-url-retrieval-program
                   url
                   "--silent"
                   "--header"
                   gr-header)))

(defun gauth-get-url (url &optional buffer-name)
  (let* ((gr-header (format gauth-auth-token-header-format gauth-auth-token-string)))
    (start-process "gauth-get-url"
                   (if buffer-name
                       buffer-name
                     gauth-http-buffer)
                   gauth-url-retrieval-program
                   url
                   "--silent"
                   "--header"
                   gr-header)))

(defun gauth-setup-auth ()
  (progn
    (gauth-authenticate)
    (gauth-set-auth-token)
;;         (gauth-kill-token-buffer)
))

;; the declarations below are for testing purposes
(gauth-authenticate)
(gauth-set-auth-token)

(gauth-reset-auth-token)
;; (message gauth-auth-token-string)
;; (gauth-setup-auth)

;; (gauth-reading-list-get)
;; (message (gauth-reading-list-url))
;; (message reading-list-data)
;; (gauth-reading-list-parse)
;; (gauth-quickadd-url-string  "http://blogs.itmedia.co.jp/osonoi/")
;; (gauth-quickadd-url "http://blogs.itmedia.co.jp/osonoi/")

;; (gauth-set-token)
;; (message gauth-token-string)


(provide 'gauth)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; gauth.el ends here
