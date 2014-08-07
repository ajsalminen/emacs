;;; package-store-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "package-store" "package-store.el" (21475 25065
;;;;;;  0 0))
;;; Generated autoloads from package-store.el

(defvar package-store-cache-dir (concat user-emacs-directory "package-cache") "\
The directory to store downloaded packages.")

(custom-autoload 'package-store-cache-dir "package-store" t)

(defvar package-store-disconnected nil "\
Is the network disconnected?")

(autoload 'toggle-package-store-connected "package-store" "\
Toggle package network downloads on or off.

\(fn &optional ARG)" t nil)

(autoload 'package-store-url-cache-create-filename-package "package-store" "\
A url cache file namer.

This depends on the special variables
`package-store-cache-package-name' and
`package-store-cache-package-version'.

\(fn URL)" nil nil)

(defadvice package-download-tar (around package-store-do-cache-tar activate) "\
Turn on caching around tar downloads.

Downloads are cached to `package-store-cache-dir'." (if (and package-store-cache-dir (file-exists-p package-store-cache-dir) (file-directory-p package-store-cache-dir)) (let* ((url-automatic-caching t) (url-cache-directory package-store-cache-dir) (url-cache-creation-function (quote package-store-url-cache-create-filename-package)) (package-store-cache-package-name name) (package-store-cache-package-version version)) (if package-store-disconnected (flet ((url-retrieve-synchronously (url) (with-current-buffer (url-fetch-from-cache url) (goto-char (point-min)) (re-search-forward "

" nil t) (setq url-http-end-of-headers (point)) (current-buffer)))) ad-do-it) ad-do-it)) ad-do-it))

(defadvice package-download-single (around package-store-do-cache-file activate) "\
Turn on caching around tar downloads.

Downloads are cached to `package-store-cache-dir'." (if (and package-store-cache-dir (file-exists-p package-store-cache-dir) (file-directory-p package-store-cache-dir)) (let* ((url-automatic-caching t) (url-cache-directory package-store-cache-dir) (url-cache-creation-function (quote package-store-url-cache-create-filename-package)) (package-store-cache-package-name name) (package-store-cache-package-version version)) (if package-store-disconnected (flet ((url-retrieve-synchronously (url) (with-current-buffer (url-fetch-from-cache url) (goto-char (point-min)) (re-search-forward "

" nil t) (setq url-http-end-of-headers (point)) (current-buffer)))) ad-do-it) ad-do-it)) ad-do-it))

(autoload 'package-load-all "package-store" "\
Load all the files in a package.

\(fn FILENAME)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; package-store-autoloads.el ends here
