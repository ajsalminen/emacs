;; user the snippent below to bootstrap el-get
;; don't leave uncommented unless you like pain

(defun redo-el-get ()
  (interactive)
  (progn
    (ignore-errors
      (delete-directory "~/.emacs.d/el-get" t))
    (url-retrieve
     "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
     (lambda (s)
       (end-of-buffer)
       (eval-print-last-sexp)))))

;; separate el-get stuff into its own file
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; (el-get 'sync)
;; (require 'el-get)

(setq el-get-git-shallow-clone t)

(defun el-get-rebuild ()
  (interactive)
  (let* ((package-list (directory-files el-get-dir nil "^[^\\.]")))
    (mapcar '(lambda (arg) (el-get-post-install arg)) package-list)))

(defun el-get-can-exit-p ()
  (or (not (get 'el-get-standard-packages 'customized-value))
      (customize-save-variable 'el-get-standard-packages el-get-standard-packages)))

(defun force-git-add-after-el-get (package-path)
  (let* ((git-executable (el-get-executable-find "git"))
         (name (format "*git add subdir %s*" package))   )
    (message "===========================================")
    (message (format "cd %s && %s add %s/" el-get-dir git-executable package-path))
    (shell-command (format "cd %s && %s add %s/" el-get-dir git-executable package-path))
    (message "===========================================")))

(add-hook 'el-get-post-install-hooks 'force-git-add-after-el-get)
(add-hook 'el-get-post-update-hooks 'force-git-add-after-el-get)

;; (setq el-get-init-files-pattern "~/emacs/init.d/[0-9]*.el")
;; (setq el-get-sources nil)
(setq el-get-sources
      '(google-weather
        ;; (:name ecb
        ;; :depends (cedet)
        ;; :type cvs
        ;; :module "ecb"
        ;; :url ":pserver:anonymous@ecb.cvs.sourceforge.net:/cvsroot/ecb"
        ;; :build ((concat "make CEDET=" " EMACS=" el-get-emacs))
        ;; )
        (:name bbdb-vcard
               :depends (bbdb)
               :type git
               :url "https://github.com/trebb/bbdb-vcard.git"
               :features bbdb-vcard)
        (:name tail
               :after (lambda ()
                        (autoload 'tail-file "tail.el" nil t)))
        ;; (:name ecb
        ;; :after (lambda ()
        ;; (setq ecb-layout-name "left8")
        ;; ;;(setq ecb-auto-activate t)
        ;; (setq ecb-tip-of-the-day nil)
        ;; (setq ecb-fix-window-size (quote width))
        ;; (setq ecb-compile-window-width (quote edit-window))
        ;; (setq ecb-major-modes-deactivate '(wl-mode tramp-mode))
        ;; ;;(setq ecb-major-modes-activate '(text-mode LaTeX-mode latex-mode))
        ;; (setq ecb-windows-width 25)))
        ;; (:name apel
        ;; :type git
        ;; :module "apel"
        ;; :url "https://github.com/wanderlust/apel.git"
        ;; :build
        ;; (mapcar
        ;; (lambda (target)
        ;; (list el-get-emacs
        ;; (split-string "-batch -q -no-site-file -l APEL-MK -f")
        ;; target
        ;; "prefix" "site-lisp" "site-lisp"))
        ;; '("compile-apel" "install-apel"))
        ;; :load-path ("site-lisp/apel" "site-lisp/emu"))
        ;; (:name flim
        ;; :type git
        ;; :module "flim"
        ;; :url "https://github.com/wanderlust/flim.git"
        ;; :build
        ;; (mapcar
        ;; (lambda (target)
        ;; (list el-get-emacs
        ;; (mapcar (lambda (pkg)
        ;; (mapcar (lambda (d) `("-L" ,d)) (el-get-load-path pkg)))
        ;; '("apel"))

        ;; (split-string "-batch -q -no-site-file -l FLIM-MK -f")
        ;; target
        ;; "prefix" "site-lisp" "site-lisp"))
        ;; '("compile-flim" "install-flim"))
        ;; :load-path ("site-lisp/flim"))
        ;; (:name semi
        ;; :type git
        ;; :module "semi"
        ;; :url "https://github.com/wanderlust/semi.git"
        ;; :build
        ;; (mapcar
        ;; (lambda (target)
        ;; (list el-get-emacs
        ;; (mapcar (lambda (pkg)
        ;; (mapcar (lambda (d) `("-L" ,d)) (el-get-load-path pkg)))
        ;; '("apel" "flim"))
        ;; (split-string "-batch -q -no-site-file -l SEMI-MK -f")
        ;; target
        ;; "prefix" "NONE" "NONE"))
        ;; '("compile-semi" "install-semi")))
        (:name bbdb
               :type git
               :url "git://github.com/baron/bbdb.git"
               ;; :load-path ("./lisp" "./bits")
               ;; :build ("autoconf" "./configure" "make autoloads" "make")
               ;; ;; :build/darwin ("autoconf" "./configure --with-emacs=/Applications/Emacs.app/Contents/MacOS/Emacs" "make autoloads" "make")
               ;; :build/darwin (("autoconf") ("./configure --with-emacs=/Applications/Emacs.app/Contents/MacOS/Emacs") ("make autoloads") (cp ) ("make"))

               :load-path ("./lisp")
               ;; if using vm, add `--with-vm-dir=DIR' after ./configure
               :build `("autoconf" ,(concat "./configure --with-emacs=" el-get-emacs)
                        "make clean" "rm -f lisp/bbdb-autoloads.el"
                        "make bbdb")
               :features bbdb-loaddefs
               :autoloads nil

               ;; :features bbdb
               ;; ;; :after (lambda () (bbdb-initialize))
               ;; :info "texinfo"

               ;; :type git
               ;; :url "https://github.com/barak/BBDB.git"
               ;; :load-path ("./lisp" "./bits")
               ;; :build ("./configure" "make autoloads" "make")
               ;; :build/darwin `(,(concat "./configure --with-emacs=" el-get-emacs) "make autoloads" "make")
               ;; :features bbdb
               ;; :autoloads nil
               ;; :post-init (lambda () (bbdb-initialize))
               ;; :info "texinfo"
               ;; :type git
               ;; :url "git://git.savannah.nongnu.org/bbdb.git"
               ;; :load-path ("./lisp")
               ;; :build `(,(concat "make EMACS=" el-get-emacs "-C lisp"))
               ;; :features bbdb
               ;; :autoloads nil
               ;; :post-init (lambda () (bbdb-initialize))
               ;; :info "texinfo"

               :after (lambda ()
                        (setq
                         bbdb-offer-save 1 ;; 1 means save-without-asking
                         bbdb-use-pop-up t ;; allow popups for addresses
                         bbdb-electric-p t ;; be disposable with SPC
                         bbdb-popup-target-lines 1 ;; very small
                         bbdb-dwim-net-address-allow-redundancy t ;; always use full name
                         bbdb-quiet-about-name-mismatches 2 ;; show name-mismatches 2 secs
                         bbdb-always-add-address t ;; add new addresses to existing...
                         ;; ...contacts automatically
                         bbdb-canonicalize-redundant-nets-p t ;; x@foo.bar.cx => x@bar.cx
                         bbdb-completion-type nil ;; complete on anything
                         bbdb-complete-name-allow-cycling t ;; cycle through matches
                         ;; this only works partially
                         bbbd-message-caching-enabled t ;; be fast
                         bbdb-use-alternate-names t ;; use AKA
                         bbdb-elided-display t ;; single-line addresses
                         ;; auto-create addresses from mail
                         bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook
                         bbdb-ignore-some-messages-alist ;; don't ask about fake addresses
                         ;; NOTE: there can be only one entry per HEADer (such as To, From)
                         ;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html
                         '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|facebookmail\\|twitter"))))
               (bbdb-insinuate-message)
               (bbdb-autoinitialize)
               (bbdb-mua-auto-update-init 'gnus 'message 'wl)
               (add-hook 'mail-setup-hook 'bbdb-insinuate-sendmail)

               )


        (:name wanderlust
               :description "Wanderlust bootstrap."
               :depends semi
               :type github
               :pkgname "wanderlust/wanderlust"
               :build (mapcar
                       (lambda (target-and-dirs)
                         (list el-get-emacs
                               (mapcar (lambda (pkg)
                                         (mapcar (lambda (d) `("-L" ,d)) (el-get-load-path pkg)))
                                       (append
                                        '("apel" "flim" "semi")
                                        (when (el-get-package-exists-p "bbdb") (list "bbdb"))))
                               "--eval" (el-get-print-to-string
                                         '(progn (setq wl-install-utils t)
                                                 (setq wl-info-lang "en")
                                                 (setq wl-news-lang "en")))

                               (split-string "-batch -q -no-site-file -l WL-MK -f")
                               target-and-dirs))
                       '(("wl-texinfo-format" "doc")
                         ("compile-wl-package" "site-lisp" "icons")
                         ("install-wl-package" "site-lisp" "icons")))
               :info "doc/wl.info"
               :load-path ("site-lisp/wl" "utils"))

        ;; (:name wanderlust
        ;; ;; :type git
        ;; ;; :module "wanderlust"
        ;; ;; :depends (apel flim semi)
        ;; ;; :url "https://github.com/wanderlust/wanderlust.git"
        ;; ;; :build (mapcar
        ;; ;; (lambda (target-and-dirs)
        ;; ;; (list el-get-emacs
        ;; ;; (mapcar (lambda (pkg)
        ;; ;; (mapcar (lambda (d) `("-L" ,d)) (el-get-load-path pkg)))
        ;; ;; '("apel" "flim" "semi"))

        ;; ;; "--eval" (prin1-to-string
        ;; ;; '(progn (setq wl-install-utils t)
        ;; ;; (setq wl-info-lang "en")
        ;; ;; (setq wl-news-lang "en")))

        ;; ;; (split-string "-batch -q -no-site-file -l WL-MK -f")
        ;; ;; target-and-dirs))
        ;; ;; '(("wl-texinfo-format" "doc")
        ;; ;; ("compile-wl-package" "site-lisp" "icons")
        ;; ;; ("install-wl-package" "site-lisp" "icons")))
        ;; ;; :info "doc/wl.info"
        ;; ;; :load-path ("site-lisp/wl" "utils")
        ;; :after (lambda ()
        ;; (autoload 'wl "wl" "Wanderlust" t)
        ;; (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
        ;; (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
        ;; (if (featurep 'ecb)
        ;; (add-hook 'wl-init-hook 'ecb-deactivate))
        ;; ;;(add-hook 'wl-exit-hook 'ecb-activate)
        ;; (require 'mime-w3m)
        ;; (defalias 'wle 'wl-exit)
        ;; (defalias 'wlo 'wl-other-frame)
        ;; (add-hook 'mime-view-mode-hook
        ;; (lambda ()
        ;; (local-set-key "s" 'w3m-view-this-url-new-session)))
        ;; (add-hook 'wl-init-hook (lambda ()
        ;; (require 'bbdb-wl)
        ;;                                       (:name wanderlust
        ;;                                               ;; :type git
        ;;                                               ;; :module "wanderlust"
        ;;                                               ;; :depends (apel flim semi)
        ;;                                               ;; :url "https://github.com/wanderlust/wanderlust.git"
        ;;                                               ;; :build (mapcar
        ;;                                               ;; (lambda (target-and-dirs)
        ;;                                               ;; (list el-get-emacs
        ;;                                               ;; (mapcar (lambda (pkg)
        ;;                                               ;; (mapcar (lambda (d) `("-L" ,d)) (el-get-load-path pkg)))
        ;;                                               ;; '("apel" "flim" "semi"))

        ;;                                               ;; "--eval" (prin1-to-string
        ;;                                               ;; '(progn (setq wl-install-utils t)
        ;;                                               ;; (setq wl-info-lang "en")
        ;;                                               ;; (setq wl-news-lang "en")))

        ;;                                               ;; (split-string "-batch -q -no-site-file -l WL-MK -f")
        ;;                                               ;; target-and-dirs))
        ;;                                               ;; '(("wl-texinfo-format" "doc")
        ;;                                               ;; ("compile-wl-package" "site-lisp" "icons")
        ;;                                               ;; ("install-wl-package" "site-lisp" "icons")))
        ;;                                               ;; :info "doc/wl.info"
        ;;                                               ;; :load-path ("site-lisp/wl" "utils")
        ;;                                               :after (lambda ()
        ;;                                                       (autoload 'wl "wl" "Wanderlust" t)
        ;;                                                       (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
        ;;                                                       (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
        ;;                                                       (if (featurep 'ecb)
        ;;                                                       (add-hook 'wl-init-hook 'ecb-deactivate))
        ;;                                                       ;;(add-hook 'wl-exit-hook 'ecb-activate)
        ;;                                                       (require 'mime-w3m)
        ;;                                                       (defalias 'wle 'wl-exit)
        ;;                                                       (defalias 'wlo 'wl-other-frame)
        ;;                                                       (add-hook 'mime-view-mode-hook
        ;;                                                               (lambda ()
        ;;                                                               (local-set-key "s" 'w3m-view-this-url-new-session)))
        ;;                                                       (add-hook 'wl-init-hook (lambda ()
        ;;                                                                               (require 'bbdb-wl)
        ;;                                                                               (bbdb-wl-setup)))
        ;;                                                       (require 'wl-draft)
        ;;                                                       (add-hook 'wl-draft-mode-hook
        ;;                                                               (lambda ()
        ;;                                                               (flyspell-mode t)
        ;;                                                               (define-key wl-draft-mode-map (kbd "<tab>") 'bbdb-complete-name)))
        ;;                                                       (require 'offlineimap)
        ;;                                                       (setq offlineimap-enable-mode-line-p t)
        ;;                                                       (defun kill-offlineimap ()
        ;;                                                       (interactive)
        ;;                                                       (shell-command "kill `cat ~/.offlineimap/pid`")
        ;;                                                       (ignore-errors
        ;;                                                       (save-excursion
        ;;                                                              (set-buffer (get-buffer-create "*OfflineIMAP*"))
        ;;                                                              (offlineimap-kill))))
        ;;                                                       (defun restart-offlineimap ()
        ;;                                                       (interactive)
        ;;                                                       (ignore-errors
        ;;                                                       (kill-offlineimap))
        ;;                                                       (offlineimap))
        ;;                                                       (defun resync-offlineimap ()
        ;;                                                       (interactive)
        ;;                                                       (condition-case err
        ;;                                                              (offlineimap-resync)
        ;;                                                       (error
        ;;                                                       (offlineimap))))

        ;;                                                       (add-hook 'wl-init-hook 'restart-offlineimap)
        ;;                                                       (add-hook 'wl-exit-hook 'resync-offlineimap)
        ;;                                                       (add-hook 'wl-summary-exit-hook 'resync-offlineimap)
        ;;                                                       (add-hook 'wl-summary-prepared-hook '(lambda ()
        ;;                                                                                               (wl-summary-rescan "date" t )
        ;;                                                                                               (beginning-of-buffer)))

        ;;                                                       (defun imapfilter ()
        ;;                                                       (interactive)
        ;;                                                       (message "calling imapfilter…")
        ;;                                                       (when (and (file-readable-p "~/.imapfilter/config.lua")
        ;;                                                               (executable-find "imapfilter"))
        ;;                                                       (if (start-process "imapfilter" "imapfilter" "imapfilter")
        ;;                                                               (message "imapfilter ran fine.")
        ;;                                                              (message "error running imapfilter!"))))

        ;;                                                       (add-hook 'wl-folder-check-entity-pre-hook 'imapfilter)

        ;;                                                       (setq wl-icon-directory "~/.emacs.d/el-get/wanderlust/icons")
        ;;                                                       (require 'wl-gravatar)
        ;;                                                       (setq wl-highlight-x-face-function 'wl-gravatar-insert)
        ;;                                                       (setq gnus-gravatar-directory "~/.emacs-gravatar/")
        ;;                                                       (setq gravatar-unregistered-icon 'identicon)
        ;;                                                       (setq wl-gravatar-retrieve-once t)

        ;;                                                       (autoload 'mu-cite-original "mu-cite" nil t)
        ;;                                                       (setq mu-cite-prefix-format '("> "))
        ;;                                                       (setq mu-cite-top-format '("\n\n" full-name "'s message :\n\n"))
        ;;                                                       (add-hook 'mail-citation-hook (function mu-cite-original))
        ;;                                                       ;; (unless (assq 'signature wl-draft-config-sub-func-alist)
        ;;                                                       ;; (wl-append wl-draft-config-sub-func-alist
        ;;                                                       ;; '((signature . wl-draft-config-sub-signature))))
        ;;                                                       (defun wl-draft-config-sub-signature (content)
        ;;                                                       "Insert the signature at the end of the MIME message."
        ;;                                                       (let ((signature-insert-at-eof nil)
        ;;                                                               (signature-file-name content))
        ;;                                                       (goto-char (mime-edit-content-end))
        ;;                                                       (insert-signature)))
        ;;                                                       )) (bbdb-wl-setup)))
        ;; (require 'wl-draft)
        ;; (add-hook 'wl-draft-mode-hook
        ;; (lambda ()
        ;; (flyspell-mode t)
        ;; (define-key wl-draft-mode-map (kbd "<tab>") 'bbdb-complete-name)))
        ;; (require 'offlineimap)
        ;; (setq offlineimap-enable-mode-line-p t)
        ;; (defun kill-offlineimap ()
        ;; (interactive)
        ;; (shell-command "kill `cat ~/.offlineimap/pid`")
        ;; (ignore-errors
        ;; (save-excursion
        ;; (set-buffer (get-buffer-create "*OfflineIMAP*"))
        ;; (offlineimap-kill))))
        ;; (defun restart-offlineimap ()
        ;; (interactive)
        ;; (ignore-errors
        ;; (kill-offlineimap))
        ;; (offlineimap))
        ;; (defun resync-offlineimap ()
        ;; (interactive)
        ;; (condition-case err
        ;; (offlineimap-resync)
        ;; (error
        ;; (offlineimap))))

        ;; (add-hook 'wl-init-hook 'restart-offlineimap)
        ;; (add-hook 'wl-exit-hook 'resync-offlineimap)
        ;; (add-hook 'wl-summary-exit-hook 'resync-offlineimap)
        ;; (add-hook 'wl-summary-prepared-hook '(lambda ()
        ;; (wl-summary-rescan "date" t )
        ;; (beginning-of-buffer)))

        ;; (defun imapfilter ()
        ;; (interactive)
        ;; (message "calling imapfilter…")
        ;; (when (and (file-readable-p "~/.imapfilter/config.lua")
        ;; (executable-find "imapfilter"))
        ;; (if (start-process "imapfilter" "imapfilter" "imapfilter")
        ;; (message "imapfilter ran fine.")
        ;; (message "error running imapfilter!"))))

        ;; (add-hook 'wl-folder-check-entity-pre-hook 'imapfilter)

        ;; (setq wl-icon-directory "~/.emacs.d/el-get/wanderlust/icons")
        ;; (require 'wl-gravatar)
        ;; (setq wl-highlight-x-face-function 'wl-gravatar-insert)
        ;; (setq gnus-gravatar-directory "~/.emacs-gravatar/")
        ;; (setq gravatar-unregistered-icon 'identicon)
        ;; (setq wl-gravatar-retrieve-once t)

        ;; (autoload 'mu-cite-original "mu-cite" nil t)
        ;; (setq mu-cite-prefix-format '("> "))
        ;; (setq mu-cite-top-format '("\n\n" full-name "'s message :\n\n"))
        ;; (add-hook 'mail-citation-hook (function mu-cite-original))
        ;; ;; (unless (assq 'signature wl-draft-config-sub-func-alist)
        ;; ;; (wl-append wl-draft-config-sub-func-alist
        ;; ;; '((signature . wl-draft-config-sub-signature))))
        ;; (defun wl-draft-config-sub-signature (content)
        ;; "Insert the signature at the end of the MIME message."
        ;; (let ((signature-insert-at-eof nil)
        ;; (signature-file-name content))
        ;; (goto-char (mime-edit-content-end))
        ;; (insert-signature)))
        ;; ))
        ))
(el-get 'sync)
(message "LOADING: el-get initialized")
