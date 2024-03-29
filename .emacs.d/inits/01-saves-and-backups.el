;;(require 'byte-code-cache)

;; FIXME: decide on using this

;; (let ((nfsdir "~/.emacs.d/site-lisp")
;;       (cachedir "~/.elispcache"))
;;   (setq load-path (append load-path (list cachedir nfsdir)))
;;   (require 'elisp-cache)
;;   (setq elisp-cache-byte-compile-files t)
;;   (setq elisp-cache-freshness-delay 0)
;;   (elisp-cache nfsdir cachedir))


;; Backups
(require 'backup-dir)

(make-directory "~/.saves/" t)
(defvar temp-directory "~/.saves")

;; localize it for safety.
(make-variable-buffer-local 'backup-inhibited)

(setq bkup-backup-directory-info
      '((t "~/.saves" ok-create full-path prepend-name)))

(setq backup-by-copying t
      backup-by-copying-when-linked t
      backup-by-copying-when-mismatch t
      backup-directory-alist '(("." . "~/.saves")) ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 2
      make-backup-files t
      version-control t)

(setq-default delete-old-versions t)

(setq backup-directory-alist
      `((".*" . ,temp-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temp-directory t)))
(setq backup-directory-alist
      `((".*" . ,temp-directory)))

(defun force-backup-of-buffer ()
  (setq buffer-backed-up nil))

(add-hook 'before-save-hook 'force-backup-of-buffer)

(setq vc-make-backup-files t)

;; One of the main issues for me is that my home directory is
;; NFS mounted. By setting all the autosave directories in /tmp,
;; things run much quicker
(setq auto-save-directory (concat temp-directory "/autosave")
      auto-save-hash-directory (concat temp-directory "/autosave-hash")
      auto-save-directory-fallback "/var/tmp/"
      auto-save-list-file-prefix (concat temp-directory "/autosave-")
      auto-save-hash-p nil
      auto-save-timeout 15
      auto-save-interval 20)
(make-directory auto-save-directory t)

(message "LOADING: auto save stuff")

;; for reviving old configs

(message "LOADING: window revive")

(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)

(setq revive:major-mode-command-alist-private
      '((w3m-mode . w3m)
        ("*w3m*" . w3m)))

(defalias 'resume-save 'save-current-configuration)

;; (define-key global-map (kbd "C-x S") 'save-current-configuration)
;; (define-key global-map (kbd "C-x F") 'resume)
(add-hook 'kill-emacs-hook 'save-current-configuration)

