;;; UNCOMMENT THIS TO DEBUG TROUBLE GETTING EMACS UP AND RUNNING.
(setq debug-on-error t)
(setq eval-expression-debug-on-error t)
(setq lang "en_US")
(setq inhibit-splash-screen t)

;; workaround for cocoa emacs byte-compiling
(when (eq window-system 'ns)
  (setq warning-suppress-types nil)
  (setq ispell-program-name "/usr/local/bin/aspell"))

;; the mother of all load paths
(setq more-load-paths '("~/.emacs.d/auctex-11.86"
                        "~/.emacs.d/auctex-11.86/preview"
                        "~/.emacs.d/auto-complete"
                        "~/.emacs.d/bbdb-2.35/lisp/"
                        "~/.emacs.d/cedet-1.0/common/"
                        "~/.emacs.d/color-theme"
                        "~/.emacs.d/dictionary-el/"
                        "~/.emacs.d/el-get/bbdb/lisp/"
                        "~/.emacs.d/el-get/bbdb-vcard/"
                        "~/.emacs.d/el-get/el-get"
                        "~/.emacs.d/el-get/google-weather"
                        "~/.emacs.d/elib-1.0"
                        "~/.emacs.d/ensime_2.9.1-0.7.6/elisp"
                        "~/.emacs.d/ess-5.11/lisp"
                        "~/.emacs.d/jdee/dist/jdee-2.4.1/lisp"
                        "~/.emacs.d/magit"
                        "~/.emacs.d/malabar-1.5-SNAPSHOT/lisp"
                        "~/.emacs.d/mu-cite"
                        "~/.emacs.d/mu4e"
                        "~/.emacs.d/muse-3.20/lisp"
                        "~/.emacs.d/navi2ch"
                        "~/.emacs.d/org-mode/contrib/lisp"
                        "~/.emacs.d/org-mode/lisp"
                        "~/.emacs.d/reftex-4.34a/lisp"
                        "~/.emacs.d/rhtml"
                        "~/.emacs.d/rinari"
                        "~/.emacs.d/site-lisp"
                        "~/.emacs.d/skype"
                        "~/.emacs.d/twittering"
                        "~/.emacs.d/vim"
                        "~/.emacs.d/yasnippet"
                        "~/.emacs.d/yatex1.74.4"))

(setq load-path (append load-path more-load-paths))

;; (defun kill-ci-buffer ()
;;  (interactive)
;;  (switch-to-buffer " *Compiler Input*")
;;  (set-buffer-modified-p nil)
;;  (kill-buffer " *Compiler Input*"))

;; (kill-ci-buffer)

(setq font-lock-verbose nil)
(setq byte-compile-verbose nil)
(setq bcc-cache-directory "~/.elispcache")

;; Emervency stuff that I want before debugging init files
;; On Mac OS X, Emacs launched from a bundle
;; needs paths to be set explicitly
(add-to-list 'exec-path (getenv "PATH"))
(push "/usr/local/bin/scala/bin/" exec-path)
(push "/usr/local/bin/" exec-path)
(push "/usr/bin/" exec-path)
;; Setup PATH

(eval-when-compile (require 'cl))
(when (and (>= emacs-major-version 23) (eq window-system 'ns))
  (setq mac-option-key-is-meta nil)
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)
  (setq mac-option-modifier 'super)

  (when (not (featurep 'aquamacs))
    (mac-set-input-method-parameter `japanese `cursor-color "yellow")
    (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `cursor-color "yellow")

    ;; really important when typing commasand such
    (mac-add-key-passed-to-system 'shift)))

(when (and (>= emacs-major-version 23) (or (eq window-system 'ns) (eq window-system 'x)))
  (setenv "PATH" (shell-command-to-string "source ~/.zshrc; echo -n $PATH")) ;
  (when (eq window-system 'x)
    (setenv "PATH" (concat "/usr/local/texlive/2010/bin/i386-linux:" (getenv "PATH"))))
  ;; Update exec-path with the contents of $PATH
  (loop for path in (split-string (getenv "PATH") ":") do
        (add-to-list 'exec-path path)))

(require 'color-theme)
(require 'color-theme-invaders)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-invaders)))

(defun color-theme-reset ()
  (interactive)
  (color-theme-reset-faces))

(require 'paredit)
(require 'highlight-parentheses)

(setq hl-paren-colors
      '("orange1" "yellow1" "greenyellow" "green1"
        "springgreen1" "cyan1" "slateblue1" "magenta1" "purple"))

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook (lambda () (rainbow-delimiters-mode t) (paredit-mode t)))
(add-hook 'emacs-lisp-mode-hook (lambda () (rainbow-delimiters-mode t) (paredit-mode t)))
(add-hook 'slime-repl-mode-hook (lambda () (rainbow-delimiters-mode t) (paredit-mode t)))

(require 'bookmark)
(require 'anything-config)

;; (require 'anything-startup)
(global-set-key (kbd "C-z") 'anything)
(global-set-key (kbd "C-h h") 'anything)

(setq anything-idle-delay 0.3)
(setq anything-input-idle-delay 0.2)
(setq anything-candidate-number-limit 100)
(require 'anything-c-shell-history)
(require 'anything-yaetags)
(global-set-key (kbd "M-.") 'anything-yaetags-find-tag)
;; (global-set-key (kbd "M-.") 'find-tag)

(require 'anything-match-plugin)
(require 'eijiro)
(setq eijiro-directory "~/Downloads/EDP-124/EIJIRO/") ; 英辞郎の辞書を置いているディレクトリ

(setq anything-sources
      '(anything-c-source-recentf
        anything-c-source-info-pages
        anything-c-source-info-elisp
        anything-c-source-buffers
        ;; anything-c-source-shell-history
        anything-c-source-file-name-history
        anything-c-source-locate
        anything-c-source-occur))

(require 'descbinds-anything)
(descbinds-anything-install)
(defalias 'rf 'anything-recentf)

(require 'icicles)
(icy-mode 1)
(global-set-key "\C-x\ \C-r" 'icicle-recent-file)
;;(setq icicle-TAB-completion-methods (quote (fuzzy basic vanilla)))

(require 'smex)
(smex-initialize)
(setq smex-auto-update t)
(run-at-time t 360 '(lambda () (if (smex-detect-new-commands) (smex-update))))

(defvar prev-minibuffer-input-method nil "save previously set inputmethod")
(defun toggle-back-minibuffer-input ()
  (interactive)
  (progn
    (activate-input-method (if (boundp 'prev-minibuffer-input-method)
                               prev-minibuffer-input-method
                             current-input-method))))
;; (add-hook 'minibuffer-exit-hook 'toggle-back-minibuffer-input)

(defun enter-minibuf-with-toggle-input-method (f)
  (interactive)
  (progn
    (setq prev-minibuffer-input-method current-input-method)
    (activate-input-method nil)
    (funcall f)))

(defun smex-with-toggle ()
  (interactive)
  (enter-minibuf-with-toggle-input-method 'smex))

;; (global-set-key (kbd "C-'") 'smex-with-toggle)
(global-set-key (kbd "C-'") 'smex)

(defun smex-hack ()
  (interactive)
  (progn
    (smex)
    (keyboard-quit)
    (smex)))

;; (global-set-key (kbd "M-x") 'smex-hack)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(iswitchb-mode 1)

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                                     clojure-mode scheme-mode
                                                     haskell-mode ruby-mode
                                                     rspec-mode python-mode
                                                     c-mode c++-mode
                                                     objc-mode latex-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))

(define-key global-map (kbd "RET") 'reindent-then-newline-and-indent)

(setq emerge-diff-options "--ignore-all-space")

(defun machine-ip-address (dev)
  "Return IP address of a network device."
  (let ((info (network-interface-info dev)))
    (if info
        (format-network-address (car info) t))))

;; emergency settings end here

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (require 'package)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))
  ;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize))

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
                         ;; NOTE: there can be only one entry per header (such as To, From)
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
(message "el-get initialized")


;; All my custom settings that differ and/or can't be under version control
(setq custom-file "~/custom.el")
(load custom-file 'noerror)
(setq blog-file "~/blogs.el")
(load blog-file 'noerror)

(setq Info-directory-list
      '("/usr/local/share/info" "~/info" "~/devdocs" "/usr/share/info" "/usr/local/info" "/usr/share/info/emacs-23"))
(message "loaded custom stuff")


;;; this was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(el-get-standard-packages (quote ("semi" "apel" "el-get" "google-weather" "bbdb-vcard" "tail" "bbdb" "wanderlust"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(message "packages initialized")


(setq initial-scratch-message nil)

;;(require 'byte-code-cache)

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(let ((nfsdir "~/.emacs.d/site-lisp")
      (cachedir "~/.elispcache"))
  (setq load-path (append load-path (list cachedir nfsdir)))
  (require 'elisp-cache)
  (setq elisp-cache-byte-compile-files t)
  (setq elisp-cache-freshness-delay 0)
  (elisp-cache nfsdir cachedir))


(setq-default indent-tabs-mode nil)

(defun ib ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(require 'auto-install)

(require 'work-timer)


(setq work-timer-working-time 30)
;;(defalias 'work-timer-start 'p)

(defun short-file-name ()
  "Display the file path and name in the modeline"
  (interactive "*")
  (setq-default mode-line-buffer-identification '("%12b")))

(defun long-file-name ()
  "Display the full file path and name in the modeline"
  (interactive "*")
  (setq-default mode-line-buffer-identification
                '("%S:" (buffer-file-name "%f"))))

(defface egoge-display-time
  '((((type x w32 mac))
     ;; #060525 is the background colour of my default face.
     (:foreground "#060525" :inherit bold))
    (((type tty))
     (:foreground "blue")))
  "Face used to display the time in the mode line.")

;; This causes the current time in the mode line to be displayed in
;; `egoge-display-time-face' to make it stand out visually.
(setq display-time-string-forms
      '((propertize (concat " " 24-hours ":" minutes " ")
                    'face 'egoge-display-time)))
(display-time-mode 1)
(message "various custom packages")

;; Scala configs
(let ((path "~/.emacs.d/scala"))
  (setq load-path (cons path load-path))
  (load "scala-mode-auto.el"))
(require 'scala-mode-auto)
(add-hook 'scala-mode-hook
          (lambda ()
            (local-set-key (kbd "RET") 'reindent-then-newline-and-indent)))

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(defun make-lift-doc-url (type &optional member)
  (ensime-make-java-doc-url-helper
   "http://main.scala-tools.org/mvnsites-snapshots/liftweb/scaladocs/" type member))

(add-to-list 'ensime-doc-lookup-map '("net\\.liftweb\\." . make-lift-doc-url))

(message "scala lift stuff")

;; Frame fiddling
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
      (progn
        ;; use 120 char wide window for largeish displays
        ;; and smaller 80 column windows for smaller displays
        ;; pick whatever numbers make sense for you
        (if (> (x-display-pixel-width) 1280)
            (add-to-list 'default-frame-alist (cons 'width 160))
          (add-to-list 'default-frame-alist (cons 'width 80)))
        ;; for the height, subtract a couple hundred pixels
        ;; from the screen height (for panels, menubars and
        ;; whatnot), then divide by the height of a char to
        ;; get the height we want
        (add-to-list 'default-frame-alist
                     (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))

(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)))

(defalias 'yes-or-no-p 'y-or-n-p)

;; Hard Code the window dimensions, that's how we roll
;; (set-frame-position (selected-frame) 45 0)
;; (add-to-list 'default-frame-alist (cons 'width 150))
;; (add-to-list 'default-frame-alist (cons 'height 47))
;; (message "windows dimensions")

(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; (require 'smart-tab)
(require 'tabkey2)
;; (require 'pabbrev)
(tabkey2-mode t)

;; (setq dabbrev-case-fold-search t)
;; (global-smart-tab-mode t)
;; (global-pabbrev-mode t)


;; (global-set-key (kbd "\t") 'smart-tab)
;; (global-set-key '[tab] 'smart-tab)
;;(global-set-key '[C-tab] 'pabbrev-expand-maybe)
;;(define-key pabbrev-mode-map (kbd "C-;") 'pabbrev-expand-maybe)



;;(put 'org-mode 'pabbrev-global-mode-excluded-modes t)
;;(add-to-list 'pabbrev-global-mode-excluded-modes 'org-mode)
;;(add-hook 'text-mode-hook 'pabbrev-mode)

(require 'flyspell)
(setq flyspell-issue-welcome-flag nil)

(require 'reftex)
(setq reftex-toc-split-windows-horizontally t)
(setq reftex-allow-automatic-rescan t)
(setq reftex-auto-update-selection-buffers t)
(setq reftex-enable-partial-scans t)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode

(message "load latex/reftex")
(setq reftex-plug-into-AUCTeX t)

;; (add-hook 'reftex-mode-hook 'reftex-toc)

(setq TeX-default-mode 'japanese-latex-mode)

(defun reftex-toc-rescan-after-save (&rest ignore)
  (interactive)
  (if (boundp 'reftex-last-toc-file)
      (switch-to-buffer-other-window
       (reftex-get-file-buffer-force reftex-last-toc-file)
       (reftex-toc t t))
    (reftex-toc t t)))


;; (add-hook 'LaTeX-mode-hook
;; (lambda ()
;; (add-hook 'after-save-hook (lambda ()
;; (save-excursion
;; (reftex-toc-rescan-after-save))))))

;; (add-hook 'LaTeX-mode-hook 'reftex-toc-rescan-after-save)
;; (add-hook 'latex-mode-hook 'reftex-toc-rescan-after-save)


;; Minimal OS X-friendly configuration of AUCTeX. Since there is no
;; DVI viewer for the platform, use pdftex/pdflatex by default for
;; compilation. Furthermore, use 'open' to view the resulting PDF.
;; Until Preview learns to refresh automatically on file updates, Skim
;; (http://skim-app.sourceforge.net) is a nice PDF viewer.
(setq TeX-PDF-mode t)
(setq TeX-view-program-selection
      '(((output-dvi style-pstricks)
         "dvips and PDF Viewer")
        (output-dvi "PDF Viewer")
        (output-pdf "PDF Viewer")
        (output-html "Safari")))
(setq TeX-view-program-list
      '(("dvips and PDF Viewer" "%(o?)dvips %d -o && open %f")
        ("PDF Viewer" "open %o")
        ("Safari" "open %o")))


(require 'hideshow)
(require 'fold-dwim)
(defalias 'to 'fold-dwim-toggle)
(defalias 'sho 'fold-dwim-show-all)
(defalias 'hi 'fold-dwim-hide-all)

(add-hook 'LaTeX-mode-hook (lambda ()
                             (TeX-fold-mode 1)))

(require 'yatex)
(setq YaTeX-fill-column nil)

;; ;; Alias the two major modes for fast switching
(defalias 'jl 'yatex-mode)
(defalias 'el 'japanese-latex-mode)

(require 'tex)
(add-to-list 'TeX-clean-default-intermediate-suffixes "\\.fdb_latexmk")

(eval-after-load "tex"
  '(add-to-list 'TeX-command-list '("m" "latexmk -pv -pdf %t" TeX-run-TeX nil t
                                    :help "Run Latexmk on file")))

(eval-after-load "tex"
  '(add-to-list 'TeX-command-list '("ubuntumk" "latexmk %t && platex %t && latexmk -pdfdvi %t" TeX-run-TeX nil t
                                    :help "Run Latexmk on file (with hacks from ubuntu environment)")))


;; (add-hook 'TeX-mode-hook 'reftex-toc)


;; for some reason hitting backspace in latex mode with CJK IME on
;; could be screen lines

(when (or (eq window-system 'mac) (eq window-system 'ns))
  ;; makes the input act funny
  (defun backspace-cjk-hack ()
    (interactive)
    (progn
      (delete-backward-char 1)
      (keyboard-quit)))

  ;; (defun newline-cjk-hack ()
  ;; (interactive)
  ;; (progn
  ;; (newline)
  ;; (keyboard-quit)))

  (add-hook 'LaTeX-mode-hook (lambda ()
                               ;; (define-key LaTeX-mode-map (kbd "<return>") 'newline-cjk-hack)
                               (define-key LaTeX-mode-map (kbd "<backspace>") 'backspace-cjk-hack))))

(message "pre ESS")

(setq ess-etc-directory "~/.emacs.d/ess-5.11/etc")
(require 'ess-site)
(require 'ess-eldoc)
(setq ess-source-directory (expand-file-name "~/ESS_Rdump/"))

(require 'ess-tracebug)
(add-hook 'ess-post-run-hook 'ess-debug t)
(add-hook 'ess-post-run-hook 'ess-traceback t)
(require 'ess-R-object-tooltip)
(require 'r-utils)

(add-to-list 'same-window-buffer-names "*Buffer List*")

;; Reload .emacs file by typing: Mx reload.
(defun reload-init ()
  "Reloads .emacs interactively."
  (interactive)
  (load "~/.emacs.d/init.el"))

(if (file-exists-p "~/projects/ghub")
    (setq default-directory "~/projects/ghub"))


(require 'yasnippet)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")
;; Develop and keep personal snippets under ~/emacs.d/mysnippets
(setq yas/root-directory "~/.emacs.d/mysnippets")
(yas/initialize)

(defun yas/ido-prompt-fix (prompt choices &optional display-fn)
  (when (featurep 'ido)
    (yas/completing-prompt prompt choices display-fn #'ido-completing-read)))

(setq yas/prompt-functions '(yas/ido-prompt-fix yas/dropdown-prompt yas/x-prompt))

;; Load the snippets
(yas/load-directory yas/root-directory)

(setq yas/wrap-around-region t)
(setq yas/trigger-key (kbd "C-TAB"))
(setq yas/next-field-key (kbd "TAB"))

(add-hook 'yas/minor-mode-on-hook
          '(lambda ()
             (define-key yas/minor-mode-map yas/trigger-key 'yas/expand)))

(require 'anything-c-yasnippet)
(global-set-key (kbd "C-c y") 'anything-c-yas-complete)


(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(global-set-key "\M-/" 'hippie-expand)

(message "yasnippet loading")

(defun no-pdf ()
  "Run pdftotext on the entire buffer."
  (interactive)
  (let ((modified (buffer-modified-p)))
    (erase-buffer)
    (shell-command
     (concat "pdftotext " (buffer-file-name) " -")
     (current-buffer)
     t)
    (set-buffer-modified-p modified)))

;; get text from pdf instead of viewer
;; not needed on ubuntu
(when (or (< emacs-major-version 23) (featurep 'carbon-emacs-package))
  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . no-pdf)))


(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha `(,value ,value)))


;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(100 100))
(add-to-list 'default-frame-alist '(alpha 100 100))

(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(80 50))))


;; (global-set-key (kbd "C-c t") 'toggle-transparency)
(global-set-key (kbd "C-c t") '(lambda() (interactive) (recenter 1)))

(require 'maxframe)
;; (add-hook 'window-setup-hook 'maximize-frame t)

;; just the frame thanks
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Mac AntiAlias
(setq mac-allow-anti-aliasing t)

;;Font settings for CJK fonts on Cocoa Emacs
(when (and (>= emacs-major-version 23) (or (eq window-system 'mac) (eq window-system 'ns)))
  (create-fontset-from-ascii-font
   "-apple-monaco-medium-normal-normal-*-12-*" nil "hirakaku12")

  (set-default-font "fontset-hirakaku12")
  (add-to-list 'default-frame-alist '(font . "fontset-hirakaku12"))

  (set-fontset-font
   "fontset-hirakaku12"
   'japanese-jisx0208
   "-apple-hiragino_kaku_gothic_pro-medium-normal-normal-*-14-*-iso10646-1")

  (set-fontset-font
   "fontset-hirakaku12"
   'jisx0201
   "-apple-hiragino_kaku_gothic_pro-medium-normal-normal-*-14-*-iso10646-1")

  (set-fontset-font
   "fontset-hirakaku12"
   'japanese-jisx0212
   "-apple-hiragino_kaku_gothic_pro-medium-normal-normal-*-14-*-iso10646-1")

  (set-fontset-font
   "fontset-hirakaku12"
   'katakana-jisx0201
   "-apple-hiragino_kaku_gothic_pro-medium-normal-normal-*-14-*-iso10646-1")

  (if (fboundp 'ns-toggle-fullscreen)
      (global-set-key "\M-\r" 'ns-toggle-fullscreen))

  ;; apologetic hack to make sure my mac input is used
  (defun set-mac-input ()
    (interactive)
    (progn
      (setq default-input-method "MacOSX")
      (set-input-method "MacOSX")
      (toggle-input-method)))

  (add-hook 'after-init-hook 'set-mac-input))

(when (and (< emacs-major-version 23) (eq window-system 'mac))
  (set-face-attribute 'default nil
                      :family "monaco"
                      :height 130)

  (set-fontset-font "fontset-default"
                    'katakana-jisx0201
                    '("ヒラギノ丸ゴ pro w4*" . "jisx0201.*"))

  (set-fontset-font "fontset-default"
                    'japanese-jisx0208
                    '("ヒラギノ丸ゴ pro w4*" . "jisx0208.*")))

(blink-cursor-mode t)

(message "mac setup stuff")

;; Ubuntu related settings
(when (and (= emacs-major-version 23) (eq window-system 'x))
  ;; (add-hook 'after-init-hook (lambda () (toggle-fullscreen)))

  ;; (global-set-key "\M-\r" 'toggle-fullscreen)
  (add-hook 'after-make-frame-functions 'toggle-fullscreen)
  (setq x-super-keysym 'meta)
  (setq x-alt-keysym 'meta)

  (defun swapcaps ()
    (interactive)
    (shell-command "setxkbmap -option \"ctrl:swapcaps\""))

  (global-set-key (kbd "<menu>") 'smex-with-toggle)

  (defun setup-scim ()
    (interactive)
    (require 'scim-bridge-ja)
    ;; C-SPC は Set Mark に使う
    (scim-define-common-key ?\C-\s nil)
    (scim-define-common-key ?\C-\\ t)
    (scim-define-common-key ?\C-\S-\s t)

    ;; (global-set-key (kbd "C-\\") 'scim-mode)

    ;; C-/ は Undo に使う
    (scim-define-common-key ?\C-/ nil)
    ;; SCIMの状態によってカーソル色を変化させる
    (setq scim-cursor-color '("red" "blue" "limegreen"))
    ;; C-j で半角英数モードをトグルする
    (scim-define-common-key ?\C-j t)
    ;; SCIM-Anthy 使用時に、選択領域を再変換できるようにする
    (scim-define-common-key 'S-henkan nil)
    (global-set-key [S-henkan] 'scim-anthy-reconvert-region)
    ;; SCIM がオフのままローマ字入力してしまった時に、プリエディットに入れ直す
    (global-set-key [C-henkan] 'scim-transfer-romaji-into-preedit))

  (defun setup-mozc ()
    (interactive)
    (require 'mozc) ; or (load-file "path-to-mozc.el")
    (set-language-environment "Japanese")
    (setq default-input-method "japanese-mozc"))

  (progn
    (setup-scim)
    (add-hook 'after-init-hook 'scim-mode-on))

  ;; (set-face-font 'variable-pitch "Droid Sans Mono-11")
  ;; (set-face-font 'default "Droid Sans Mono-11")
  ;; (set-default-font "Bitstream Vera Sans Mono-11")
  )

(defun font-existsp (font)
  "Check that a font exists: http://www.emacswiki.org/emacs/SetFonts#toc8"
  (and (window-system)
       (fboundp 'x-list-fonts)
       (x-list-fonts font)))

(defun set-ubuntu-fonts ()
  (interactive)
  (if (eq window-system 'x)
      ;; settings that never quite worked
      ;; (progn
      ;; ;;set one
      ;; (set-default-font "Droid Sans Mono-12")
      ;; (set-default-font "Bitstream Vera Sans Mono-11")
      ;; (set-fontset-font (frame-parameter nil 'font)
      ;; 'japanese-jisx0208
      ;; '("Sans" . "unicode-bmp"))

      ;; ;; set two
      ;; (set-default-font "Inconsolata-12")
      ;; (set-face-font 'variable-pitch "Inconsolata-12")
      ;; (set-fontset-font (frame-parameter nil 'font)
      ;; 'japanese-jisx0208
      ;; '("Takaoゴシック" . "unicode-bmp")
      ;; )
      ;; )



      (progn
        (set-face-attribute 'default nil
                            :family (if (font-existsp "Droid Sans Mono Slashed")
                                        "Droid Sans Mono Slashed"
                                      "Droid Sans Mono")
                            :height 110)
        (set-fontset-font "fontset-default"
                          'japanese-jisx0208
                          '("Droid Sans Fallback" . "iso10646-1"))
        (set-fontset-font "fontset-default"
                          'katakana-jisx0201
                          '("Droid Sans Fallback" . "iso10646-1"))
        (setq face-font-rescale-alist
              '((".*Droid_Sans_Mono.*" . 1.0)
                (".*Droid_Sans_Mono-medium.*" . 1.0)
                (".*Droid_Sans_Fallback.*" . 1.2)
                (".*Droid_Sans_Fallback-medium.*" . 1.2)))
        )))

(if (eq window-system 'x)
    (add-hook 'after-init-hook (lambda () (set-ubuntu-fonts))))

;; recentf stuff
(require 'recentf)
(setq recentf-keep '(file-remote-p file-readable-p))
(setq recentf-auto-cleanup 'never)
(setq recentf-max-saved-items 10000)
(setq recentf-max-menu-items 10000)
(require 'recentf-ext)
(recentf-mode 1)
;;(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(message "recentf stuff")

(transient-mark-mode 1)
(setq gc-cons-threshold 4000)
(setq gc-cons-percentage 0.05)
(setq use-dialog-box nil)
(defalias 'message-box 'message)
(setq echo-keystrokes 0.1)
(setq history-length 1000)


(require 'dired+)
(define-key dired-mode-map "W" 'diredp-mark-region-files)

(setenv (concat "/usr/local/libexec/git-core" ";" (getenv "GIT_EXEC_PATH")))

(require 'magit)
(require 'magit-svn)
(defalias 'mg 'magit-status)
(setq magit-revert-item-confirm t)

(defun magit-commit-then-push ()
  (interactive)
  (progn
    (magit-log-edit-commit)
    (magit-push)))

(define-key magit-log-edit-mode-map (kbd "C-x C-s") 'magit-commit-then-push)

(require 'gist)
(setq gist-use-curl t)

;; (setq popwin:special-display-config nil)

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-height 0.5)
(setq special-display-function
      'popwin:special-display-popup-window)
(push '(dired-mode :position top) popwin:special-display-config)
(push '("*Compile-Log*" :height 10) popwin:special-display-config)
(push '("*Shell Command Output*" :height 30) popwin:special-display-config)
;; (push '("*compilation*" :height 10) popwin:special-display-config)
(push '("*Warnings*" :height 10 :noselect t) popwin:special-display-config)
(push '("*mu4e-loading*" :height 10 :noselect t) popwin:special-display-config)
(push '("*Help*" :height 10 :noselect nil) popwin:special-display-config)
(push '(ess-help-mode :height 20) popwin:special-display-config)
(push '("*translated*" :height 10 :noselect t) popwin:special-display-config)
(push '("*Process List*" :height 10) popwin:special-display-config)
(push '("*Locate*" :height 10 :noselect t) popwin:special-display-config)
(push '("*Moccur*" :height 20 :position bottom) popwin:special-display-config)
(push '("*wget.*" :regexp t :height 10 :position bottom) popwin:special-display-config)
(push '(" *auto-async-byte-compile*" :height 10) popwin:special-display-config)
(push '("\*grep\*.*" :regexp t :height 20) popwin:special-display-config)
(push '("function\-in\-.*" :regexp t) popwin:special-display-config)
(push '("*magit-diff*") popwin:special-display-config)
(push '("*wclock*" :height 10 :noselect t :position bottom) popwin:special-display-config)
(push '(Man-mode :stick t :height 20) popwin:special-display-config)


(defun popwin:define-advice (func buffer)
  (eval `(defadvice ,func (around popwin activate)
           (save-window-excursion ad-do-it)
           (popwin:popup-buffer ,buffer)
           (goto-char (point-min)))))

(popwin:define-advice 'vc-diff "*vc-diff*")
(popwin:define-advice 'magit-diff-working-tree "*magit-diff*")
(popwin:define-advice 'describe-key "*Help*")
(popwin:define-advice 'describe-function "*Help*")
(popwin:define-advice 'describe-mode "*Help*")
;; (popwin:define-advice 'auto-async-byte-compile "*auto-async-byte-compile*")
;; (popwin:define-advice 'text-translator-all "*translated*")

(setq warning-suppress-types '(undo discard-info))

(defvar prev-buffer-input-method nil "save previously set inputmethod")
(make-variable-buffer-local 'prev-buffer-input-method)

(require 'vim)

(defun vim-mode-toggle-with-input ()
  (interactive)
  (if vim-mode
      (progn
        (activate-input-method (if (boundp 'prev-buffer-input-method)
                                   prev-buffer-input-method
                                 current-input-method))
        (vim-mode 0))
    (progn
      (setq prev-buffer-input-method current-input-method)
      (inactivate-input-method)
      (vim-mode t))))

(global-set-key (kbd "C-c v") 'vim-mode-toggle-with-input)

(message "vim mode")

(defun input-mode-toggle-enter ()
  (interactive)
  (progn
    (activate-input-method (if (boundp 'prev-buffer-input-method)
                               prev-buffer-input-method
                             current-input-method))))

(add-hook 'vim:insert-mode-on-hook 'input-mode-toggle-enter)

(vim:omap (kbd "SPC") 'vim:scroll-page-down)
(vim:omap (kbd "S-SPC") 'vim:scroll-page-up)
(vim:nmap (kbd "C-z") 'anything)
(vim:nmap (kbd "C-S-z") 'vim:activate-emacs-mode)
(vim:map (kbd "C-S-z") 'vim:activate-normal-mode :keymap vim:emacs-keymap)

(push '(magit-mode . insert) vim:initial-modes)
(push '(magit-log-edit-mode . insert) vim:initial-modes)
(push '(w3m-mode . insert) vim:initial-modes)
(push '(eshell-mode . insert) vim:initial-modes)
(push '(debugger-mode . insert) vim:initial-modes)

;; (vim:omap (kbd "SPC") 'vim:scroll-page-down)
;; (vim:ovim:insert-mode-on-hook
;; upon entering vim mode

;; (defun input-mode-toggle-exit ()
;; (interactive)
;; (progn
;; (setq prev-buffer-input-method current-input-method)
;; (inactivate-input-method)))

;; (remove-hook 'vim:insert-mode-off-hook 'input-mode-toggle-exit)

;; ----- sdicが呼ばれたときの設定
(autoload 'sdic-describe-word "sdic" "search word" t nil)
;;(setq sdicf-array-command "/usr/local/bin/sary")
;; (setq sdic-eiwa-dictionary-list
;; '((sdicf-client "/usr/local/share/dict/eijirou.sdic" (strategy array))))
;; (setq sdic-waei-dictionary-list
;; '((sdicf-client "/usr/local/share/dict/gene.sdic" (strategy array))))

(eval-after-load "sdic"
  '(progn
     ;; saryのコマンドをセットする
     (setq sdicf-array-command "/usr/local/bin/sary")
     ;; sdicファイルのある位置を設定し、arrayコマンドを使用するよう設定(現在のところ英和のみ)
;;; (setq sdic-eiwa-dictionary-list
;;; '((sdicf-client "/usr/local/share/dict/eijirou.sdic" (strategy array))))
     ;; saryを直接使用できるように sdicf.el 内に定義されているarrayコマンド用関数を強制的に置換
     (fset 'sdicf-array-init 'sdicf-common-init)
     (fset 'sdicf-array-quit 'sdicf-common-quit)
     (fset 'sdicf-array-search
           (lambda (sdic pattern &optional case regexp)
             (sdicf-array-init sdic)
             (if regexp
                 (signal 'sdicf-invalid-method '(regexp))
               (save-excursion
                 (set-buffer (sdicf-get-buffer sdic))
                 (delete-region (point-min) (point-max))
                 (apply 'sdicf-call-process
                        sdicf-array-command
                        (sdicf-get-coding-system sdic)
                        nil t nil
                        (if case
                            (list "-i" pattern (sdicf-get-filename sdic))
                          (list pattern (sdicf-get-filename sdic))))
                 (goto-char (point-min))
                 (let (entries)
                   (while (not (eobp)) (sdicf-search-internal))
                   (nreverse entries))))))
     ;; おまけ--辞書バッファ内で移動した時、常にバッファの一行目になるようにする
     (defadvice sdic-forward-item (after sdic-forward-item-always-top activate)
       (recenter 0))
     (defadvice sdic-backward-item (after sdic-backward-item-always-top activate)
       (recenter 0))))

(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
;; (global-set-key "\C-cd" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cD" 'sdic-describe-word-at-point)


;; highlight current line
(require 'highline)
;; (global-hl-line-mode t)
;; To customize the background color
(set-face-background 'hl-line "#222") ;; Emacs 22 Only

(require 'hl-line+)
(toggle-hl-line-when-idle nil)

(require 'hl-spotlight)
;; (global-hl-spotlight-mode t)
(setq hl-spotlight-height 0)

(require 'highlight-current-line)
;; (highlight-current-line-on t)
(setq highlight-current-line-globally nil)
(set-face-background 'highlight-current-line-face "#222")
(add-hook 'highlight-current-line-hook (lambda () (redisplay t)))

(require 'col-highlight)
;; to enable at all times
;; (column-highlight-mode t)
(toggle-highlight-column-when-idle t)
(col-highlight-set-interval 2000)
(set-face-background 'col-highlight "#222")

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)


;; (add-hook 'iswitchb-minibuffer-setup-hook (lambda () (toggle-iswitchb-input)))
;; (add-hook 'minibuffer-setup-hook (lambda () (activate-input-method nil)))

(defun iswitchb-toggle-input-method ()
  (interactive)
  (enter-minibuf-with-toggle-input-method 'iswitchb-buffer))

(global-set-key "\C-xb" 'iswitchb-toggle-input-method)

(setq iswitchb-use-virtual-buffers t)
(require 'filecache)
(require 'iswitchb-fc)

(defun file-cache-iswitchb-file ()
  "Using iswitchb, interactively open file from file cache'.
First select a file, matched using iswitchb against the contents
in `file-cache-alist'. If the file exist in more than one
directory, select directory. Lastly the file is opened."
  (interactive)
  (let* ((file (file-cache-iswitchb-read "File: "
                                         (mapcar
                                          (lambda (x)
                                            (car x))
                                          file-cache-alist)))
         (record (assoc file file-cache-alist)))
    (find-file
     (concat
      (if (= (length record) 2)
          (car (cdr record))
        (file-cache-iswitchb-read
         (format "Find %s in dir: " file) (cdr record))) file))))

(defun file-cache-iswitchb-read (prompt choices)
  (let ((iswitchb-make-buflist-hook
         (lambda ()
           (setq iswitchb-temp-buflist choices))))
    (iswitchb-read-buffer prompt)))

(global-set-key "\C-cf" 'file-cache-iswitchb-file)


(add-hook 'iswitchb-define-mode-map-hook
          (lambda ()
            (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
            (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

(file-cache-add-directory "~/projects/ghub")

(defun file-cache-add-this-file ()
  (and buffer-file-name
       (file-exists-p buffer-file-name)
       (file-cache-add-file buffer-file-name)))
(add-hook 'kill-buffer-hook 'file-cache-add-this-file)

(message "cache files")

;; File Name Cache
;; http://www.emacswiki.org/emacs/FileNameCache
(eval-after-load
    "filecache"
  '(progn
     (message "Loading file cache...")
     (file-cache-add-directory-list load-path)))


;; utf-8 all the way
(setq current-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)


(if (or (< emacs-major-version 23) (featurep 'carbon-emacs-package))
    (utf-translate-cjk-mode 1)
  (setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
  (set-language-environment 'Japanese)
  (set-keyboard-coding-system 'utf-8-mac) ; For old Carbon emacs on OS X only
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (set-language-environment 'Japanese))

(when
    (featurep 'carbon-emacs-package)
  (setq default-input-method "MacOSX"))

(require 'cursor-chg)

(defun recompile-emacsd ()
  (interactive)
  (byte-recompile-directory "~/.emacs.d" 0 t))

(defalias 'brd 'recompile-emacsd)

;; Carbon Emacs keep Spotlight from triggering
(when
    (featurep 'carbon-emacs-package)
  (mac-add-ignore-shortcut '(control)))

;; Remember the place
(require 'saveplace)
(setq-default save-place t)
(savehist-mode t)
(setq server-visit-hook (quote (save-place-find-file-hook)))

;; toggle-max-window
(when (featurep 'carbon-emacs-package)
  (defun toggle-max-window ()
    (interactive)
    (if (frame-parameter nil 'fullscreen)
        (set-frame-parameter nil 'fullscreen nil)
      (set-frame-parameter nil 'fullscreen 'fullboth)))

  (global-set-key "\M-\r" 'toggle-max-window)
  (add-hook 'after-init-hook (lambda () (set-frame-parameter nil 'fullscreen 'fullboth)))
  (add-hook 'after-make-frame-functions (lambda (frame) (set-frame-parameter frame 'fullscreen 'fullboth))))

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

;; I always compile my .emacs, saves me about two seconds
;; startuptime. But that only helps if the .emacs.elc is newer
;; than the .emacs. So compile .emacs if it's not.
(when (and user-init-file
           (equal (file-name-extension user-init-file) "elc"))
  (let* ((source (file-name-sans-extension user-init-file))
         (alt (concat source ".el")))
    (setq source (cond ((file-exists-p alt) alt)
                       ((file-exists-p source) source)
                       (t nil)))
    (when source
      (when (file-newer-than-file-p source user-init-file)
        (byte-compile-file source)
        (load-file source)
        (eval-buffer nil nil)
        (delete-other-windows) ))))

(message "pre image mode")

(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)

(add-hook 'iimage-mode-hook (lambda () (add-to-list 'iimage-mode-image-regex-alist
                                                    (cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex
                                                                  "\\)\\]") 1))))
(setq display-time-world-list '(("PST8PDT" "Bay Area")
                                ("EST5EDT" "New York")
                                ("GMT0BST" "London")
                                ("CET-1CDT" "Paris")
                                ("IST-5:30" "Bangalore")
                                ("JST-9" "Tokyo")))

(require 'calendar)
(require 'japanese-holidays)
(setq calendar-holidays
      (append japanese-holidays local-holidays other-holidays))
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
(setq mark-holidays-in-calendar t)

;; 日曜日を赤字にする場合、以下の設定を追加します。
(setq calendar-weekend-marker 'diary)
(add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
(add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)


;;for carbon emacs
(unless (fboundp 'calendar-extract-day)
  (defalias 'calendar-extract-day (symbol-function 'extract-calendar-day))
  (defalias 'calendar-extract-month (symbol-function 'extract-calendar-month))
  (defalias 'calendar-extract-year (symbol-function 'extract-calendar-year)))


(setq calendar-month-name-array
      ["January" "February" "March" "April" "May" "June"
       "July" "August" "September" "October" "November" "December"])

(setq calendar-day-name-array
      ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"])

;; 週の先頭の曜日
(setq calendar-week-start-day 0) ; 日曜日は0, 月曜日は1

(message "calendar")

(defun start-calfw ()
  (interactive)
  (require 'calfw) ; 初回一度だけ
  ;; (cfw:open-calendar-buffer)
  ;; (cfw:contents-debug-data)
  (require 'calfw-ical)
  (cfw:install-ical-schedules)
  (require 'calfw-org)
  (cfw:install-org-schedules)
  (cfw:open-org-calendar))


;; org-modeを利用するための設定
(require 'org-install)
(require 'org-clock)
(require 'org-timer)
(require 'org-habit)

(require 'google-weather)
(require 'org-google-weather)


(require 'todochiku)

(setq org-export-with-sub-superscripts nil)
(setq org-startup-indented t)

;;copied straight from org, don't redisplay frames after push
(defun org-mobile-push-unobtrusive ()
  (interactive)
  (let ((a-buffer (get-buffer org-agenda-buffer-name)))
    (let ((org-agenda-buffer-name "*SUMO*")
          (org-agenda-filter org-agenda-filter)
          (org-agenda-redo-command org-agenda-redo-command))
      (save-window-excursion
        (org-mobile-check-setup)
        (org-mobile-prepare-file-lists)
        (run-hooks 'org-mobile-pre-push-hook)
        (message "Creating agendas...")
        (let ((inhibit-redisplay t)) (org-mobile-create-sumo-agenda))
        (message "Creating agendas...done")
        (org-save-all-org-buffers) ; to save any IDs created by this process
        (message "Copying files...")
        (org-mobile-copy-agenda-files)
        (message "Writing index file...")
        (org-mobile-create-index-file)
        (message "Writing checksums...")
        (org-mobile-write-checksums)
        (run-hooks 'org-mobile-post-push-hook)))
    (message "Files for mobile viewer staged")))

(setq todochiku-icons-directory "~/.emacs.d/todochiku-icons")
(setq org-timer-default-timer 25)
(setq org-clock-string-limit 35)

(add-hook 'org-clock-in-hook '(lambda ()
                                (if (not org-timer-current-timer)
                                    (org-timer-set-timer '(25)))))

(add-hook 'org-clock-out-hook '(lambda ()
                                 (org-timer-cancel-timer)
                                 (setq org-mode-line-string nil)))

(add-hook 'org-timer-done-hook '(lambda()
                                  (todochiku-message "Pomodoro" "completed" (todochiku-icon 'alarm))))

(add-hook 'org-capture-after-finalize-hook '(lambda() (org-agenda-redo)))

(when (eq window-system 'ns)
  (defun org-toggle-iimage-in-org ()
    "display images in your org file"
    (interactive)
    (if (face-underline-p 'org-link)
        (set-face-underline-p 'org-link nil)
      (set-face-underline-p 'org-link t))
    (iimage-mode))

  (add-hook 'org-mode-hook 'turn-on-iimage-mode)
  (setq org-google-weather-icon-directory "~/Dropbox/status"))

(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 70)
(setq org-enforce-todo-dependencies t)

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states) ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(remove-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(defun org-cmp-title (a b)
  "Compare the titles of string A and B"
  (cond ((string-lessp a b) -1)
        ((string-lessp b a) +1)
        (t nil)))

(setq org-agenda-cmp-user-defined 'org-cmp-title)

;; for when timestamps get garbled by locale
(defun org-fix-timestamp ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward org-ts-regexp-both nil)
      (org-timestamp-change 0))))

(setq org-google-weather-format "[ %i %c, %L [%l,%h] %s ]")

(defun org-clock-in-out-later (start end)
  "…"
  (interactive "nEnter start:
nEnd:")
  (message "Name is: %d, Age is: %d" start end)
  (org-clock-in nil start)
  (org-clock-out nil end))


;; "String to return to describe the weather.
;; Valid %-sequences are:
;; - %i the icon
;; - %c means the weather condition
;; - %L the supplied location
;; - %C the city the weather is for
;; - %l the lower temperature
;; - %h the higher temperature
;; - %s the temperature unit symbol"

(setq org-agenda-sorting-strategy
      '((agenda habit-up time-up alpha-up tag-up user-defined-up priority-down)
        (todo user-defined-up todo-state-up priority-up effort-down)
        (tags user-defined-up)
        (search category-keep)))

(setq org-timer-default-timer 25)

(add-hook 'org-clock-in-hook '(lambda ()
                                (if (not org-timer-current-timer)
                                    (org-timer-set-timer '(16)))))

(setq org-agenda-custom-commands
      '(("W" tags "work")
        ("w" tags-todo "work")
        ("j" todo "WAIT"
         (tags-todo "work"))
        ("J" todo-tree "WAIT")
        ("h" agenda ""
         ((org-agenda-show-all-dates nil)))
        ("o" "Agenda and Office-related tasks"
         ((agenda)
          (tags-todo "work")))
        ("U" tags "work"
         ((org-show-following-heading nil)
          (org-show-hierarchy-above nil)))
        ("f" "flagged" tags ""
         ((org-agenda-files
           '("~/org/flagged.org"))))
        ("z" "Agenda and Office-related tasks"
         ((agenda)
          (org-agenda-files
           '("~/org/flagged.org"))))
        ("c" agenda "work"
         ((org-agenda-ndays 1)
          (org-scheduled-past-days 900)
          (org-deadline-warning-days 0)
          (org-agenda-filter-preset
           '("+work"))))))

(setq org-icalendar-use-scheduled '(todo-start event-if-todo))

(setq system-time-locale "C")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook 'turn-on-font-lock) ; Org buffers only
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map "C" 'cfw:open-org-calendar)
            (define-key org-mode-map (kbd "C-'") 'smex-with-toggle)))
;;(add-hook 'org-mode-hook 'smart-tab-mode-off)

(setq org-startup-truncated nil)
(setq org-return-follows-link t)

(setq org-agenda-include-diary t)

;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-agenda-skip-unavailable-files t)
(setq org-log-done-with-time t)

(defun org-mobile-pullpush ()
  (interactive)
  (save-excursion
    (progn
      (org-mobile-pull)
      (org-mobile-push-unobtrusive)
      (todochiku-message "org" "all files pushed" (todochiku-icon 'terminail)))))

(defun org-sync-mobile-after-save (&optional force)
  (interactive)
  (when (and (eq major-mode 'org-mode)
             (member buffer-file-name org-agenda-files))
    (save-excursion
      (org-mobile-pullpush))))

(defadvice org-save-all-org-buffers (after sync-all-mobile-org-after-saving-in-agenda last)
  (org-sync-mobile-after-save))

(defadvice org-agenda-exit (after sync-all-mobile-org-after-saving-in-agenda-exit activate)
  (org-sync-mobile-after-save))

;; (ad-deactivate 'org-save-all-org-buffers)
;; (ad-activate 'org-save-all-org-buffers)
;; (ad-deactivate 'org-agenda-exit)
;; (ad-activate 'org-agenda-exit)

;; (require 'deferred)
;; (run-at-time t 3600 (lambda () (deferred:call(org-mobile-pullpush))))

(setq org-default-notes-file (concat org-directory "memo.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))


(setq org-capture-templates
      '(("i" "Inbox" entry (file+headline "~/org/todo.org" "Inbox") "** TODO %? \n %i :inbox: %a \n SCHEDULED: %T \n %U")
        ("r" "Research" entry (file+headline "~/org/diss.org" "Research") "** TODO %? :research: \n %a")
        ("t" "Writing" entry (file+headline "~/org/write.org" "Writing") "** TODO %? :write: \n %a")
        ("w" "Work" entry (file+headline "~/org/work.org" "Work") "** TODO %? :work: \n SCHEDULED: %t \n %a")
        ("l" "RIL" entry (file+headline "~/org/ril.org" "Ril") "** TODO %? :ril: \n %a")
        ("d" "Dev" entry (file+headline "~/org/dev.org" "Dev") "** TODO %? :dev: %i %a")
        ("h" "HJ" entry (file+headline "~/org/hj.org" "HJ") "* TODO %? :hj: \n \n Entered on %U\n %i\n %a")
        ("a" "Activity" entry (file+headline "~/org/activity.org" "Activity") "** TODO %? :activity: \n %a")
        ("p" "Personal" entry (file+headline "~/org/personal.org" "Personal") "* TODO %? :personal: \n SCHEDULED: %t \n \nEntered on %U\n %i\n %a")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
        ("DEFERRED" . shadow)
        ("CANCELED" . (:foreground "blue" :weight bold))))

(defun org-read-date-and-adjust-timezone ()
  (date-to-time (format "%s %s" (org-read-date t) (car (cdr (current-time-zone))))))

(defun org-clock-in-and-out ()
  (interactive)
  (progn
    (org-clock-in nil (org-read-date-and-adjust-timezone))
    (org-clock-out nil (org-read-date-and-adjust-timezone))))

(define-key org-mode-map (kbd "\C-c i") 'org-clock-in-and-out)

;;(setq org-refile-targets (quote ((org-agenda-files :regexp . "*"))))
(setq org-refile-targets (quote ((org-agenda-files :level . 1))))
(setq org-agenda-files (list "~/org"))

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(setq org-timer-timer-is-countdown t)
(message "org-mode stuff")



;; ここまで

;; 思いついたコードやメモコードを書いて保存できるようにするための設定
;; (auto-install-from-emacswiki "open-junk-file.el")
(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%Y%m%d_%H%M%s_junk.utf")
(global-set-key "\C-c\C-j" 'open-junk-file)
;; ここまで


;; iPhone stuff
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

(ffap-bindings)
(autoload 'ffap-href-enable "ffap-href" nil t)

;; 探すパスは ffap-c-path で設定する
;; (setq ffap-c-path
;; '("/usr/include" "/usr/local/include"))
;; 新規ファイルの場合には確認する
(setq ffap-newfile-prompt t)
;; ffap-kpathsea-expand-path で展開するパスの深さ
(setq ffap-kpathsea-depth 5)

(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$" (".hh" ".h"))
        ("\\.hh$" (".cc" ".C"))

        ("\\.c$" (".h"))
        ("\\.h$" (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.C$" (".H" ".hh" ".h"))
        ("\\.H$" (".C" ".CC"))

        ("\\.CC$" (".HH" ".H" ".hh" ".h"))
        ("\\.HH$" (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))

        ("\\.hpp$" (".cpp" ".c"))))
(add-hook 'objc-mode-hook
          (lambda ()
            (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)))

;; load-path を通す
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp/")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; ロード
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(require 'ac-company)
;; 対象の全てで補完を有効にする
(global-auto-complete-mode t)
(ac-company-define-source ac-source-company-xcode company-xcode)
;; objc-mode で補完候補を設定
(setq ac-modes (append ac-modes '(objc-mode)))

(require 'auto-complete-clang)
(setq clang-completion-suppress-error 't)
(setq clang-completion-flags '("-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" "/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator4.3.sdk" "-I." "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200"))

;; ac-company で company-xcode を有効にする
(ac-company-define-source ac-source-company-xcode company-xcode)
;; objc-mode で補完候補を設定
(setq ac-modes (append ac-modes '(objc-mode)))
;; hook
(add-hook 'objc-mode-hook
          (lambda ()
            (setq tab-width 2)
            (define-key objc-mode-map (kbd "\t") 'ac-complete)
            ;; XCode を利用した補完を有効にする
            (push 'ac-source-clang-complete ac-sources)
            (push 'ac-source-company-xcode ac-sources)))

;; 補完ウィンドウ内でのキー定義
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)
(define-key ac-completing-map (kbd "M-/") 'ac-stop)
;; 補完が自動で起動するのを停止
(setq ac-auto-start nil)
;; 起動キーの設定
(ac-set-trigger-key "TAB")
;; 候補の最大件数 デフォルトは 10件
(setq ac-candidate-max 20)

(require 'auto-complete-latex)
(setq ac-l-dict-directory "~/.emacs.d/ac-l-dict/")
(setq ac-modes (append ac-modes '(LaTeX-mode latex-mode YaTeX-mode)))
(add-hook 'LaTeX-mode-hook 'ac-l-setup)
(add-hook 'latex-mode-hook 'ac-l-setup)
(add-hook 'YaTeX-mode-hook 'ac-l-setup)

;; etags-table の機能を有効にする
(require 'etags-table)
(add-to-list 'etags-table-alist
             '("\\.[mh]$" "~/tags/objc.TAGS"))
;; auto-complete に etags の内容を認識させるための変数
;; 以下の例だと3文字以上打たないと補完候補にならないように設定してあります。requires の次の数字で指定します
(defvar ac-source-etags
  '((candidates . (lambda ()
                    (all-completions ac-target (tags-completion-table))))
    (candidate-face . ac-candidate-face)
    (selection-face . ac-selection-face)
    (requires . 3))
  "etags をソースにする")
;; objc で etags からの補完を可能にする
(add-hook 'objc-mode-hook
          (lambda ()
            (push 'ac-source-etags ac-sources)))


(add-hook 'c-mode-common-hook
          '(lambda()
             (make-variable-buffer-local 'skeleton-pair)
             (make-variable-buffer-local 'skeleton-pair-on-word)
             (setq skeleton-pair-on-word t)
             (setq skeleton-pair t)
             (make-variable-buffer-local 'skeleton-pair-alist)
             (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)))

(setq cua-enable-cua-keys nil)
(cua-mode t)

(require 'find-file)
(add-to-list 'ff-other-file-alist '("\\.mm?$" (".h")))
(add-to-list 'ff-other-file-alist '("\\.h$" (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm")))

(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$" (".hh" ".h"))
        ("\\.hh$" (".cc" ".C"))

        ("\\.c$" (".h"))
        ("\\.h$" (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.C$" (".H" ".hh" ".h"))
        ("\\.H$" (".C" ".CC"))

        ("\\.CC$" (".HH" ".H" ".hh" ".h"))
        ("\\.HH$" (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))

        ("\\.hpp$" (".cpp" ".c"))))

(require 'flymake)
(defvar xcode:gccver "4.2.1")
(defvar xcode:sdkver "4.3")
(defvar xcode:sdkpath "/Developer/Platforms/iPhoneSimulator.platform/Developer")
(defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))
(defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/gcc-" xcode:gccver))
(defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" xcode:sdk))
(defvar flymake-last-position nil)
(defvar flymake-objc-compile-options '("-I."))

;; this really doesn't work, there's just no way
(defun flymake-objc-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list flymake-objc-compiler (append flymake-objc-compile-default-options flymake-objc-compile-options (list local-file)))))

;; (add-hook 'objc-mode-hook
;; (lambda ()
;; (push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
;; (push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)
;; (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
;; (flymake-mode t))))

;; (defun flymake-display-err-minibuffer ()
;; "現在行の error や warinig minibuffer に表示する"
;; (interactive)
;; (let* ((line-no (flymake-current-line-no))
;; (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;; (count (length line-err-info-list)))
;; (while (> count 0)
;; (when line-err-info-list
;; (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
;; (full-file (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;; (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;; (line (flymake-ler-line (nth (1- count) line-err-info-list))))
;; (message "[%s] %s" line text)))
;; (setq count (1- count)))))

;; (defadvice flymake-goto-next-error (after display-message activate compile)
;; "次のエラーへ進む"
;; (flymake-display-err-minibuffer))

;; (defadvice flymake-goto-prev-error (after display-message activate compile)
;; "前のエラーへ戻る"
;; (flymake-display-err-minibuffer))

;; (defadvice flymake-mode (before post-command-stuff activate compile)
;; "エラー行にカーソルが当ったら自動的にエラーが minibuffer に表示されるように
;; post command hook に機能追加"
;; (set (make-local-variable 'post-command-hook)
;; (add-hook 'post-command-hook 'flymake-display-err-minibuffer)))

(defvar *xcode-project-root* nil)

(defun xcode--project-root ()
  (or *xcode-project-root*
      (setq *xcode-project-root* (xcode--project-lookup))))

(defun xcode--project-lookup (&optional current-directory)
  (when (null current-directory) (setq current-directory default-directory))
  (cond ((xcode--project-for-directory (directory-files current-directory)) (expand-file-name current-directory))
        ((equal (expand-file-name current-directory) "/") nil)
        (t (xcode--project-lookup (concat (file-name-as-directory current-directory) "..")))))

(defun xcode--project-for-directory (files)
  (let ((project-file nil))
    (dolist (file files project-file)
      (if (> (length file) 10)
          (when (string-equal (substring file -10) ".xcodeproj") (setq project-file file))))))

(defun xcode--project-command (options)
  (concat "cd " (xcode--project-root) "; " options))

(defun xcode/build-compile ()
  (interactive)
  (compile (xcode--project-command (xcode--build-command))))

(defun xcode/build-list-sdks ()
  (interactive)
  (message (shell-command-to-string (xcode--project-command "xcodebuild -showsdks"))))

(defun xcode--build-command (&optional target configuration sdk)
  (let ((build-command "xcodebuild"))
    (if (not target)
        (setq build-command (concat build-command " "))
      (setq build-command (concat build-command " -target " target)))
    (if (not configuration)
        (setq build-command (concat build-command " "))
      (setq build-command (concat build-command " -configuration " configuration)))
    (when sdk (setq build-command (concat build-command " -sdk " sdk)))
    build-command))

;; yeah, I should set a variable somewhere
(defun xcode/build ()
  (interactive)
  (compile (xcode--project-command (xcode--build-command nil nil "iphonesimulator4.3"))))

(setq compilation-scroll-output t)

;; helps catch xcodebuild bug for jumpy jumpy

;; FIXME: this probably messes up my compile
;; (add-to-list 'compilation-error-regexp-alist '("\\(.*?\\):\\([0-9]+\\): error.*$" 1 2))



;; 自動的な表示に不都合がある場合は以下を設定してください
;; post-command-hook は anything.el の動作に影響する場合があります
(define-key global-map (kbd "C-c d") 'flymake-display-err-minibuffer)

(set-face-background 'flymake-errline "red")
(set-face-background 'flymake-warnline "yellow")

(defun xcode:buildandrun ()
  (interactive)
  (do-applescript
   (format
    (concat
     "tell application \"Xcode\" to activate \r"
     "tell application \"System Events\" \r"
     " tell process \"Xcode\" \r"
     " key code 36 using {command down} \r"
     " end tell \r"
     "end tell \r" ))))

(add-hook 'objc-mode-hook
          (lambda ()
            (define-key objc-mode-map (kbd "C-c C-r") 'xcode:buildandrun)))

(when (or (eq window-system 'ns) (featurep 'carbon-emacs-package))


  (require 'xcode-document-viewer)
  ;; (setq xcdoc:document-path "/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiOS4_3.iOSLibrary.docset")
  (setq xcdoc:document-path "~/Library/Developer/Shared/Documentation/DocSets/com.apple.adc.documentation.AppleiOS5_1.iOSLibrary.docset")
  (setq xcdoc:open-w3m-other-buffer nil)

  (require 'anything-apple-docset)
  (setq anything-apple-docset-path xcdoc:document-path)
  (anything-apple-docset-init)

  (require 'apple-reference-browser)
  (setq arb:docset-path xcdoc:document-path)
  (setq arb:open-w3m-other-buffer nil)
  (define-key global-map "\C-cd" 'arb:search)


  ;; hook の設定
  (add-hook 'objc-mode-hook
            (lambda ()
              (define-key objc-mode-map (kbd "C-c w") 'arb:search)
              (define-key objc-mode-map (kbd "C-c h") 'xcdoc:ask-search))))

;; end of iphone-related settings
(message "xcode/iphone stuff")

;; Common copying and pasting functions
(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (save-excursion
    (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point)))
          (end (progn (forward-word arg) (point))))
      (copy-region-as-kill beg end))))

(global-set-key (kbd "C-c w") (quote copy-word))

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line "
  (interactive "P")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (copy-region-as-kill beg end)))

(global-set-key (kbd "C-c k") (quote copy-line))

(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (save-excursion
    (let ((beg (progn (backward-paragraph 1) (point)))
          (end (progn (forward-paragraph arg) (point))))
      (copy-region-as-kill beg end))))

(global-set-key (kbd "C-c p") (quote copy-paragraph))

(defun copy-string (&optional arg)
  "Copy a sequence of string into kill-ring"
  (interactive)
  (setq onPoint (point))
  (let ((beg (progn (re-search-backward "[\t ]" (line-beginning-position) 3 1)
                    (if (looking-at "[\t ]") (+ (point) 1) (point))))
        (end (progn (goto-char onPoint) (re-search-forward "[\t ]" (line-end-position) 3 1)
                    (if (looking-back "[\t ]") (- (point) 1) (point) ) )))
    (copy-region-as-kill beg end))
  (goto-char onPoint))


(global-set-key (kbd "C-c r") (quote copy-string))
(global-set-key (kbd "C-c s") 'ispell-word)
(global-set-key (kbd "M-s") 'ispell)

(require 'basic-edit-toolkit)

(require 'w3m-load)
(require 'w3m-extension)
(autoload 'w3m-filter "w3m-filter")
(setq w3m-use-filter t)
(setq w3m-key-binding 'lynx)
(w3m-link-numbering-mode 1)
;;(add-hook 'w3m-mode-hook 'w3m-link-numbering-mode)
(setq w3m-use-cookies t)

(setq w3m-session-load-last-sessions t)
(setq w3m-session-load-crashed-sessions t)

(autoload 'wget "wget" "wget interface for Emacs." t)
(autoload 'wget-web-page "wget" "wget interface to download whole web page." t)
(setq wget-download-directory "~/Downloads")
(setq wget-max-window-height 10)

(require 'w3m-wget)

(defun w3m-wget-images (&optional buffer-position)
  (interactive)
  (let ((pos (or buffer-position (point))))
    (progn
      (w3m-next-image)
      (when (< pos (point))
        (let ((link (w3m-anchor)))
          (if link
              (progn
                (wget (w3m-anchor))
                (w3m-wget-images pos))))))))

(define-key w3m-mode-map (kbd "w") 'w3m-wget)
(define-key w3m-mode-map (kbd "W") 'w3m-wget-images)

(add-hook 'w3m-display-hook
          (lambda (url)
            (rename-buffer
             (format "*w3m: %s*" (or w3m-current-title
                                     w3m-current-url)) t)))

(setq w3m-verbose t)
(setq w3m-message-silent nil)
(setq url-show-status nil) ;;don't need to know how you're doing url-http

(autoload 'w3m-goto-url "w3m")
(defalias 'www 'w3m)
(defalias 'w3m-safe-view-this-url 'w3m-view-this-url)

(defun wws ()
  "Use Google (English) to search for WHAT."
  (interactive)
  (w3m-search-advance "http://www.google.com/search?hl=en&safe=off&ie=UTF-8&oe=UTF-8&q=" "Google Web EN" 'utf-8))

(defun wwo (&optional url)
  (interactive)
  (let ((url-at-point (thing-at-point 'url)))
    (message (format "browse url: %s" url-at-point))
    (if (and (not (eq url-at-point nil)) (string-match "https?://[a-zA-Z0-9\-]+[.]+[a-zA-Z0-9\-]+" url-at-point))
        (w3m-view-url-with-external-browser url-at-point)
      (w3m-view-url-with-external-browser))))

;; (setq w3m-new-session-in-background nil)

(defun w3m-browse-clipboard ()
  "uses the clipboard if it's an url, otherwise calls w3m-browse-url"
  (interactive)
  (let ((cliptext (current-kill 0 t)))
    (if (string-match "https?://.*$" cliptext)
        (w3m-browse-url (match-string 0 cliptext))
      (w3m))))

(define-key w3m-mode-map (kbd "p") 'w3m-previous-buffer)
(define-key w3m-mode-map (kbd "n") 'w3m-next-buffer)
(define-key w3m-mode-map (kbd "y") 'w3m-delete-buffer)

(defun w3m-view-this-url-background-session ()
  (interactive)
  (save-window-excursion
    (let ((in-background-state w3m-new-session-in-background))
      (setq w3m-new-session-in-background t)
      (w3m-view-this-url-new-session)
      (setq w3m-new-session-in-background in-background-state))))

(define-key w3m-mode-map (kbd "C-;") 'w3m-view-this-url-background-session)

;; (defalias 'wws 'w3m-search-google-web-en)
(defalias 'wwe 'w3m-search-emacswiki)
(defalias 'wwso 'w3m-search-stack-overflow)
;; (defalias 'wwo 'w3m-view-url-with-external-browser)
(defalias 'ww 'w3m-browse-clipboard)
(setq browse-url-browser-function 'w3m)
;; (setq browse-url-browser-function 'browse-url-default-macosx-browser)

;;(load-file (expand-file-name "~/.emacs.d/site-lisp/w3mkeymap.el"))
;;(add-hook 'w3m-mode-hook '(lambda () (use-local-map dka-w3m-map)))

(defun w3m-search-stack-overflow ()
  "search stack overflow"
  (interactive)
  (w3m-search-advance "http://stackoverflow.com/search?q=" "Stack Overflow" 'utf-8))

(defun w3m-search-alc (string)
  "search alc"
  (interactive "sSearch ALC: ")
  (let ((search-string (format "http://eow.alc.co.jp/%s/UTF-8/" (w3m-url-encode-string string 'utf-8)))
        (oldbuf (current-buffer))
        (query (format "%s" string)))
    (progn
      (w3m-browse-url search-string)
      (switch-to-buffer oldbuf))))

(defun w3m-search-alc-at-point ()
  (interactive)
  (let ((text (if mark-active
                  (buffer-substring (point) (mark))
                (thing-at-point 'word))))
    (set-text-properties 0 (length text) nil text)
    (if (eq text nil)
        (call-interactively 'w3m-search-alc)
      (w3m-search-alc text))))

(defun alc-w3m-displayed (&optional url)
  (interactive)
  (if (string-match "eow\\.alc\\.co\\.jp" url)
      (let ((buffer-read-only nil)
            (beg (point-min)))
        (save-excursion
          (if (re-search-forward "検索文字[^列]" nil t)
              (delete-region (point) (point-min)))
          (while (re-search-forward "列[ \t]+" nil t)
            (replace-match"検索文字列: "))
          (delete-trailing-whitespace)
          (delete-blank-lines)))))

(add-hook 'w3m-display-hook 'alc-w3m-displayed)

(defalias 'wwa 'w3m-search-alc)
(defalias 'wwr 'w3m-search-alc-at-point)
(global-set-key (kbd "C-c j") 'w3m-search-alc-at-point)
(message "w3m settings")

(require 'revbufs)

(require 'bookmark+)

;;(add-hook 'after-init-hook 'org-agenda-list)
;;(add-hook 'after-init-hook 'bookmark-bmenu-list)

(bookmark-bmenu-list)

(require 'alpaca)
(require 'twittering-mode)
(autoload 'twittering-numbering "twittering-numbering" nil t)
(add-hook 'twittering-mode-hook 'twittering-numbering)

(setq twittering-connection-type-order
      '(wget curl urllib-http native urllib-https))

(setq twittering-use-master-password t)
(setq twittering-url-show-status nil)
(setq twittering-number-of-tweets-on-retrieval 200)
(setq twittering-icon-mode nil)
;; (setq twittering-timer-interval 900)

(if (and (boundp 'jmp-api-key) (boundp 'jmp-user-name))
    (progn (defvar jmp-api-url
             (format "http://api.j.mp/shorten?version=2.0.1&login=%s&apiKey=%s&format=text&longUrl=" jmp-user-name jmp-api-key))
           (add-to-list 'twittering-tinyurl-services-map
                        `(jmp . ,jmp-api-url))
           ;; api key and other information in custom.el
           (setq twittering-tinyurl-service 'jmp)))

(define-key twittering-mode-map (kbd "S-<tab>") 'twittering-goto-previous-thing)
(define-key twittering-mode-map (kbd "<S-tab>") 'twittering-goto-previous-thing)
(define-key twittering-mode-map (kbd "<S-iso-lefttab>") 'twittering-goto-previous-thing)
(define-key twittering-mode-map [(shift tab)] 'twittering-goto-previous-thing)
(define-key twittering-mode-map (kbd "S-TAB") 'twittering-goto-previous-thing)
(define-key twittering-mode-map (kbd "S-<return>") 'wwo)

(add-hook 'twittering-edit-mode-hook (lambda ()
                                       (ispell-minor-mode)
                                       (flyspell-mode)))

(add-hook 'twittering-mode-hook (lambda ()
                                  (twittering-search "emacs exclude:retweets filter:links")
                                  (twittering-search "emacs exclude:retweets")))

(defalias 'tw 'twittering-mode)
(defalias 'tt 'twittering-update-status-interactive)

(setq twittering-initial-timeline-spec-string
      '(":home"
        ":replies"
        ":favorites"
        ":direct_messages"
        ":search/lift scala/"
        ":search/twitter/"
        ":search/keysnail/"
        ":search/vimperator/"
        ":search/emacs/"
        ":search/eshell/"
        "richstyles/foo"))

(define-key twittering-edit-mode-map "\M-j" 'twittering-edit-replace-at-point)
(define-key twittering-edit-mode-map "\M-q" 'twittering-edit-cancel-status)
(define-key twittering-edit-mode-map "\M-s" 'twittering-edit-post-status)

(defun twittering-mode-exit ()
  "twittering-mode を終了する。"
  (interactive)
  (when (y-or-n-p "Really exit twittering-mode? ")
    (if twittering-timer
        (twittering-stop))
    (dolist (buf (twittering-get-buffer-list))
      (if (get-buffer buf)
          (kill-buffer buf))))
  (garbage-collect))

(defalias 'twe 'twittering-mode-exit)
(message "twittering mode setup")


(setq frame-title-format '("" invocation-name "@" system-name " "
                           global-mode-string "%b %+%+ %f" ))

;;(require 'auto-install)
;;(require 'todochiku)
;;(load-file "~/.emacs.d/site-lisp/work-timer.el")

;;(setq work-timer-working-time 10)
;;(global-set-key (kbd "C-x t m") 'work-timer-start)

;;(require 'epom)
;;(global-set-key (kbd "C-x t m") 'epom-start-cycle)

(require 'pomodoro)
(global-set-key (kbd "C-x t m") 'pomodoro-work)
(global-set-key (kbd "C-x t d") 'pomodoro-done)
(global-set-key (kbd "C-x t l") 'pomodoro-later)

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

                                        ; One of the main issues for me is that my home directory is
                                        ; NFS mounted. By setting all the autosave directories in /tmp,
                                        ; things run much quicker
(setq auto-save-directory (concat temp-directory "/autosave")
      auto-save-hash-directory (concat temp-directory "/autosave-hash")
      auto-save-directory-fallback "/var/tmp/"
      auto-save-list-file-prefix (concat temp-directory "/autosave-")
      auto-save-hash-p nil
      auto-save-timeout 15
      auto-save-interval 20)
(make-directory auto-save-directory t)

(message "auto save stuff")

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region (start end)
  (interactive "r")
  (let ((fill-column (point-max)))
    (fill-region start end nil)))

(add-to-list 'bkup-backup-directory-info
             (list tramp-file-name-regexp ""))
(setq tramp-bkup-backup-directory-info bkup-backup-directory-info)


(require 'weblogger)
(require 'zencoding-mode)

(defalias 'bl 'weblogger-start-entry)
(defalias 'bll 'weblogger-select-configuration)

(add-hook 'weblogger-entry-mode-hook 'turn-off-auto-fill)
(add-hook 'weblogger-entry-mode-hook 'ispell-minor-mode)
(add-hook 'weblogger-entry-mode-hook 'flyspell-mode)

(require 'textile-minor-mode)

;;(add-hook 'weblogger-entry-mode-hook 'textile-minor-mode)

(message "dddf2")
(defun publish-post ()
  (interactive)
  (textile-to-html-buffer-respect-weblogger)
  (weblogger-publish-entry))

(define-key weblogger-entry-mode-map "\C-x\C-s" 'publish-post)

(when (eq window-system 'mac)
  (remove-hook 'minibuffer-setup-hook 'mac-change-language-to-us))

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/site-lisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; (require 'auto-async-byte-compile)
;; (setq auto-async-byte-compile-exclude-files-regexp "org\\|junk\\|\\.revive\\.el\\|init\\.el")

;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(setq uniquify-separator ":")

(require 'screen-lines)
;; (add-hook 'text-mode-hook 'turn-on-screen-lines-mode)

(require 'summarye)

(message "point stuff")

(defun point-to-top ()
  "Put cursor on top line of window, like Vi's H."
  (interactive)
  (move-to-window-line 0))

(defun point-to-bottom ()
  "Put cursor at bottom of last visible line, like Vi's L."
  (interactive)
  (move-to-window-line -1)
  (re-search-backward "\\S " (point-min) t 5))

(defun point-to-middle ()
  "Put cursor on middle line of window"
  (interactive)
  (let ((win-height (if (> (count-screen-lines) (window-height))
                        (window-height)
                      (count-screen-lines))))
    (move-to-window-line (floor (* win-height 0.4)))))

(global-set-key (kbd "C-x x") 'point-to-top)
(global-set-key (kbd "C-x c") 'point-to-bottom)
(global-set-key (kbd "C-x g") 'point-to-middle)
(global-set-key (kbd "C-x r e") 'string-insert-rectangle)

(defun my-ido-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map "\C-k" 'ido-next-match)
  (define-key ido-completion-map "\C-j" 'ido-prev-match)
  (define-key ido-completion-map "\C-n" 'ido-next-match)
  (define-key ido-completion-map "\C-p" 'ido-prev-match))

(add-hook 'ido-setup-hook 'my-ido-keys)
(defalias 'qrr 'query-replace-regexp)

(require 'fuzzy)
(turn-on-fuzzy-isearch)

(defalias 'hb 'hide-body)
(defalias 'sb 'show-all)
(defalias 'he 'hide-entry)
(defalias 'se 'show-entry)

(require 'enclose)
(enclose-remove-encloser "'")
;; (add-hook 'LaTeX-mode-hook 'enclose-mode)
(add-hook 'weblogger-entry-mode 'enclose-mode)

(message "ido keys")

;; (autoload 'mode-compile "mode-compile"
;;   "Command to compile current buffer file based on the major mode" t)
;; (global-set-key "\C-cc" 'mode-compile)
;; (autoload 'mode-compile-kill "mode-compile"
;;   "Command to kill a compilation launched by `mode-compile'" t)
;; (global-set-key "\C-ck" 'mode-compile-kill)

(require 'eldoc-extension)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(setq path-to-ctags "/usr/local/bin/ctags")

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name))))

(setq tags-revert-without-query t)

(require 'etags-table)
(require 'etags-select)
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)

(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
(require 'dired-sort-map)

(require 'rinari)
(require 'rhtml-mode)
(require 'ruby-electric)
(require 'textmate)
(textmate-mode)
(define-key *textmate-mode-map* (kbd "M-;") 'comment-or-uncomment-region-or-line)
(global-set-key "\M-T" 'transpose-words)

(defun is-rails-project ()
  (when (textmate-project-root)
    (file-exists-p (expand-file-name "config/environment.rb" (textmate-project-root)))))

(defun run-rails-test-or-ruby-buffer ()
  (interactive)
  (if (is-rails-project)
      (let* ((path (buffer-file-name))
             (filename (file-name-nondirectory path))
             (test-path (expand-file-name "test" (textmate-project-root)))
             (command (list ruby-compilation-executable "-I" test-path path)))
        (pop-to-buffer (ruby-compilation-do filename command)))
    (ruby-compilation-this-buffer)))


(autoload 'ruby-mode "ruby-mode" nil t)
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-hook 'ruby-mode-hook '(lambda ()
                             (setq ruby-deep-arglist t)
                             (setq ruby-deep-indent-paren nil)
                             (setq c-tab-always-indent nil)
                             (require 'inf-ruby)
                             (require 'ruby-compilation)
                             (define-key ruby-mode-map (kbd "M-r") 'run-rails-test-or-ruby-buffer)))

(autoload 'rhtml-mode "rhtml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
(add-hook 'rhtml-mode '(lambda ()
                         (define-key rhtml-mode-map (kbd "M-s") 'save-buffer)))

(message "rhtml/yaml stuff")

(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(setq cssm-indent-function #'cssm-c-style-indenter)
(add-hook 'css-mode-hook '(lambda ()
                            (require 'css-complete)
                            (setq css-indent-level 2)
                            (setq css-indent-offset 2)))

(require 'sense-region)
(sense-region-on)

(require 'dired-sort-map)

(require 'breadcrumb)
(global-set-key [(control tab)] 'bc-set) ;; Shift-SPACE for set bookmark
(global-set-key [(control c)(u)] 'bc-previous) ;; M-j for jump to previous
(global-set-key [(control c)(i)] 'bc-next) ;; Shift-M-j for jump to next
(global-set-key [(meta up)] 'bc-local-previous) ;; M-up-arrow for local previous
(global-set-key [(meta down)] 'bc-local-next) ;; M-down-arrow for local next
(global-set-key [(control c)(n)] 'bc-goto-current) ;; C-c j for jump to current bookmark
(global-set-key [(control c)(m)] 'bc-list) ;; C-x M-j for the bookmark menu list

(global-set-key [(control tab)] 'other-frame)
(global-set-key [(shift control tab)] '(lambda() (interactive) (other-frame -1)))

(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

(require 'goto-chg)
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)

(require 'midnight)

(message "window movement")

(windmove-default-keybindings 'meta)

(define-prefix-command 'numwin-bindings-keymap)
(define-key numwin-bindings-keymap (vector ?7) 'windmove-left)
(define-key numwin-bindings-keymap (vector ?8) 'windmove-right)
(define-key numwin-bindings-keymap (vector ?9) 'windmove-up)
(define-key numwin-bindings-keymap (vector ?0) 'windmove-down)
(global-set-key (kbd "C-x 7") 'numwin-bindings-keymap)

(load "~/.emacs.d/haskell-mode/haskell-site-file.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(setq haskell-font-lock-symbols t)
;; (setq haskell-hoogle-command "~/.cabal/bin/hoogle")

(message "igrep")

(require 'igrep)
(setq igrep-options "-ir")
(igrep-define lgrep (igrep-use-zgrep nil) (igrep-regex-option "-n -0u8"))
(igrep-find-define lgrep (igrep-use-zgrep nil) (igrep-regex-option "-n -0u8"))

(require 'grep-a-lot)
(grep-a-lot-setup-keys)
(grep-a-lot-advise igrep)

(require 'grep-edit)

(require 'cedet)
;; (require 'jde)
(autoload 'jde-mode "jde" "JDE mode." t)
;; (add-to-list 'auto-mode-alist '("\\java\\'" . jde-mode))

;; (semantic-load-enable-minimum-features)
;; (require 'malabar-mode)
;; (setq malabar-groovy-lib-dir "~/emacs.d/malabar-1.5-SNAPSHOT/lib")
;; (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))



;; (load-file "~/.emacs.d/site-lisp/mvn.el")

(require 'undo-tree)
(global-undo-tree-mode)

(message "insert")

(defun insert-time ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d-%R")))

(find-function-setup-keys)

(defun isearch-yank-symbol ()
  "*Put symbol at current point into search string."
  (interactive)
  (let ((sym (symbol-at-point)))
    (if sym
        (progn
          (setq isearch-regexp t
                isearch-string (concat "\\_<" (regexp-quote (symbol-name sym)) "\\_>")
                isearch-message (mapconcat 'isearch-text-char-description isearch-string "")
                isearch-yank-flag t))
      (ding)))
  (isearch-search-and-update))

(define-key isearch-mode-map "\M-E" 'isearch-yank-symbol)

(require 'switch-window)
(setq switch-window-increase 10)
(setq switch-window-timeout 3)

(require 'sr-speedbar)

(message "sr-speedbar")

(setq tramp-bkup-backup-directory-info nil)
(require 'backup-dir)
(add-to-list 'bkup-backup-directory-info
             (list tramp-file-name-regexp ""))

(autoload 'ange-ftp "ange-ftp" nil t)
;;(add-hook 'ange-ftp-process-startup-hook 'ecb-deactivate)
(autoload 'tramp "tramp" nil t)
(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*") ;
(setq tramp-persistency-file-name nil)

(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

(setq-default line-spacing 0)

(require 'cssh)

(require 'list-processes+)
(defalias 'lp 'list-processes+)

(require 'yaoddmuse)
(setq yaoddmuse-username "baron")
;; (yaoddmuse-update-pagename nil)

;; trouble with zsh in emacs
(setq shell-file-name (executable-find "bash"))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

(require 'eshell)
(require 'shell-pop)
(setq eshell-save-history-on-exit t)
(shell-pop-set-internal-mode "eshell")
(shell-pop-set-window-height 60)

(defun eshell-maybe-bol ()
  (interactive)
  (let ((p (point)))
    (eshell-bol)
    (if (= p (point))
        (beginning-of-line))))


(message "eshell")

(add-hook 'eshell-mode-hook
          (lambda ()
            (define-key eshell-mode-map (kbd "C-a") 'eshell-maybe-bol)
            (define-key eshell-mode-map (kbd "C-r") 'eshell-isearch-backward)))

(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'eshell-load-hook 'ansi-color-for-comint-mode-on)
(autoload 'ansi-color-apply-on-region "ansi-color" nil t)
(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
                              eshell-last-output-end))
(add-hook 'eshell-output-filter-functions 'eshell-handle-ansi-color)

(when (require 'pcmpl-auto nil t)
  (when (require 'pcmpl-ssh nil t)
    (add-hook 'eshell-mode-hook 'pcomplete-shell-setup)))

(setq eshell-cmpl-ignore-case t)
(setq eshell-glob-include-dot-files t)
(setq eshell-glob-include-dot-dot t)
(setq eshell-ask-to-save-history nil)
(setq eshell-cmpl-cycle-completions t)
(setq eshell-history-file-name "~/.bash_history")
(setq eshell-history-size 1000000)
(setq eshell-hist-ignoredups t)

;; shell
(when (require 'shell-history nil t)
  (when (require 'anything-complete nil t)
    (add-hook 'shell-mode-hook
              (lambda ()
                (define-key shell-mode-map (kbd "C-r") 'anything-complete-shell-history)))

    (use-anything-show-completion 'anything-complete-shell-history
                                  '(length anything-c-source-complete-shell-history))))

(defun ido-eshell-history ()
  "Prompt with a completing list of unique eshell history items.

The selected item will be placed at the prompt on the eshell switched to by (eshell).
If existing, the current prompt will be deleted."
  (interactive)
  (progn
    (eshell)
    (end-of-buffer)
    (eshell-bol)
    (unless (= (point) (point-max))
      (kill-line))
    (let ((history nil)
          (index (1- (ring-length eshell-history-ring))))
      ;; taken from em-hist.el, excepting the duplicate check
      (while (>= index 0)
        (let ((hist (eshell-get-history index)))
          (when (not (member hist history))
            (setq history (cons hist history))))
        (setq index (1- index)))
      (let* ((item (if (and (boundp 'ido-mode) ido-mode)
                       (ido-completing-read "Select history item: "
                                            history)
                     (completing-read "Select history item: "
                                      history))))
        (insert item)))))
(add-hook 'eshell-mode-hook (lambda ()
                              (define-key
                                eshell-mode-map "\C-c\C-x" 'ido-eshell-history)))


(autoload 'multi-eshell "multi-eshell" t)
(setq multi-eshell-name "*eshell*")
(setq multi-eshell-shell-function `(eshell))

(load-library "~/.emacs.d/site-lisp/shell-toggle-patched.el")
(autoload 'shell-toggle "shell-toggle"
  "Toggles between the *shell* buffer and whatever buffer you are editing."
  t)
(autoload 'shell-toggle-cd "shell-toggle"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
(setq shell-toggle-launch-shell 'shell-toggle-eshell)


(defalias 'sh 'shell-toggle-cd)
(require 'lispxmp)

;; needed since OSX 's "ls" command is different from unix
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

(defalias 'qrr 'query-replace-regexp)

(require 'header2)
(add-hook 'emacs-lisp-mode-hook 'auto-make-header)

(require 're-builder+)

(message "rebuilder")


(defun reb-query-replace (to-string)
  "Replace current RE from point with `query-replace-regexp'."
  (interactive
   (progn (barf-if-buffer-read-only)
          (list (query-replace-read-to (reb-target-binding reb-regexp)
                                       "Query replace" t))))
  (with-current-buffer reb-target-buffer
    (query-replace-regexp (reb-target-binding reb-regexp) to-string)))

(define-key reb-mode-map "\C-g" 'reb-quit)
(define-key reb-mode-map "\C-w" 'reb-copy)
(define-key reb-mode-map "\C-s" 'reb-next-match)
(define-key reb-mode-map "\C-r" 'reb-prev-match)
(define-key reb-mode-map "\M-%" 'reb-query-replace)

(defalias 'reb 're-builder)

(require 'text-translator)
(global-set-key "\C-x\M-t" 'text-translator)

;; options to switch enjine
;; (setq text-translator-default-engine "excite.co.jp_enja")
;; (setq text-translator-default-engine "google.com_enja")

(defun insert-translation-buffer ()
  (interactive)
  (newline)
  (insert-buffer "*translated*")
  (newline))

(defun insert-translation ()
  (interactive)
  (progn
    (text-translator nil)
    (sleep-for 1))
  (insert-translation-buffer))

(global-set-key "\C-x\M-r" 'insert-translation)

;; quick and dirty buffer menu sorting
(define-key Buffer-menu-mode-map (kbd "M-s s") '(lambda() (interactive) (Buffer-menu-sort 2)))
(define-key Buffer-menu-mode-map (kbd "M-s d") '(lambda() (interactive) (Buffer-menu-sort 3)))
(define-key Buffer-menu-mode-map (kbd "M-s f") '(lambda() (interactive) (Buffer-menu-sort 4)))
(define-key Buffer-menu-mode-map (kbd "M-s g") '(lambda() (interactive) (Buffer-menu-sort 5)))

(autoload 'espresso-mode "espresso" "Javascript mode" t)
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js" . espresso-mode))

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(message "javascript espresso")

(defun espresso-custom-setup ()
  (setq tab-width 4)
  (moz-minor-mode 1))

(add-hook 'espresso-mode-hook 'espresso-custom-setup)

;; quick thumbs mode navigation
(add-hook 'thumbs-mode-hook (lambda ()
                              (define-key thumbs-mode-map (kbd "j") 'next-line)
                              (define-key thumbs-mode-map (kbd "k") 'previous-line)
                              (define-key thumbs-mode-map (kbd "n") 'next-line)
                              (define-key thumbs-mode-map (kbd "p") 'previous-line)
                              (define-key thumbs-mode-map (kbd "l") 'forward-char)
                              (define-key thumbs-mode-map (kbd "h") 'backward-char)
                              (define-key thumbs-mode-map (kbd "f") 'forward-char)
                              (define-key thumbs-mode-map (kbd "b") 'backward-char)))

;; image view mode
(add-hook 'thumbs-view-image-mode-hook (lambda ()
                                         (define-key thumbs-view-image-mode-map (kbd "j") 'thumbs-next-image)
                                         (define-key thumbs-view-image-mode-map (kbd "k") 'thumbs-previous-image)
                                         (define-key thumbs-view-image-mode-map (kbd "n") 'thumbs-next-image)
                                         (define-key thumbs-view-image-mode-map (kbd "p") 'thumbs-previous-image)
                                         (define-key thumbs-view-image-mode-map (kbd "f") 'thumbs-next-image)
                                         (define-key thumbs-view-image-mode-map (kbd "b") 'thumbs-previous-image)
                                         (define-key thumbs-view-image-mode-map (kbd "Q") '(lambda()
                                                                                             (interactive)
                                                                                             (thumbs-display-thumbs-buffer)
                                                                                             (thumbs-kill-buffer)))))

(mouse-avoidance-mode 'exile)

(require 'cache)
(require 'c-eldoc)
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

(require 'goto-chg)

;; (require 'slack-rtm)

(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)

(require 'htmlutils)

(load-file "~/.emacs.d/site-lisp/anything-git-project.el")

(require 'auto-highlight-symbol-config)
(add-to-list 'ahs-modes 'scala-mode)

(set-face-attribute 'ahs-face nil :foreground "Black" :background "LightBlue2")
(set-face-attribute 'ahs-plugin-defalt-face nil :foreground "Black" :background "Orange1")

(setq disabled-command-function nil)

(require 'window-numbering)
(window-numbering-mode nil)

(require 'window-number)
(window-number-mode t)
(autoload 'window-number-meta-mode "window-number"
  "A global minor mode that enables use of the M- prefix to select
windows, use `window-number-mode' to display the window numbers in
the mode-line."
  t)

(message "window revive")

(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)

(setq revive:major-mode-command-alist-private
      '((w3m-mode . w3m)
        ("*w3m*" . w3m)))

(defalias 'resume-save 'save-current-configuration)

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))



(load "~/.emacs.d/nxhtml/autostart.el")
(setq mumamo-chunk-coloring 'no-chunks-colored)

;; numbering rects usage:
;; http://d.hatena.ne.jp/rubikitch/20110221/seq
(eval-when-compile (require 'cl))
(defun number-rectangle (start end format-string from)
  "Delete (don't save) text in the region-rectangle, then number it."
  (interactive
   (list (region-beginning) (region-end)
         (read-string "Number rectangle: " (if (looking-back "^ *") "%d. " "%d"))
         (read-number "From: " 1)))
  (save-excursion
    (goto-char start)
    (setq start (point-marker))
    (goto-char end)
    (setq end (point-marker))
    (delete-rectangle start end)
    (goto-char start)
    (loop with column = (current-column)
          while (<= (point) end)
          for i from from do
          (insert (format format-string i))
          (forward-line 1)
          (move-to-column column)))
  (goto-char start))

(defun count-string-matches (regexp string)
  (with-temp-buffer
    (insert string)
    (count-matches regexp (point-min) (point-max))))
(defun seq (format-string from to)
  "Insert sequences with FORMAT-STRING.
FORMAT-STRING is like `format', but it can have multiple %-sequences."
  (interactive
   (list (read-string "Input sequence Format: ")
         (read-number "From: " 1)
         (read-number "To: ")))
  (save-excursion
    (loop for i from from to to do
          (insert (apply 'format format-string
                         (make-list (count-string-matches "%[^%]" format-string) i))
                  "\n")))
  (end-of-line))

(defun duplicate-this-line-forward (n)
  "Duplicates the line point is on. The point is next line.
 With prefix arg, duplicate current line this many times."
  (interactive "p")
  (when (eq (point-at-eol)(point-max))
    (save-excursion (end-of-line) (insert "\n")))
  (save-excursion
    (beginning-of-line)
    (dotimes (i n)
      (insert-buffer-substring (current-buffer) (point-at-bol)(1+ (point-at-eol))))))

(message "number rect")

(require 'gse-number-rect)
(global-set-key "\C-hj" 'number-rectangle)

(defun byte-compile-all-my-files ()
  "byte compile everything"
  (interactive)
  (byte-recompile-directory "~/.emacs.d/site-lisp" 0 t)
  (byte-recompile-directory "~/.emacs.d" 0 t)
  (byte-recompile-directory "~/.emacs.d/wanderlust" 0 t)
  (byte-recompile-directory "~/.emacs.d/vim" 0 t)
  (byte-recompile-directory "~/.emacs.d/ensime_2.9.1-0.7.6/elisp" 0 t)
  (byte-recompile-directory "~/.emacs.d/twittering" 0 t))

(defalias 'by 'byte-compile-all-my-files)

(require 'nazna)

(require 'dired-copy-paste)

(require 'rainbow-mode)

(require 'move-region)

(defvar current-time-format "%a %H:%M:%S")

(defun echo-time-now ()
  (interactive)
  (message (format-time-string current-time-format (current-time))))

(defalias 'ti 'echo-time-now)

(require 'bm)

(when (require 'auto-mark nil t)
  (setq auto-mark-command-class-alist
        '((anything . anything)
          (goto-line . jump)
          (indent-for-tab-command . ignore)
          (undo . ignore)))
  (setq auto-mark-command-classifiers
        (list (lambda (command)
                (if (and (eq command 'self-insert-command)
                         (eq last-command-char ? ))
                    'ignore))))
  (global-auto-mark-mode 1))

(defalias 'dj 'dired-jump-other-window)

(require 'generic-x)

(autoload 'tidy-buffer "tidy" "Run Tidy HTML parser on current buffer" t)
(autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
(autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
(autoload 'tidy-build-menu "tidy" "Install an options menu for HTML Tidy." t)

(defun toggle-line-spacing ()
  "Toggle line spacing between no extra space to extra half line height."
  (interactive)
  (if (eq line-spacing nil)
      (setq-default line-spacing 0.5) ; add 0.5 height between lines
    (setq-default line-spacing nil)))

(defalias 'ts 'toggle-line-spacing)

(defun sudo-edit (&optional arg)
  (interactive "p")
  (if arg
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun sudo-edit-current-file ()
  (interactive)
  (find-alternate-file (concat "/sudo:root@localhost:" (buffer-file-name (current-buffer)))))

(message "sudo edit (not working)")


;; ;; code from failed sudo attempt
;; (require 'sudo)

;; (defun sudo-before-save-hook ()
;; (set (make-local-variable 'sudo:file) (buffer-file-name))
;; (when sudo:file
;; (unless(file-writable-p sudo:file)
;; (set (make-local-variable 'sudo:old-owner-uid) (nth 2 (file-attributes sudo:file)))
;; (when (numberp sudo:old-owner-uid)
;; (unless (= (user-uid) sudo:old-owner-uid)
;; (when (y-or-n-p
;; (format "File %s is owned by %s, save it with sudo? "
;; (file-name-nondirectory sudo:file)
;; (user-login-name sudo:old-owner-uid)))
;; (sudo-chown-file (int-to-string (user-uid)) (sudo-quoting sudo:file))
;; (add-hook 'after-save-hook
;; (lambda ()
;; (sudo-chown-file (int-to-string sudo:old-owner-uid)
;; (sudo-quoting sudo:file))
;; (if sudo-clear-password-always
;; (sudo-kill-password-timeout)))
;; nil ;; not append
;; t ;; buffer local hook
;; )))))))


;; (add-hook 'before-save-hook 'sudo-before-save-hook)

(autoload 'crontab-edit "crontab"
  "Function to allow the easy editing of crontab files." t)
(autoload 'crontab-mode "crontab-mode" "font-locking for crontab" t)

(add-to-list 'auto-mode-alist '("\\.cron\\(tab\\)?\\'" . crontab-mode))
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\.[^el]+" . crontab-mode))

(message "crontab")

(cond
 ((>= emacs-major-version '23)
  (progn
    (setq x-select-enable-clipboard t)
    (set-clipboard-coding-system 'utf-8)

    (require 'zlc)
    (setq zlc-select-completion-immediately nil)
    (setq delete-by-moving-to-trash nil))))

(require 'savekill)

(message "savekill")

;; credit to Benjamin Riefenstahl <Benjamin.Riefenstahl@epost.de>
(defun benny-antiword-file-handler (operation &rest args)
  ;; First check for the specific operations
  ;; that we have special handling for.
  (cond ((eq operation 'insert-file-contents)
         (apply 'benny-antiword-insert-file args))
        ((eq operation 'file-writable-p)
         nil)
        ((eq operation 'write-region)
         (error "Word documents can't be written"))
        ;; Handle any operation we don't know about.
        (t (let ((inhibit-file-name-handlers
                  (cons 'benny-antiword-file-handler
                        (and (eq inhibit-file-name-operation operation)
                             inhibit-file-name-handlers)))
                 (inhibit-file-name-operation operation))
             (apply operation args)))))

(defun benny-antiword-insert-file (filename &optional visit beg end replace)
  (set-buffer-modified-p nil)
  (setq buffer-file-name (file-truename filename))
  (setq buffer-read-only t)
  (let ((start (point))
        (inhibit-read-only t))
    (if replace (delete-region (point-min) (point-max)))
    (save-excursion
      (let ((coding-system-for-read 'utf-8)
            (filename (encode-coding-string
                       buffer-file-name
                       (or file-name-coding-system
                           default-file-name-coding-system))))
        (call-process "antiword" nil t nil "-m" "UTF-8.txt"
                      filename))
      (list buffer-file-name (- (point) start)))))

(defun no-word ()
  (interactive)
  (progn
    (benny-antiword-insert-file (buffer-file-name) nil nil nil t)
    (beginning-of-buffer)))

(add-to-list 'auto-mode-alist '("\\.doc\\'" . no-word))

(defalias 'ir 'indent-region)

(defun fixup-spaces ()
  (interactive)
  (save-excursion
    (if(eq mark-active
           nil)
        (progn
          (beginning-of-line)
          ;; (line-beginning-position)
          (while (re-search-forward "[ ]+" (line-end-position) t)
            (replace-match " " nil nil)))
      (progn
        (goto-char (region-beginning))
        (while (re-search-forward "[ ]+" (region-end) t)
          (replace-match " " nil nil))))))

(defun fixup-buffer-spaces ()
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (fixup-spaces)))

(defun save-elisp-to-local ()
  (interactive)
  (write-file "~/.emacs.d/site-lisp/"))

(message "save elisp")

(require 'sequential-command-config)
(sequential-command-setup-keys)

(require 'transpose-frame)

(add-to-list 'auto-mode-alist
             '("/\\(rfc\\|std\\)[0-9]+\\.txt\\'" . rfcview-mode))
(autoload 'rfcview-mode "rfcview" nil t)

(autoload 'get-rfc-view-rfc "get-rfc" "Get and view an RFC" t nil)
(autoload 'get-rfc-view-rfc-at-point "get-rfc" "View the RFC at point" t nil)
(autoload 'get-rfc-grep-rfc-index "get-rfc" "Grep rfc-index.txt" t nil)
(setq get-rfc-local-rfc-directory "~/Dropbox/rfc/")
(setq get-rfc-open-in-new-frame nil)

(require 'google)
(defalias 'g 'google-code)

(require 'elisp-format)

(require 'color-moccur)
(require 'moccur-edit)
(setq moccur-split-word t)
(global-set-key (kbd "C-c o") 'occur-by-moccur)

(message "moccur")

;; adapted from
;; http://d.hatena.ne.jp/derui/20100223/1266929390
(require 'viewer)
(viewer-stay-in-setup)
(setq viewer-modeline-color-unwritable "tomato"
      viewer-modeline-color-view "orange")
(viewer-change-modeline-color-setup)


(setq view-read-only t)
(defvar pager-keybind
  `( ;; vi-like
    ("a" . ,(lambda () (interactive)
              (let ((anything-c-moccur-enable-initial-pattern nil))
                (anything-c-moccur-occur-by-moccur))))
    (";" . anything)
    ("h" . backward-word)
    ("l" . forward-word)
    ("j" . next-line)
    ("k" . previous-line)
    ("b" . scroll-down)
    (" " . scroll-up)
    ;; w3m-like
    ;; ("m" . gene-word)
    ("i" . win-delete-current-window-and-squeeze)
    ("w" . forward-word)
    ("e" . backward-word)
    ("(" . point-undo)
    (")" . point-redo)
    ("J" . ,(lambda () (interactive) (scroll-up 1)))
    ("K" . ,(lambda () (interactive) (scroll-down 1)))
    ;; bm-easy
    ;; ("." . bm-toggle)
    ;; ("[" . bm-previous)
    ;; ("]" . bm-next)
    ;; langhelp-like
    ("c" . scroll-other-window-down)
    ("v" . scroll-other-window)
    ))

(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
          (define-key keymap key cmd))))
  keymap)

(defadvice find-file
  (around find-file-switch-to-view-file (file &optional wild) activate)
  (if (and (not (file-writable-p file))
           (not (file-directory-p file)))
      (view-file file)
    ad-do-it))

(message "find file")

(defvar view-mode-original-keybind nil)
(defun view-mode-set-window-controls (prefix-key)
  (unless view-mode-original-keybind
    (dolist (l (cdr view-mode-map))
      (if (equal ?s (car l))
          (setq view-mode-original-keybind (list prefix-key (cdr l))))))
  (define-key view-mode-map prefix-key view-mode-window-control-map))

(defun view-mode-unset-window-controls()
  (when view-mode-original-keybind
    (define-key view-mode-map (car view-mode-original-keybind)
      (cadr view-mode-original-keybind))
    (setq view-mode-original-keybind nil)))



;; view-mode時に、手軽にウィンドウ移動、切替を行えるようにする。
(defvar view-mode-window-control-map nil)
(unless view-mode-window-control-map
  (setq view-mode-window-control-map (make-sparse-keymap))

  (define-key view-mode-window-control-map (kbd "l") 'windmove-right)
  (define-key view-mode-window-control-map (kbd "h") 'windmove-left)
  (define-key view-mode-window-control-map (kbd "k") 'windmove-down)
  (define-key view-mode-window-control-map (kbd "j") 'windmove-up)

  (define-key view-mode-window-control-map (kbd "d") 'delete-window)
  (define-key view-mode-window-control-map (kbd "wh") 'split-window-horizontally)
  (define-key view-mode-window-control-map (kbd "wv") 'split-window-vertically)
  (define-key view-mode-window-control-map (kbd "o") 'delete-other-windows)
  )

(defun view-mode-set-vi-keybindings ()
  (define-many-keys view-mode-map pager-keybind)
  (hl-line-mode 1)
  (view-mode-set-window-controls "s")
  )

(add-hook 'view-mode-hook 'view-mode-set-vi-keybindings)


(which-func-mode 1)
(setq which-func-modes t)
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)

(setq header-line-format
      (list "-"
            "%b--"
            ;; Note that this is evaluated while making the list.
            ;; It makes a mode-line construct which is just a string.
            ":"
            '(:eval (current-time-string))
            " "
            '(which-func-mode ("" which-func-format))
            '(line-number-mode "L%l--")
            '(column-number-mode "C%c--")
            ))

(require 'summarye)
(defalias 'summarize-funcs 'se/make-summary-buffer)

(require 'http-twiddle)

(message "eshell")

(defun eshell/ff (file)
  (find-file-other-window file))

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; prompt when quitting Emacs in GUI
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

(global-set-key (kbd "C-x C-c") 'ask-before-closing)

(require 'rebound)
(rebound-mode t)

(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(migemo-init)

(require 'diminish)
(diminish 'abbrev-mode "Abv")
(diminish 'auto-complete-mode)
(diminish 'auto-highlight-symbol-mode)
(diminish 'eldoc-mode)
(diminish 'flyspell-mode "f")
(diminish 'highlight-parentheses-mode)
(diminish 'rainbow-delimiters-mode)
(diminish 'icicle-mode)
(diminish 'paredit-mode "PE")
(diminish 'reftex-mode)
(if (featurep 'scim)
    (diminish 'scim-mode))
(diminish 'undo-tree-mode)
(diminish 'window-number-mode)
(diminish 'yas/minor-mode "Y")

(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (setq mode-name "el")))

(add-hook 'LaTeX-mode-hook
          (lambda()
            (setq TeX-base-mode-name "lx")))

(require 'muse-mode)
(require 'muse-html)
(require 'muse-latex)
(require 'muse-texinfo)
(require 'muse-docbook)
(require 'muse-project)
(require 'muse-journal )

(message "muse")

(setq muse-project-alist
      '(("Journal" ("~/journal/"
                    :default "journal"))))

(defun date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d.%m.%Y")
            (format-time-string "%Y-%m-%d"))))

(defun timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))

(require 'load-directory)

;; delete this after the power crisis
;; (require 'tepco-power-status)
;; (require 'yasima)
;; (yasima-mode)

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

(message "dddf25")

(require 'sql)
;; (autoload 'sql-mode "sql-mode" "SQL Editing Mode" t)
(setq auto-mode-alist
      (append '(("\\.sql$" . sql-mode)
                ("\\.tbl$" . sql-mode)
                ("\\.sp$" . sql-mode))
              auto-mode-alist))

(eval-after-load "sql"
  '(lambda () (progn
                (require 'sql-indent)
                (require 'sql-transform)
                (add-hook 'sql-mode-hook
                          (function (lambda ()
                                      (local-set-key "\C-cu" 'sql-to-update)))))))

;; (defadvice sql-send-region (after sql-store-in-history)
;; "The region sent to the SQLi process is also stored in the history."
;; (let ((history (buffer-substring-no-properties start end)))
;; (save-excursion
;; (set-buffer sql-buffer)
;; (message history)
;; (if (and (funcall comint-input-filter history)
;; (or (null comint-input-ignoredups)
;; (not (ring-p comint-input-ring))
;; (ring-empty-p comint-input-ring)
;; (not (string-equal (ring-ref comint-input-ring 0)
;; history))))
;; (ring-insert comint-input-ring history))
;; (setq comint-save-input-ring-index comint-input-ring-index)
;; (setq comint-input-ring-index nil))))

;; (ad-activate 'sql-send-region)

(defun my-sqli-setup ()
  "Set the input ring file name based on the product name."
  (setq sql-input-ring-file-name
        (concat "~/." (symbol-name sql-product) "_history"))
  (setq sql-input-ring-separator "\n"))

(add-hook 'sql-interactive-mode-hook 'my-sqli-setup)

(require 'pydoc-info)

(autoload 'php-mode "php-mode")
(setq auto-mode-alist
      (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq php-mode-force-pear t)
(add-hook 'php-mode-user-hook
          '(lambda ()
             (setq php-manual-path "~/Dropbox/php_manual/")))

(require 'php-repl)

(require 'drupal-mode)
(autoload 'drupal-mode "drupal-mode" "Major mode for editing drupal php " t)


(message "drupal")

(add-to-list 'auto-mode-alist '("\\.\\(module\\|test\\|install\\|theme\\)$" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.info" . conf-windows-mode))

(require 'php-doc nil t)
(setq php-doc-directory "~/Dropbox/php_manual/")
(add-hook 'php-mode-hook
          (lambda ()
            (local-set-key "\t" 'php-doc-complete-function)
            (local-set-key (kbd "\C-c h") 'php-doc)
            (set (make-local-variable 'eldoc-documentation-function)
                 'php-doc-eldoc-function)
            (eldoc-mode 1)))

(require 'wide-n)

(require 'change-case)

(global-auto-revert-mode 1)

(require 'delicious)

(require 'whitespace)
(setq whitespace-display-mappings '((space-mark ?\ [?\u00B7]) (newline-mark ?\n [?$ ?\n]) (tab-mark ?\t [?\u00BB ?\t])))

(require 'dabbrev-ja)

(require 'navi2ch)

(require 'fastnav)
(global-set-key "\M-z" 'fastnav-zap-up-to-char-forward)
(global-set-key "\M-Z" 'fastnav-zap-up-to-char-backward)
(global-set-key (kbd "C-c ;") 'fastnav-jump-to-char-forward)
(global-set-key (kbd "C-c ,") 'fastnav-jump-to-char-backward)

(require 'android-mode)
(setq android-mode-sdk-dir "~/android-sdk")

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
(setq ack-executable (executable-find "ack-grep"))
(setq ack-and-a-half-executable ack-executable)

(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-samee "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)


(message "ack")

;; (require 'gtags)
;; (defun gtags-root-dir ()
;; "Returns GTAGS root directory or nil if doesn't exist."
;; (with-temp-buffer
;; (if (zerop (call-process "global" nil t nil "-pr"))
;; (buffer-substring (point-min) (1- (point-max)))
;; nil)))

;; (defun gtags-update ()
;; "Make GTAGS incremental update"
;; (call-process "global" nil nil nil "-u"))

;; (defun gtags-update-hook ()
;; (when (gtags-root-dir)
;; (gtags-update)))

;; (add-hook 'after-save-hook #'gtags-update-hook)

;; (defun ww-next-gtag ()
;; "Find next matching tag, for GTAGS."
;; (interactive)
;; (let ((latest-gtags-buffer
;; (car (delq nil (mapcar (lambda (x) (and (string-match "GTAGS SELECT" (buffer-name x)) (buffer-name x)) )
;; (buffer-list)) ))))
;; (cond (latest-gtags-buffer
;; (switch-to-buffer latest-gtags-buffer)
;; (next-line)
;; (gtags-select-it nil)))))


;; (add-hook 'gtags-mode-hook
;; (lambda()
;; (local-set-key [(control meta ,)] 'ww-next-gtag)
;; (local-set-key (kbd "M-.") 'gtags-find-tag) ; find a tag, also M-.
;; (local-set-key (kbd "M-,") 'gtags-find-rtag))) ; reverse tag

;; (require 'elscreen)
;; (require 'elscreen-w3m)
;; (require 'elscreen-color-theme)
;; (require 'elscreen-server)
;; (require 'elscreen-wl)
;; (require 'elscreen-dired)
;; (require 'elscreen-gf)

(message "elscreen")

(require 'multiple-line-edit)
(global-set-key "\C-c<" 'mulled/edit-trailing-edges)
(global-set-key "\C-c>" 'mulled/edit-leading-edges)


(require 'auto-indent-mode)
;; (auto-indent-global-mode)

(defmacro append-to-list (to lst)
  `(setq ,to (append ,lst ,to)))

;; FIXME: probably doesn't work
;; (append-to-list auto-indent-disabled-modes-list '("makefile-automake-mode" "makefile-gmake-mode" "makefile-makepp-mode" "makefile-bsdmake-mode" "makefile-imake-mode"))

(append-to-list auto-indent-disabled-modes-list '(makefile-automake-mode makefile-gmake-mode makefile-makepp-mode makefile-bsdmake-mode makefile-imake-mode))

(require 'smartchr)

(defun smartchr-custom-keybindings ()
  (local-set-key (kbd "=") (smartchr '(" = " " == " "=")))
  (local-set-key (kbd "!") (smartchr '("!" "!=")))
  ;; !! がカーソルの位置
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  (local-set-key (kbd "-") (smartchr '("-" "->`!!'" "-=")))
  (local-set-key (kbd "+") (smartchr '("+" "++" "+=")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[ [`!!'] ]" "[")))
  (local-set-key (kbd "{") (smartchr '("{\n`!!'\n}" "{`!!'}" "{")))
  (local-set-key (kbd "`") (smartchr '("\``!!''" "\`")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\""))))

(defun smartchr-custom-keybindings-objc ()
  (local-set-key (kbd "@") (smartchr '("@\"`!!'\"" "@"))))

(add-hook 'c-mode-common-hook 'smartchr-custom-keybindings)
(add-hook 'objc-mode-hook 'smartchr-custom-keybindings-objc)

(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

(require 'rfringe)

(require 'org2blog-autoloads)

(defvar no-easy-keys-minor-mode-map (make-keymap)
  "no-easy-keys-minor-mode keymap.")

(let ((f (lambda (m)
           `(lambda () (interactive)
              (message (concat "No! use " ,m " instead."))))))
  (dolist (l '(("<left>" . "C-b") ("<right>" . "C-f") ("<up>" . "C-p")
               ("<down>" . "C-n")
               ("<C-left>" . "M-f") ("<C-right>" . "M-b") ("<C-up>" . "M-{")
               ("<C-down>" . "M-}")
               ("<M-left>" . "M-f") ("<M-right>" . "M-b") ("<M-up>" . "M-{")
               ("<M-down>" . "M-}")
               ("<delete>" . "C-d") ("<C-delete>" . "M-d")
               ("<M-delete>" . "M-d") ("<next>" . "C-v") ("<C-next>" . "M-x <")
               ("<prior>" . "M-v") ("<C-prior>" . "M-x >")
               ("<home>" . "C-a") ("<C-home>" . "M->")
               ("<C-home>" . "M-<") ("<end>" . "C-e") ("<C-end>" . "M->")))
    (define-key no-easy-keys-minor-mode-map
      (read-kbd-macro (car l)) (funcall f (cdr l)))))

(define-minor-mode no-easy-keys-minor-mode
  "A minor mode that disables the arrow-keys, pg-up/down, delete and backspace." t " no-easy-keys"
  'no-easy-keys-minor-mode-map :global t)

(no-easy-keys-minor-mode nil)

(message "no easy keys")

;; (require 'scratch-log)
;; (setq sl-scratch-log-file "~/Dropbox/.scratch-log")
;; (setq sl-prev-scratch-string-file "~/Dropbox/.scratch-log-prev")

(require 'fuzzy-format)
(setq fuzzy-format-default-indent-tabs-mode nil)
(global-fuzzy-format-mode t)

(require 'htmlize)

(message "ace jump")

(require 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode)

(require 'clipboard-to-kill-ring)
(clipboard-to-kill-ring t)

(require 'workgroups)
(workgroups-mode 1)
(setq wg-prefix-key (kbd "C-x w"))

(defun write-string-to-file (string file)
  (interactive "sEnter the string: \nFFile to save to: ")
  (with-temp-buffer
    (insert string)
    (when (file-writable-p file)
      (write-region (point-min)
                    (point-max)
                    file))))

(message "string to file")

(defun load-wg ()
  (interactive)
  (let ((file "~/.emacs.d/wg"))
    (progn
      (unless (file-exists-p file)
        (write-string-to-file " " file))
      (wg-load file))))

(setq emacs-directory "~/.emacs.d/")
(setq backup-directory "~/.saves")

(require 'backups-mode)

(server-start)
;; sudo-ext requires server
(when (and (>= emacs-major-version 23) (eq window-system 'x))
  (require 'sudo-ext))

(require 'wc)

(autoload 'dictionary-search "dictionary"
  "Ask for a word and search it in all dictionaries" t)
(autoload 'dictionary-match-words "dictionary"
  "Ask for a word and search all matching words in the dictionaries" t)
(autoload 'dictionary-lookup-definition "dictionary"
  "Unconditionally lookup the word at point." t)
(autoload 'dictionary "dictionary"
  "Create a new dictionary buffer" t)
(autoload 'dictionary-mouse-popup-matching-words "dictionary"
  "Display entries matching the word at the cursor" t)
(autoload 'dictionary-popup-matching-words "dictionary"
  "Display entries matching the word at the point" t)
(autoload 'dictionary-tooltip-mode "dictionary"
  "Display tooltips for the current word" t)
(autoload 'global-dictionary-tooltip-mode "dictionary"
  "Enable/disable dictionary-tooltip-mode for all buffers" t)

;; (global-set-key "\C-hx" 'dictionary-search)
(global-set-key "\C-hx" 'dictionary-lookup-definition)
(global-set-key "\C-hz" 'dictionary-match-words)

;; these are utility commands for compiling c
(define-key mode-specific-map "c" 'compile)
(define-key mode-specific-map "x" 'recompile)
(define-key mode-specific-map "\C-z" 'shell-command)

(defun my-tabs-makefile-hook ()
  (setq indent-tabs-mode t))
(add-hook 'makefile-mode-hook 'my-tabs-makefile-hook)

(add-hook 'makefile-mode-hook
          (lambda()
            (setq show-trailing-whitespace t)))

(add-hook 'makefile-mode-hook
          (lambda()
            (auto-indent-minor-mode -1)))

(add-hook 'makefile-mode-hook 'whitespace-mode)

(setq-default indent-tabs-mode nil)


(require 'make-mode)
(define-key makefile-mode-map (kbd "RET") 'newline)

(setq compilation-auto-jump-to-first-error t)

(require 'valgrind)

(setq redisplay-dont-pause t)

(require 'fit-frame)
;; (require 'autofit-frame)
;; (add-hook 'after-make-frame-functions 'fit-frame)

(setq fit-frame-max-width 80)

(require 'frame-cmds)

;; (require 'ime-frame)

;; (defun recenter-frame ()
;;   (interactive)
;;   (if window-system
;;       (progn
;;         ;;        (fit-frame)
;;         (set-frame-size (selected-frame) 80 50)
;;         (frame-center))))

;; (recenter-frame)

(eval-after-load "man" '(require 'man-completion))

(require 'kindly-mode)
(setq kindly:use-auto-bookmark-p nil)
(setq kindly:font-face '(:family "Monaco" :height 125 :width condensed))


(require 'offlineimap)
(require 'mu4e)

;; (add-hook 'mu4e-main-mode-map-hook
;;           (lambda ()
;;             (define-key mu4e-main-mode-map "u" 'mu4e-update-index)))


;; use this for debugging
(setq debug-on-error nil)
;; (setq mu4e-html2text-command "w3m -dump -cols 80 -T text/html")
(setq mu4e-html2text-command "w3m -dump -T text/html")
;; (setq mu4e-get-mail-command "offlineimap")
(add-hook 'mu4e-headers-mode-hook '(lambda () (visual-line-mode -1)))
(add-hook 'mu4e-view-mode-hook '(lambda () (kindly-mode)))

(ignore-errors
  (load-file "~/.mufolders.el"))

(defun wolfram-alpha-query (term)
  (interactive (list (read-string "Ask Wolfram Alpha: " (word-at-point))))
  (require 'w3m-search)
  (w3m-browse-url (concat "http://m.wolframalpha.com/input/?i=" (w3m-search-escape-query-string
                                                                 term))))

(setq longlines-wrap-follows-window-size t)
(global-visual-line-mode)

(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(require 'go-mode-load)
(require 'go-autocomplete)

(message "********** successfully initialized **********")
