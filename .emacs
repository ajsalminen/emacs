;;; UNCOMMENT THIS TO DEBUG TROUBLE GETTING EMACS UP AND RUNNING.
(setq debug-on-error t)
(setq lang "en_US")

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

(add-to-list 'Info-default-directory-list "/usr/local/share/info")


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
(setq ecb-auto-activate t)
(setq ecb-tip-of-the-day nil)
(setq ecb-fix-window-size (quote width))
(setq ecb-compile-window-width (quote edit-window))
(setq ecb-major-modes-deactivate 'wl)
(setq ecb-major-modes-activate '(text-mode LaTeX-mode latex-mode))
(setq ecb-windows-width 25)
(ecb-activate)

;;(setq ecb-maximize-ecb-window-after-selection t)




;;(setq initial-scratch-message nil)

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))



(setq-default indent-tabs-mode nil)

;; PATH doesn't get inherited for OSX
(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/usr/local/texlive/p2009/bin/x86_64-apple-darwin10.2.0/:/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
  (push "/opt/local/bin" exec-path))

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

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(let ((path "~/.emacs.d"))
  (setq load-path (cons path load-path))
  (load "elisp-cache.el"))

(let ((nfsdir "~/.emacs.d/site-lisp")
      (cachedir "~/.elispcache"))
  (setq load-path (append load-path (list cachedir nfsdir)))

  (require 'elisp-cache)
  (setq elisp-cache-byte-compile-files t)

  (elisp-cache nfsdir cachedir)
  )


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

;;(require 'smart-tab)
(require 'tabkey2)
(require 'pabbrev)
(tabkey2-mode t)

(setq dabbrev-case-fold-search t)
;;(global-smart-tab-mode t)
(global-pabbrev-mode t)


;;(global-set-key (kbd "\t") 'smart-tab)
;;(global-set-key '[tab] 'smart-tab)
;;(global-set-key '[C-tab] 'pabbrev-expand-maybe)
(define-key pabbrev-mode-map (kbd "C-;") 'pabbrev-expand-maybe)

(put 'org-mode 'pabbrev-global-mode-excluded-modes t)
;;(add-to-list 'pabbrev-global-mode-excluded-modes 'org-mode)
;;(add-hook 'text-mode-hook 'pabbrev-mode)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;;(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;;(add-hook 'LaTeX-mode-hook 'pabbrev-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t)

(setq TeX-default-mode 'japanese-latex-mode)
(setq japanese-TeX-command-default "pTeX")
(setq japanese-LaTeX-command-default "pLaTeX")

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


(setq load-path (cons (expand-file-name "~/src/emacs/yatex1.74") load-path))

;; Just need this to generate Japanese PDFs
;;(setq auto-mode-alist
;;      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
;;(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(require 'yatex)


;;; platex と Skim
(setq tex-command "~/Library/TeXShop/bin/platex2pdf-utf8"
      dvi2-command "open -a Skim")
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
(defalias 'jlt 'yatex-mode)
(defalias 'ltm 'japanese-latex-mode)
(require 'ess-site)

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

;; Load the snippets
(yas/load-directory yas/root-directory)

(setq yas/trigger-key (kbd "C-TAB"))
(setq yas/next-field-key (kbd "TAB"))

(add-hook 'yas/minor-mode-on-hook
          '(lambda ()
             (define-key yas/minor-mode-map yas/trigger-key 'yas/expand)))


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
(setq recentf-max-saved-items 777)
(setq recentf-max-menu-items 250)
(require 'recentf-ext)
;;(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; show line number the cursor is on, in status bar (the mode line)
(require 'linum)
(line-number-mode 1)
(column-number-mode 1)
;; display line numbers in margin (fringe). Emacs 23 only.
(global-linum-mode 1)
(setq linum-format "%d ")

(transient-mark-mode 1)
(setq gc-cons-threshold (* 10 gc-cons-threshold))
(setq use-dialog-box nil)
(defalias 'message-box 'message)
(setq echo-keystrokes 0.1)
(setq history-length 1000)

(require 'icicles)
(icy-mode 1)
(global-set-key "\C-x\ \C-r" 'icicle-recent-file)
;;(setq icicle-TAB-completion-methods (quote (fuzzy basic vanilla)))


(add-to-list 'load-path "~/.emacs.d/magit")
(require 'magit)
(require 'magit-svn)
(defalias 'mg 'magit-status)
(require 'gist)

;; dictionary stuff
(require 'anything-config)
(require 'eijiro)
(setq eijiro-directory "~/Downloads/EDP-124/EIJIRO/") ; 英辞郎の辞書を置いているディレクトリ


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
(if (not (= emacs-major-version 23))
    (utf-translate-cjk-mode 1)
)


(require 'cursor-chg)


;;(byte-recompile-directory "~/.emacs.d" 0 t)

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


(run-at-time t 3600 'org-mobile-pullpush)


(setq org-default-notes-file (concat org-directory "memo.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Inbox") "** TODO %? %i %a ")
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
(global-set-key "\C-c\C-j" 'open-junk-file)
;; ここまで


;; iPhone stuff
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

(ffap-bindings)
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

(if (= emacs-major-version 23)
	(require 'w3m-ems)
  (require 'w3m))


(require 'w3m-extension)
(add-hook 'w3m-mode-hook 'w3m-link-numbering-mode)
(setq w3m-use-cookies t)
(autoload 'w3m-goto-url "w3m")
(defalias 'www 'w3m)
(defalias 'wws 'w3m-search-google-web-en)
(setq browse-url-browser-function 'w3m)

(require 'revbufs)

(require 'bookmark+)

;;(add-hook 'after-init-hook 'org-agenda-list)
;;(add-hook 'after-init-hook 'bookmark-bmenu-list)
(load-file (expand-file-name "~/.emacs.d/site-lisp/w3mkeymap.el"))
(bookmark-bmenu-list)

(require 'alpaca)
(add-to-list 'load-path "~/.emacs.d/twittering")
(require 'twittering-mode)
(setq twittering-use-master-password t)
(twittering-icon-mode t)
(defalias 'tt 'twittering-update-status-interactive)

(setq twittering-initial-timeline-spec-string
      '(":home"
        ":replies"
        ":search/emacs/"
        ":search/lift scala/"
        ":search/twitter/"
        "richstyles/foo"))

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
(defalias 'bl 'weblogger-start-entry)
(defalias 'bll 'weblogger-select-configuration)

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
(add-hook 'weblogger-entry-mode-hook 'turn-off-auto-fill)
(add-hook 'weblogger-entry-mode-hook 'ispell-minor-mode)
(add-hook 'weblogger-entry-mode-hook 'flyspell-mode)

(require 'textile-minor-mode)

(add-hook 'weblogger-entry-mode-hook 'textile-minor-mode)

(defun publish-post ()
  (interactive)
  (textile-to-html-buffer-respect-weblogger)
  (weblogger-publish-entry)
  )

(define-key weblogger-entry-mode-map "\C-x\C-s" 'publish-post)

;; wl
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(add-hook 'wl-init-hook 'ecb-deactivate)
(add-hook 'wl-exit-hook 'ecb-activate)
(require 'mime-w3m)
(defalias 'wle 'wl-exit)

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
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-bufferes-re "*[^*]+*")

(require 'screen-lines)
(add-hook 'text-mode-hook 'turn-on-screen-lines-mode)