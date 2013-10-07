(eval-when-compile (require 'cl))

;; Turn off early to avoid momentary display.
(mapc
 (lambda (mode)
   (if (fboundp mode)
       (funcall mode -1)))
 '(menu-bar-mode tool-bar-mode scroll-bar-mode))

;; the mother of all load paths
;; TODO: consolidate "lisp" folder and "site-lisp"
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; (let ((default-directory (expand-file-name "~/.emacs.d/site-lisp/")))
;;   (add-to-list 'load-path default-directory)
;;   (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;       (normal-top-level-add-subdirs-to-load-path)))

;; (let ((default-directory "~/.emacs.d/site-lisp/"))
;;   (normal-top-level-add-to-load-path '("."))
;;   (normal-top-level-add-subdirs-to-load-path))

(setq more-load-paths '("~/.emacs.d/el-get/bbdb/lisp/"
                        "~/.emacs.d/el-get/bbdb-vcard/"
                        "~/.emacs.d/el-get/el-get"
                        "~/.emacs.d/el-get/google-weather"
                        "~/.emacs.d/inits"
			"~/.emacs.d/site-lisp"))

(setq load-path (append load-path more-load-paths))

(require 'init-benchmarking)

(setq initsplit-sort-customizations t)
(setq initsplit-default-directory "~/.emacs.d/inits/")
(setq initsplit-dynamic-customizations-alist
      '(("^w3m-" "16-w3m-init.el" nil)
	("^\\(preview\\|font-latex\\|latex\\|tex\\)-"
	 "17-tex-init.el" nil)
	))

(require 'init-loader)
(setq init-loader-show-log-after-init t)
(setq init-loader-byte-compile t)

(init-loader-load "~/.emacs.d/inits/")

;; FIXME: doesn't seem to work
(require 'initsplit)

(require 'bookmark)



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


(message "LOADING: extra settings")

(setq abbrev-file-name "~/.abbrev_defs")
(setq save-abbrevs t)
(if (file-exists-p abbrev-file-name)
    (quietly-read-abbrev-file))

(setq default-abbrev-mode t)

(require 'gitconfig-mode)
(add-to-list 'auto-mode-alist '("/\\.gittrees\\'" . gitconfig-mode))

;; should restore all buffers, etc.
(resume)

(message "init completed in %.2fms"
         (sanityinc/time-subtract-millis (current-time) before-init-time))
(message "********** successfully initialized **********")
