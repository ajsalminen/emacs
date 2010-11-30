;;; UNCOMMENT THIS TO DEBUG TROUBLE GETTING EMACS UP AND RUNNING.
(setq debug-on-error t)
(setq eval-expression-debug-on-error t)
(setq lang "en_US")

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(defun kill-ci-buffer ()
       (interactive)
       (switch-to-buffer " *Compiler Input*")
       (set-buffer-modified-p nil)
       (kill-buffer " *Compiler Input*"))

(kill-ci-buffer)

(setq font-lock-verbose nil)
(setq byte-compile-verbose nil)
(setq bcc-cache-directory "~/.elispcache")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


;; All my custom settings that differ and/or can't be under version control
(setq custom-file "~/custom.el")
(load custom-file 'noerror)
(setq blog-file "~/blogs.el")
(load blog-file 'noerror)

(setq Info-directory-list
                     '("/usr/local/share/info" "~/info" "/usr/share/info" "/usr/local/info"))

;;; This was installed by package-install.el.
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
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("~/projects/ghub" "Projects"))))
 '(inhibit-startup-screen t)
 '(inhibit-startup-message t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-file "~/.emacs.d/cedet-1.0/common/cedet.el")
(global-ede-mode 1)             ; Enable the Project management system
(semantic-load-enable-code-helpers) ; Enable prototype help and smart completion
(global-srecode-minor-mode 1)       ; Enable template insertion menu

(add-to-list 'load-path "~/.emacs.d/ecb-2.40")
(require 'ecb)
(semantic-load-enable-minimum-features)
(setq ecb-layout-name "left8")
;;(setq ecb-auto-activate t)
(setq ecb-tip-of-the-day nil)
(setq ecb-fix-window-size (quote width))
(setq ecb-compile-window-width (quote edit-window))
(setq ecb-major-modes-deactivate '(wl-mode tramp-mode))
;;(setq ecb-major-modes-activate '(text-mode LaTeX-mode latex-mode))
(setq ecb-windows-width 25)

;;(setq ecb-maximize-ecb-window-after-selection t)
;;(ecb-activate)

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

;; On Mac OS X, Emacs launched from a bundle
;; needs paths to be set explicitly
(add-to-list 'exec-path (getenv "PATH"))

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

(add-to-list 'load-path "~/.emacs.d/color-theme")
(require 'color-theme)
(require 'color-theme-inkpot)
(require 'manoj-colors)
(require 'color-theme-sunburst)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-manoj-gnus)
     (color-theme-inkpot)))

;; Scala configs
(let ((path "~/.emacs.d/scala"))
  (setq load-path (cons path load-path))
  (load "scala-mode-auto.el"))
(require 'scala-mode-auto)

(add-to-list 'load-path "~/.emacs.d/ensime_2.8.1.RC3-0.3.7/elisp/")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)



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

(set-frame-size-according-to-resolution)

(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)))


;;(arrange-frame 160 50 2 22)

(setq auto-save-timeout 15)
(defalias 'yes-or-no-p 'y-or-n-p)




;; Hard Code the window dimensions, that's how we roll
(set-frame-position (selected-frame) 45 0)
(add-to-list 'default-frame-alist (cons 'width 150))
(add-to-list 'default-frame-alist (cons 'height 47))


(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

(add-to-list 'load-path "~/.emacs.d/auctex-11.86")
(load "auctex.el" nil t t)
(add-to-list 'load-path "~/.emacs.d/auctex-11.86/preview")
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

(add-to-list 'load-path "~/.emacs.d/reftex-4.34a/lisp/")
(require 'reftex)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;;(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;;(add-hook 'LaTeX-mode-hook 'pabbrev-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t)

(setq TeX-default-mode 'japanese-latex-mode)

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



(add-to-list 'load-path "~/.emacs.d/yatex1.74")

;; Just need this to generate Japanese PDFs
;;(setq auto-mode-alist
;;      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
;;(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(require 'yatex)
(setq YaTeX-fill-column nil)

;;; platex と Skim
;; (setq tex-command "~/Library/TeXShop/bin/platex2pdf-utf8"
;;       dvi2-command "open -a Skim")
;;; pdflatex と Skim
;;(setq tex-command "pdflatex -synctex=1"
;;     dvi2-command "open -a Skim")
;;; platex と TeXShop
;;(setq tex-command "~/Library/TeXShop/bin/platex2pdf-euc"
;;      dvi2-command "open -a TeXShop")
;;; pdflatex と TeXShop
;;(setq tex-command "pdflatex"
;;      dvi2-command "open -a TeXShop")

;; Alias the two major modes for fast switching
(defalias 'jl 'yatex-mode)
(defalias 'el 'japanese-latex-mode)

(add-hook 'TeX-mode-hook (lambda()
                             (add-to-list 'TeX-command-list '("m" "latexmk -pv -pdf %s" TeX-run-TeX nil t))
                             (setq TeX-save-query nil)
                             (setq TeX-command-default "m")
                             (setq japanese-TeX-command-default "m")
                             (setq TeX-show-compilation t)))

;;(load "~/.emacs.d/ess-5.11/lisp/ess-site.el")
(add-to-list 'load-path "~/.emacs.d/ess-5.11/lisp")
(setq ess-etc-directory "~/.emacs.d/ess-5.11/etc")


(require 'ess-site)
(require 'ess-eldoc)

;; Reload .emacs file by typing: Mx reload.
(defun reload () "Reloads .emacs interactively."
  (interactive)
  (load "~/.emacs"))

(setq default-directory "~/projects/ghub")

;; yasnippet
(add-to-list 'load-path
             "~/.emacs.d/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")
;; Develop and keep personal snippets under ~/emacs.d/mysnippets
(setq yas/root-directory "~/.emacs.d/mysnippets")

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

;; get text from pdf instead of viewer
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . no-pdf))

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

;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
;;(set-frame-parameter (selected-frame) 'alpha '(85 50))
;;(add-to-list 'default-frame-alist '(alpha 85 50))

(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(85 50))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

(require 'maxframe)

;; just the frame thanks
(tool-bar-mode -1)
(scroll-bar-mode -1)

(define-key global-map (kbd "RET") 'newline-and-indent)

;; offset for dock on left side
(setq mf-offset-x 47)
;;(add-hook 'window-setup-hook 'maximize-frame t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Mac AntiAlias
(setq mac-allow-anti-aliasing t)

;;Font settings for CJK fonts on Cocoa Emacs
(when (and (= emacs-major-version 23) (eq window-system 'mac))
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
  )

;; recentf stuff
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 10000)
(setq recentf-max-menu-items 10000)
(require 'recentf-ext)
;;(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(transient-mark-mode 1)
(setq gc-cons-threshold (* 10 gc-cons-threshold))
(setq use-dialog-box nil)
(defalias 'message-box 'message)
(setq echo-keystrokes 0.1)
(setq history-length 1000)

;; wl
(add-to-list 'load-path "~/.emacs.d/apel")
(add-to-list 'load-path "~/.emacs.d/flim")
(add-to-list 'load-path "~/.emacs.d/semi")
(add-to-list 'load-path "~/.emacs.d/wanderlust/elmo")
(add-to-list 'load-path "~/.emacs.d/wanderlust/utils")
(add-to-list 'load-path "~/.emacs.d/wanderlust/wl")

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(add-hook 'wl-init-hook 'ecb-deactivate)
;;(add-hook 'wl-exit-hook 'ecb-activate)
(require 'mime-w3m)
(defalias 'wle 'wl-exit)

(add-to-list 'load-path "~/.emacs.d/bbdb-2.35")
(add-to-list 'load-path "~/.emacs.d/bbdb-2.35/lisp")
(require 'bbdb)
(bbdb-initialize)

(setq
    bbdb-offer-save 1                        ;; 1 means save-without-asking
    bbdb-use-pop-up t                        ;; allow popups for addresses
    bbdb-electric-p t                        ;; be disposable with SPC
    bbdb-popup-target-lines  1               ;; very small
    bbdb-dwim-net-address-allow-redundancy t ;; always use full name
    bbdb-quiet-about-name-mismatches 2       ;; show name-mismatches 2 secs
    bbdb-always-add-address t                ;; add new addresses to existing...
                                             ;; ...contacts automatically
    bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx
    bbdb-completion-type nil                 ;; complete on anything
    bbdb-complete-name-allow-cycling t       ;; cycle through matches
                                             ;; this only works partially
    bbbd-message-caching-enabled t           ;; be fast
    bbdb-use-alternate-names t               ;; use AKA
    bbdb-elided-display t                    ;; single-line addresses
    ;; auto-create addresses from mail
    bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook
    bbdb-ignore-some-messages-alist ;; don't ask about fake addresses
    ;; NOTE: there can be only one entry per header (such as To, From)
    ;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html
    '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|facebookmail\\|twitter")))


(require 'bbdb-wl)
(bbdb-wl-setup)

(require 'wl-draft)
(add-hook 'wl-draft-mode-hook
          (lambda ()
            (define-key wl-draft-mode-map (kbd "<tab>") 'bbdb-complete-name)))

(require 'dired+)
(define-key dired-mode-map "W" 'diredp-mark-region-files)

(require 'icicles)
(icy-mode 1)
(global-set-key "\C-x\ \C-r" 'icicle-recent-file)
;;(setq icicle-TAB-completion-methods (quote (fuzzy basic vanilla)))


(add-to-list 'load-path "~/.emacs.d/magit")
(require 'magit)
(require 'magit-svn)
(defalias 'mg 'magit-status)
(require 'gist)
(setq gist-use-curl t)

;; dictionary stuff
;; (require 'anything-config)
(require 'anything-startup)
(global-set-key (kbd "C-z") 'anything)
(setq anything-idle-delay 0.3)
(setq anything-input-idle-delay 0.2)
(setq anything-candidate-number-limit 100)

;; (require 'anything-match-plugin)
(require 'eijiro)
(setq eijiro-directory "~/Downloads/EDP-124/EIJIRO/") ; 英辞郎の辞書を置いているディレクトリ

(setq anything-sources
      '(anything-c-source-recentf
        anything-c-source-info-pages
        anything-c-source-info-elisp
        anything-c-source-buffers
        anything-c-source-file-name-history
        anything-c-source-locate
        anything-c-source-occur))


;; ----- sdicが呼ばれたときの設定
(autoload 'sdic-describe-word "sdic" "search word" t nil)
;;(setq sdicf-array-command "/usr/local/bin/sary")
;;     (setq sdic-eiwa-dictionary-list
;;           '((sdicf-client "/usr/local/share/dict/eijirou.sdic" (strategy array))))
;;    (setq sdic-waei-dictionary-list
;;          '((sdicf-client "/usr/local/share/dict/gene.sdic" (strategy array))))

(eval-after-load "sdic"
  '(progn
     ;; saryのコマンドをセットする
     (setq sdicf-array-command "/usr/local/bin/sary")
     ;; sdicファイルのある位置を設定し、arrayコマンドを使用するよう設定(現在のところ英和のみ)
;;;     (setq sdic-eiwa-dictionary-list
;;;           '((sdicf-client "/usr/local/share/dict/eijirou.sdic" (strategy array))))
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
(global-set-key "\C-cd" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cD" 'sdic-describe-word-at-point)


;; highlight current line
(require 'highline)
(global-hl-line-mode 1)
;; To customize the background color
(set-face-background 'hl-line "#222") ;; Emacs 22 Only

(require 'hl-line+)
(toggle-hl-line-when-idle 1)

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

(iswitchb-mode 1)

(file-cache-add-directory "~/projects/ghub")

;; File Name Cache
;; http://www.emacswiki.org/emacs/FileNameCache
(eval-after-load
    "filecache"
  '(progn
     (message "Loading file cache...")
     ;;     (file-cache-add-directory-using-find "~/projects")
     (file-cache-add-directory-list load-path)))


;; Japanese input-related settings
;; So I know if input method is active
 (prefer-coding-system 'utf-8)
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
(when
    (featurep 'carbon-emacs-package)
  (defun toggle-max-window ()
    (interactive)
    (if (frame-parameter nil 'fullscreen)
        (set-frame-parameter nil 'fullscreen nil)
      (set-frame-parameter nil 'fullscreen 'fullboth)))
  (global-set-key "\M-\r" 'toggle-max-window))


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



;; org-modeを利用するための設定
(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp")
(add-to-list 'load-path "~/.emacs.d/remember-2.0")
(require 'org-install)
(require 'remember)

(require 'org-clock)
(require 'org-timer)
(require 'org-habit)

(setq org-timer-default-timer 25)

(add-hook 'org-clock-in-hook '(lambda ()
                                (if (not org-timer-current-timer)
                                    (org-timer-set-timer '(16)))))

(setq system-time-locale "C")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook 'turn-on-font-lock) ; Org buffers only
;;(add-hook 'org-mode-hook 'smart-tab-mode-off)

(setq org-startup-truncated nil)
(setq org-return-follows-link t)

;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-agenda-skip-unavailable-files t)

(defun org-mobile-pullpush nil nil (org-mobile-pull)
  (org-mobile-push))

(require 'deferred)

(defun async-org-mobile-pullpussh
  (deferred:call(org-mobile-pullpush)))

(run-at-time t 3600 'async-org-mobile-pullpush)


(setq org-default-notes-file (concat org-directory "memo.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Inbox") "** TODO %? %i %a %T")
        ("r" "Research" entry (file+headline "~/org/diss.org" "Research") "** %? %i %a %T")
        ("w" "Writing" entry (file+headline "~/org/write.org" "Dev") "** TODO %? :write%a %T")
        ("d" "Dev" entry (file+headline "~/org/dev.org" "Dev") "** TODO %? :dev%i %a %T")))

;;(setq org-refile-targets (quote ((org-agenda-files :regexp . "*"))))
(setq org-refile-targets (quote ((org-agenda-files :level . 1))))
(setq org-agenda-files (list "~/org"))

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(setq org-timer-timer-is-countdown t)
;; ここまで

;; 思いついたコードやメモコードを書いて保存できるようにするための設定
;; (auto-install-from-emacswiki "open-junk-file.el")
(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%Y%m%d_%H%M%s_junk.")
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
;;     '("/usr/include" "/usr/local/include"))
;; 新規ファイルの場合には確認する
(setq ffap-newfile-prompt t)
;; ffap-kpathsea-expand-path で展開するパスの深さ
(setq ffap-kpathsea-depth 5)

(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$"  (".hh" ".h"))
        ("\\.hh$"  (".cc" ".C"))

        ("\\.c$"   (".h"))
        ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.C$"   (".H"  ".hh" ".h"))
        ("\\.H$"   (".C"  ".CC"))

        ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH$"  (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))

        ("\\.hpp$" (".cpp" ".c"))))
(add-hook 'objc-mode-hook
          (lambda ()
            (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)
            ))

;; load-path を通す
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp/")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; ロード
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d///ac-dict")
(ac-config-default)
(require 'ac-company)
;; 対象の全てで補完を有効にする
(global-auto-complete-mode t)
;; ac-company で company-xcode を有効にする
(ac-company-define-source ac-source-company-xcode company-xcode)
;; objc-mode で補完候補を設定
(setq ac-modes (append ac-modes '(objc-mode)))
;; hook
(add-hook 'objc-mode-hook
          (lambda ()
            (define-key objc-mode-map (kbd "\t") 'ac-complete)
            ;; XCode を利用した補完を有効にする
            (push 'ac-source-company-xcode ac-sources)
            ;; C++ のキーワード補完をする Objective-C++ を利用する人だけ設定してください
            (push 'ac-source-c++-keywords ac-sources)
            ))
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

;; etags-table の機能を有効にする
(require 'etags-table)
(add-to-list  'etags-table-alist
              '("\\.[mh]$" "~/.emacs.d/share/tags/objc.TAGS"))
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


;; end of iphone-related settings

;; Common copying and pasting functions
(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point)))
        (end (progn (forward-word arg) (point))))
    (copy-region-as-kill beg end)))

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
  (let ((beg (progn (backward-paragraph 1) (point)))
        (end (progn (forward-paragraph arg) (point))))
    (copy-region-as-kill beg end)))

(global-set-key (kbd "C-c p") (quote copy-paragraph))

(defun copy-string (&optional arg)
  "Copy a sequence of string into kill-ring"
  (interactive)
  (setq onPoint (point))
  (let ((beg (progn (re-search-backward "[\t ]" (line-beginning-position) 3 1)
                    (if (looking-at "[\t ]") (+ (point) 1) (point))))
        (end (progn (goto-char onPoint) (re-search-forward "[\t ]" (line-end-position) 3 1)
                    (if (looking-back "[\t ]") (- (point) 1) (point) ) )))
    (copy-region-as-kill beg end)))

(global-set-key (kbd "C-c s") (quote copy-string))
(global-set-key (kbd "C-c r") 'ispell-word)

(require 'basic-edit-toolkit)

(require 'w3m-load)
(require 'w3m-extension)
(setq w3m-key-binding 'lynx)
(w3m-link-numbering-mode 1)
;;(add-hook 'w3m-mode-hook 'w3m-link-numbering-mode)
(setq w3m-use-cookies t)
(setq w3m-verbose t)
(setq w3m-message-silent nil)
(setq url-show-status nil) ;;don't need to know how you're doing url-http
;;(defun w3m-message (&rest args)) ;;w3m status messages are annoying and useless
(autoload 'w3m-goto-url "w3m")
(defalias 'www 'w3m)
(defalias 'wws 'w3m-search-google-web-en)
(defalias 'wwe 'w3m-search-emacswiki)
(defalias 'wwso 'w3m-search-stack-overflow)
(defalias 'wwo 'w3m-view-url-with-external-browser)
(setq browse-url-browser-function 'w3m)
;;(load-file (expand-file-name "~/.emacs.d/site-lisp/w3mkeymap.el"))
;;(add-hook 'w3m-mode-hook '(lambda () (use-local-map dka-w3m-map)))

(defun w3m-search-stack-overflow ()
  "search stack overflow"
  (interactive)
  (w3m-search-advance "http://stackoverflow.com/search?q=" "Stack Overflow" 'utf-8))

(require 'revbufs)

(require 'bookmark+)

;;(add-hook 'after-init-hook 'org-agenda-list)
;;(add-hook 'after-init-hook 'bookmark-bmenu-list)

(bookmark-bmenu-list)

(require 'alpaca)
(add-to-list 'load-path "~/.emacs.d/twittering")
(require 'twittering-mode)
(setq twittering-use-master-password t)
(setq twittering-url-show-status nil)
(twittering-icon-mode t)

(if (and (boundp 'jmp-api-key) (boundp 'jmp-user-name))
    (progn (defvar jmp-api-url
             (format "http://api.j.mp/shorten?version=2.0.1&login=%s&apiKey=%s&format=text&longUrl=" jmp-user-name jmp-api-key))
           (add-to-list 'twittering-tinyurl-services-map
                        `(jmp . ,jmp-api-url))
           ;; api key and other information in custom.el
           (setq twittering-tinyurl-service 'jmp)))

(define-key twittering-mode-map (kbd "<S-tab>") 'twittering-goto-previous-thing)

(add-hook 'twittering-edit-mode-hook (lambda () (ispell-minor-mode) (flyspell-mode)))

(defalias 'tt 'twittering-update-status-interactive)

(setq twittering-initial-timeline-spec-string
      '(":home"
        ":replies"
        ":favorites"
        ":direct_messages"
        ":search/emacs/"
        ":search/lift scala/"
        ":search/twitter/"
        "richstyles/foo"))

(define-key twittering-edit-mode-map "\M-s" 'twittering-edit-replace-at-point)
(define-key twittering-edit-mode-map "\M-q" 'twittering-edit-cancel-status)

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


;; Backups
(require 'backup-dir)

;; localize it for safety.
(make-variable-buffer-local 'backup-inhibited)

(setq bkup-backup-directory-info
      '((t "~/.saves" ok-create full-path prepend-name)))

(setq backup-by-copying t               ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.saves")) ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 2
      version-control t)                ; use versioned backups

(setq backup-directory-alist
      `((".*" . ,"~/.saves")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/.saves" t)))

(defun force-backup-of-buffer ()
  (setq buffer-backed-up nil))

(add-hook 'before-save-hook  'force-backup-of-buffer)

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region (start end)
  (interactive "r")
  (let ((fill-column (point-max)))
    (fill-region start end nil)))


(require 'weblogger)
(require 'zencoding-mode)

(defalias 'bl 'weblogger-start-entry)
(defalias 'bll 'weblogger-select-configuration)

(add-hook 'weblogger-entry-mode-hook 'turn-off-auto-fill)
(add-hook 'weblogger-entry-mode-hook 'ispell-minor-mode)
(add-hook 'weblogger-entry-mode-hook 'flyspell-mode)

(require 'textile-minor-mode)

;;(add-hook 'weblogger-entry-mode-hook 'textile-minor-mode)

(defun publish-post ()
  (interactive)
  (textile-to-html-buffer-respect-weblogger)
  (weblogger-publish-entry)
  )

(define-key weblogger-entry-mode-map "\C-x\C-s" 'publish-post)

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/site-lisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/org/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-bufferes-re "*[^*]+*")

(require 'screen-lines)
(add-hook 'text-mode-hook 'turn-on-screen-lines-mode)

(require 'summarye)

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
  (move-to-window-line (/ (count-screen-lines) 2)))


(global-set-key (kbd "C-x x") 'point-to-top)
(global-set-key (kbd "C-x c") 'point-to-bottom)
(global-set-key (kbd "C-x g") 'point-to-middle)

(defun my-ido-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map "\C-k"    'ido-next-match))

(add-hook 'ido-setup-hook 'my-ido-keys)
(defalias 'qrr 'query-replace-regexp)
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)

(defalias 'hb 'hide-body)
(defalias 'sb 'show-all)
(defalias 'he 'hide-entry)
(defalias 'se 'show-entry)

(require 'enclose)
(enclose-remove-encloser "'")
;; (add-hook 'LaTeX-mode-hook 'enclose-mode)
(add-hook 'weblogger-entry-mode 'enclose-mode)

(require 'paredit)

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

(add-to-list 'load-path "~/.emacs.d/rhtml")
(require 'rhtml-mode)
(require 'ruby-electric)

(require 'sense-region)
(sense-region-on)

(require 'dired-sort-map)

(require 'breadcrumb)
(global-set-key [(control tab)] 'bc-set) ;; Shift-SPACE for set bookmark
(global-set-key [(control c)(u)] 'bc-previous)       ;; M-j for jump to previous
(global-set-key [(control c)(i)] 'bc-next) ;; Shift-M-j for jump to next
(global-set-key [(meta up)] 'bc-local-previous) ;; M-up-arrow for local previous
(global-set-key [(meta down)] 'bc-local-next) ;; M-down-arrow for local next
(global-set-key [(control c)(n)] 'bc-goto-current) ;; C-c j for jump to current bookmark
(global-set-key [(control c)(m)] 'bc-list) ;; C-x M-j for the bookmark menu list

(setq version-control t)

(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

(require 'goto-chg)
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)

(require 'midnight)

(global-set-key (kbd "C-x 9") 'windmove-right)
(global-set-key (kbd "C-x 7") 'windmove-left)


(load "~/.emacs.d/haskell-mode-2.8.0/haskell-site-file.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)


(require 'igrep)
(setq igrep-options "-ir")
(igrep-define lgrep (igrep-use-zgrep nil) (igrep-regex-option "-n -0u8"))
(igrep-find-define lgrep (igrep-use-zgrep nil) (igrep-regex-option "-n -0u8"))

(require 'grep-a-lot)
(grep-a-lot-setup-keys)
(grep-a-lot-advise igrep)

(require 'grep-edit)

(set-face-attribute 'default nil
                    :family "monaco"
                    :height 130)

(set-fontset-font "fontset-default"
                 'katakana-jisx0201
                 '("ヒラギノ丸ゴ pro w4*" . "jisx0201.*"))

(set-fontset-font "fontset-default"
                 'japanese-jisx0208
                 '("ヒラギノ丸ゴ pro w4*" . "jisx0208.*"))


(add-to-list 'load-path "~/.emacs.d/elib-1.0")
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.0.1/lisp")

(require 'jde)
(autoload 'jde-mode "jde" "JDE mode." t)
(add-to-list 'auto-mode-alist '("\\java\\'" . jde-mode))

(load-file "~/.emacs.d/site-lisp/mvn.el")

(require 'undo-tree)
(global-undo-tree-mode)

(bbdb-insinuate-message)
(add-hook 'mail-setup-hook 'bbdb-insinuate-sendmail)

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

(define-key isearch-mode-map "\M-e" 'isearch-yank-symbol)

(require 'switch-window)
(setq switch-window-increase 50)
(setq switch-window-timeout 3)

(require 'sr-speedbar)

(require 'ange-ftp)
;;(add-hook 'ange-ftp-process-startup-hook 'ecb-deactivate)
(require 'tramp)

(setq-default line-spacing 2)

(require 'cssh)

(require 'list-processes+)
(defalias 'lp 'list-processes+)

(require 'yaoddmuse)
(setq yaoddmuse-username "baron")
(yaoddmuse-update-pagename t)

(autoload 'shell-toggle "shell-toggle"
  "Toggles between the *shell* buffer and whatever buffer you are editing."
  t)
(autoload 'shell-toggle-cd "shell-toggle"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)

(defalias 'sh 'shell-toggle-cd)
(global-set-key (kbd "C-'") 'smex)
(require 'lispxmp)

;; needed since OSX 's "ls" command is different from unix
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

(defalias 'qrr 'query-replace-regexp)

(require 'header2)
(add-hook 'emacs-lisp-mode-hook 'auto-make-header)

(require 're-builder+)

(defun reb-query-replace (to-string)
      "Replace current RE from point with `query-replace-regexp'."
      (interactive
       (progn (barf-if-buffer-read-only)
              (list (query-replace-read-to (reb-target-binding reb-regexp)
                                           "Query replace"  t))))
      (with-current-buffer reb-target-buffer
        (query-replace-regexp (reb-target-binding reb-regexp) to-string)))

(define-key reb-mode-map "\C-g" 'reb-quit)
(define-key reb-mode-map "\C-w" 'reb-copy)
(define-key reb-mode-map "\C-s" 'reb-next-match)
(define-key reb-mode-map "\C-r" 'reb-prev-match)
(define-key reb-mode-map "\M-%" 'reb-query-replace)

(defalias 'reb 're-builder)

(message "********** successfully initialized **********")
