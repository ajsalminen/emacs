;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.

;; to prevent race conditions with packages required in the init
;; otherwise packages get loaded after the init file loads
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; for package backports
(when (< emacs-major-version 24)
  (progn
    (add-to-list 'load-path "~/.emacs.d/package-backport")
    (load-file (expand-file-name "~/.emacs.d/package-backport/package.el"))))

(require 'package)
(package-initialize)
