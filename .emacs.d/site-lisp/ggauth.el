;;; ggauth.el ---
;;
;; Filename: ggauth.el
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

(defcustom ggauth-account nil "your google account name (use full form ie XXXXX@gmail.com)" :group 'ggauth)
(defcustom ggauth-password nil "your google password name" :group 'ggauth)

(defvar ggauth-client-login-url "https://www.google.com/accounts/ClientLogin"
  "base url for Google authentication")

(defvar ggauth-service-name "cl"
  "name of service to authenticate")

(defvar ggauth-authentication-header-format (format "accountType=HOSTED_OR_GOOGLE&Email=%s&Passwd=%s&service=%s" ggauth-service-name)
  "format for auth credential header for Google authentication")

(defvar ggauth-auth-token-header-format "Authorization: GoogleLogin auth=%s"
  "header format for authenticated requests")

(defvar ggauth-auth-token-buffer-name "*ggauth auth token*"
  "this buffer is used for grabbing auth token")

(defvar ggauth-edit-token-buffer-name "*ggauth edit token*"
  "this buffer is used for the edit token")

(defvar ggauth-auth-token-string nil
  "this string will be used for all authentication requests")

;; buffer to hold auth response
(defvar ggauth-http-buffer "*Google Auth Http Response Buffer*"
  "buffer used to hold api request output")

(defvar ggauth-token-string nil)

(defun ggauth-kill-buffer (buffer-name)
  (if (get-buffer buffer-name)
      (kill-buffer buffer-name)))

(defun ggauth-refresh-buffer (buffer-name)
  (progn (ggauth-kill-buffer buffer-name)
         (get-buffer-create buffer-name)))

(defun ggauth-kill-token-buffer ()
  (ggauth-kill-buffer ggauth-auth-token-buffer-name))

(defun ggauth-refresh-token-buffer ()
  (ggauth-refresh-buffer ggauth-auth-token-buffer-name))

(defun ggauth-authenticate ()
  (ggauth-refresh-token-buffer)
  (let* ((gr-header (format ggauth-authentication-header-format ggauth-account ggauth-password)))
    ;; this calls a synchronous process ("curl, etc.") that writes output to temp buffer
    (call-process ggauth-url-retrieval-program
                  nil
                  ggauth-auth-token-buffer-name
                  nil
                  ggauth-client-login-url
                  "--silent"
                  "-d"
                  gr-header)))


(defun ggauth-set-auth-token ()
  (set-buffer (get-buffer ggauth-auth-token-buffer-name))
  (goto-char (point-min))
  (re-search-forward "Auth=\\([a-zA-Z0-9-_]+\\)" nil t nil)
  (setq ggauth-auth-token-string (match-string 1)))

(defun ggauth-get-token ()
  (ggauth-refresh-buffer ggauth-edit-token-buffer-name)
  (ggauth-get-url ggauth-token-url ggauth-edit-token-buffer-name))

(defun ggauth-parse-edit-token (process event)
  (progn
    (set-buffer (get-buffer ggauth-edit-token-buffer-name))
    (goto-char (point-min))
    (re-search-forward "\\([a-zA-Z0-9-_]+\\)$" nil t nil)
    (setq ggauth-token-string (match-string 1))))

(defun ggauth-set-token ()
  (let ((edit-token-process (ggauth-get-token)))
    (set-process-sentinel edit-token-process 'ggauth-parse-edit-token)))

(defun ggauth-reset-auth-token ()
  (setq ggauth-auth-token-string nil))

;; FIXME: accept additional post params as args
(defun ggauth-get-url (url &optional buffer-name)
  (let* ((gr-header (format ggauth-auth-token-header-format ggauth-auth-token-string)))
    (start-process "ggauth-get-url"
                   (if buffer-name
                       buffer-name
                     ggauth-http-buffer)
                   ggauth-url-retrieval-program
                   url
                   "--silent"
                   "--header"
                   gr-header)))

(defun ggauth-get-url (url &optional buffer-name)
  (let* ((gr-header (format ggauth-auth-token-header-format ggauth-auth-token-string)))
    (start-process "ggauth-get-url"
                   (if buffer-name
                       buffer-name
                     ggauth-http-buffer)
                   ggauth-url-retrieval-program
                   url
                   "--silent"
                   "--header"
                   gr-header)))

(defun ggauth-setup-auth ()
  (progn
    (ggauth-authenticate)
    (ggauth-set-auth-token)
;;         (ggauth-kill-token-buffer)
))

;; the declarations below are for testing purposes
(ggauth-authenticate)
(ggauth-set-auth-token)

(ggauth-reset-auth-token)
;; (message ggauth-auth-token-string)
;; (ggauth-setup-auth)

;; (ggauth-reading-list-get)
;; (message (ggauth-reading-list-url))
;; (message reading-list-data)
;; (ggauth-reading-list-parse)
;; (ggauth-quickadd-url-string  "http://blogs.itmedia.co.jp/osonoi/")
;; (ggauth-quickadd-url "http://blogs.itmedia.co.jp/osonoi/")

;; (ggauth-set-token)
;; (message ggauth-token-string)


(provide 'ggauth)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ggauth.el ends here
