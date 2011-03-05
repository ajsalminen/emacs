(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
;; (setq el-get-init-files-pattern "~/emacs/init.d/[0-9]*.el")
;; (setq el-get-sources nil)
(setq el-get-sources
      '((:name tail
               :after (lambda ()
                        (autoload 'tail-file "tail.el" nil t)))
        (:name cedet)
        (:name ecb
               :after (lambda ()
                        (setq ecb-layout-name "left8")
                        ;;(setq ecb-auto-activate t)
                        (setq ecb-tip-of-the-day nil)
                        (setq ecb-fix-window-size (quote width))
                        (setq ecb-compile-window-width (quote edit-window))
                        (setq ecb-major-modes-deactivate '(wl-mode tramp-mode))
                        ;;(setq ecb-major-modes-activate '(text-mode LaTeX-mode latex-mode))
                        (setq ecb-windows-width 25)))
        (:name apel
               :type git
               :module "apel"
               :url "https://github.com/wanderlust/apel.git"
               :build
               (mapcar
                (lambda (target)
                  (list el-get-emacs
                        (split-string "-batch -q -no-site-file -l APEL-MK -f")
                        target
                        "prefix" "site-lisp" "site-lisp"))
                '("compile-apel" "install-apel"))
               :load-path ("site-lisp/apel" "site-lisp/emu"))
        (:name flim
               :type git
               :module "flim"
               :url "https://github.com/wanderlust/flim.git"
               :build
               (mapcar
                (lambda (target)
                  (list el-get-emacs
                        (mapcar (lambda (pkg)
                                  (mapcar (lambda (d) `("-L" ,d)) (el-get-load-path pkg)))
                                '("apel"))

                        (split-string "-batch -q -no-site-file -l FLIM-MK -f")
                        target
                        "prefix" "site-lisp" "site-lisp"))
                '("compile-flim" "install-flim"))
               :load-path ("site-lisp/flim"))
        (:name semi
               :type git
               :module "semi"
               :url "https://github.com/wanderlust/semi.git"
               :build
               (mapcar
                (lambda (target)
                  (list el-get-emacs
                        (mapcar (lambda (pkg)
                                  (mapcar (lambda (d) `("-L" ,d)) (el-get-load-path pkg)))
                                '("apel" "flim"))
                        (split-string "-batch -q -no-site-file -l SEMI-MK -f")
                        target
                        "prefix" "NONE" "NONE"))
                '("compile-semi" "install-semi")))
        (:name bbdb
               :type git
               :url "https://github.com/barak/BBDB.git"
               :load-path ("./lisp" "./bits")
               :build ("./configure" "make autoloads" "make")
               :build/darwin `(,(concat "./configure --with-emacs=" el-get-emacs) "make autoloads" "make")
               :features bbdb
               :autoloads nil
               :post-init (lambda () (bbdb-initialize))
               :info "texinfo"
               :after (lambda ()
                        (setq
                         bbdb-offer-save 1             ;; 1 means save-without-asking
                         bbdb-use-pop-up t             ;; allow popups for addresses
                         bbdb-electric-p t             ;; be disposable with SPC
                         bbdb-popup-target-lines  1    ;; very small
                         bbdb-dwim-net-address-allow-redundancy t ;; always use full name
                         bbdb-quiet-about-name-mismatches 2 ;; show name-mismatches 2 secs
                         bbdb-always-add-address t ;; add new addresses to existing...
                         ;; ...contacts automatically
                         bbdb-canonicalize-redundant-nets-p t  ;; x@foo.bar.cx => x@bar.cx
                         bbdb-completion-type nil              ;; complete on anything
                         bbdb-complete-name-allow-cycling t    ;; cycle through matches
                         ;; this only works partially
                         bbbd-message-caching-enabled t ;; be fast
                         bbdb-use-alternate-names t     ;; use AKA
                         bbdb-elided-display t          ;; single-line addresses
                         ;; auto-create addresses from mail
                         bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook
                         bbdb-ignore-some-messages-alist ;; don't ask about fake addresses
                         ;; NOTE: there can be only one entry per header (such as To, From)
                         ;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html
                         '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|facebookmail\\|twitter"))))
               (bbdb-insinuate-message)
               (add-hook 'mail-setup-hook 'bbdb-insinuate-sendmail)

               )
        (:name wanderlust
               :type git
               :module "wanderlust"
               :url "https://github.com/wanderlust/wanderlust.git"
               :build (mapcar
                       (lambda (target-and-dirs)
                         (list el-get-emacs
                               (mapcar (lambda (pkg)
                                         (mapcar (lambda (d) `("-L" ,d)) (el-get-load-path pkg)))
                                       '("apel" "flim" "semi"))

                               "--eval" (prin1-to-string
                                         '(progn (setq wl-install-utils t)
                                                 (setq wl-info-lang "en")
                                                 (setq wl-news-lang "en")))

                               (split-string "-batch -q -no-site-file -l WL-MK -f")
                               target-and-dirs))
                       '(("wl-texinfo-format" "doc")
                         ("compile-wl-package"  "site-lisp" "icons")
                         ("install-wl-package" "site-lisp" "icons")))
               :info "doc/wl.info"
               :load-path ("site-lisp/wl" "utils")
               :after (lambda ()
                        (autoload 'wl "wl" "Wanderlust" t)
                        (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
                        (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
                        (if (featurep 'ecb)
                            (add-hook 'wl-init-hook 'ecb-deactivate))
                        ;;(add-hook 'wl-exit-hook 'ecb-activate)
                        (require 'mime-w3m)
                        (defalias 'wle 'wl-exit)
                        (add-hook 'mime-view-mode-hook
                                  (lambda ()
                                    (local-set-key "s" 'w3m-view-this-url-new-session)))
                        (add-hook 'wl-init-hook (lambda ()
                                                  (require 'bbdb-wl)
                                                  (bbdb-wl-setup)))
                        (require 'wl-draft)
                        (add-hook 'wl-draft-mode-hook
                                  (lambda ()
                                    (define-key wl-draft-mode-map (kbd "<tab>") 'bbdb-complete-name)))


                        ))
        ))
(el-get)