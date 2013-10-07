;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.

;; for package backports
(when (<= emacs-major-version 24)
  (add-to-list 'load-path "~/.emacs.d/package-backport"))

(when
    (load
     (if (<= emacs-major-version 24)
	 (expand-file-name "~/.emacs.d/package-backport/package.el")
       ;; (expand-file-name "~/.emacs.d/elpa/package.el")
       ))
  (require 'package)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))
  ;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize))
