;;; UNCOMMENT THIS TO DEBUG TROUBLE GETTING EMACS UP AND RUNNING.
(setq debug-on-error t)

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
(ecb-activate)

;;(setq ecb-maximize-ecb-window-after-selection t)




;(setq initial-scratch-message nil)

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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


(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;;(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
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

(require 'smart-tab)
(global-smart-tab-mode t)
(global-set-key '[C-tab] 'dabbrev-expand)

(require 'yasnippet) ;; not yasnippet-bundle


;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 85 50))

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

;; offset for dock on left side
(setq mf-offset-x 47)
;;(add-hook 'window-setup-hook 'maximize-frame t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Mac AntiAlias
(setq mac-allow-anti-aliasing t)

;;Font settings for CJK fonts on Cocoa Emacs
(when (= emacs-major-version 23)
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
(setq recentf-max-menu-items 250)
;;(global-set-key "\C-x\ \C-r" 'recentf-open-files)

                                        ; show line number the cursor is on, in status bar (the mode line)
(require 'linum)
                                        ;(line-number-mode 1)
                                        ; display line numbers in margin (fringe). Emacs 23 only.
                                        ;(global-linum-mode 1) ; always show line numbers
(setq linum-format "%d ")

(require 'icicles)
(icy-mode 1)
(global-set-key "\C-x\ \C-r" 'icicle-recent-file)
(setq icicle-TAB-completion-methods (quote (fuzzy basic vanilla)))


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
;(setq sdicf-array-command "/usr/local/bin/sary")
;     (setq sdic-eiwa-dictionary-list
;           '((sdicf-client "/usr/local/share/dict/eijirou.sdic" (strategy array))))
;    (setq sdic-waei-dictionary-list
;          '((sdicf-client "/usr/local/share/dict/gene.sdic" (strategy array))))

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
(global-hl-line-mode 1)
;; To customize the background color
(set-face-background 'hl-line "#222") ;; Emacs 22 Only

(require 'hl-line+)
(toggle-hl-line-when-idle 1)


;; Japanese input-related settings
;; So I know if input method is active

(require 'cursor-chg)

(set-language-environment 'Japanese)
(set-terminal-coding-system 'utf-8)
(defun setup-japanese-input ()
  "Set up my Japanese input environment."
  (if (equal current-language-environment "Japanese")
      (setq default-input-method "japanese")))
(add-hook 'set-language-environment-hook 'setup-japanese-input)

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

(setq system-time-locale "C")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook 'turn-on-font-lock) ; Org buffers only

(setq org-startup-truncated nil)
(setq org-return-follows-link t)

;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/inbox.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-mobile-files (quote ("~/org")))
(setq org-agenda-skip-unavailable-files t)

(defun org-mobile-pullpush nil nil (org-mobile-pull)
  (org-mobile-push))


(run-at-time t 900 'org-mobile-pullpush)


(setq org-default-notes-file (concat org-directory "memo.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/memo.org" "Inbox") "** TODO %? %i %a ")
        ("b" "Bug" entry (file+headline "~/org/memo.org" "Inbox") "** TODO %? :bug: %i %a %T")
        ("i" "Idea" entry (file+headline "~/org/memo.org" "New Ideas") "** %? %i %a %T")))

;; 前後の可視であるリンクに飛ぶ。
(defun org-next-visible-link ()
  "Move forward to the next link.
If the link is in hidden text, expose it."
  (interactive)
  (when (and org-link-search-failed (eq this-command last-command))
    (goto-char (point-min))
    (message "Link search wrapped back to beginning of buffer"))
  (setq org-link-search-failed nil)
  (let* ((pos (point))
         (ct (org-context))
         (a (assoc :link ct))
         srch)
    (if a (goto-char (nth 2 a)))
    (while (and (setq srch (re-search-forward org-any-link-re nil t))
                (goto-char (match-beginning 0))
                (prog1 (not (eq (org-invisible-p) 'org-link))
                  (goto-char (match-end 0)))))
    (if srch
        (goto-char (match-beginning 0))
      (goto-char pos)
      (setq org-link-search-failed t)
      (error "No further link found"))))

(defun org-previous-visible-link ()
  "Move backward to the previous link.
If the link is in hidden text, expose it."
  (interactive)
  (when (and org-link-search-failed (eq this-command last-command))
    (goto-char (point-max))
    (message "Link search wrapped back to end of buffer"))
  (setq org-link-search-failed nil)
  (let* ((pos (point))
         (ct (org-context))
         (a (assoc :link ct))
         srch)
    (if a (goto-char (nth 1 a)))
    (while (and (setq srch (re-search-backward org-any-link-re nil t))
                (goto-char (match-beginning 0))
                (not (eq (org-invisible-p) 'org-link))))
    (if srch
        (goto-char (match-beginning 0))
      (goto-char pos)
      (setq org-link-search-failed t)
      (error "No further link found"))))

(add-hook 'org-agenda-mode-hook
          '(lambda () (define-key org-mode-map "\M-n" 'org-next-visible-link)
             (define-key org-mode-map "\M-p" 'org-previous-visible-link)))

;; ここまで

;; 思いついたコードやメモコードを書いて保存できるようにするための設定
;; (auto-install-from-emacswiki "open-junk-file.el")
(require 'open-junk-file)
(global-set-key "\C-c\C-j" 'open-junk-file)
;; ここまで

;; コードリーディングの時に役立つようなメモの方法

(defvar org-code-reading-software-name nil)
;; <メモの補完場所>/code-reading.org に記録する
(defvar org-code-reading-file "code-reading.org")
(defun org-code-reading-read-software-name ()
  (set (make-local-variable 'org-code-reading-software-name)
       (read-string "Code Reading Software: "
                    (or org-code-reading-software-name
                        (file-name-nondirectory
                         (buffer-file-name))))))

(defun org-code-reading-get-prefix (lang)
  (concat "[" lang "]"
          "[" (org-code-reading-read-software-name) "]"))
(defun org-remember-code-reading ()
  (interactive)
  (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
         (org-remember-templates
          `(("CodeReading" ?r "** %(identity prefix)%?\n   \n   %a\n   %t"
             ,org-code-reading-file "Memo"))))
    (org-remember)))

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

(require 'basic-edit-toolkit)
(if (= emacs-major-version 23)
	(require 'w3m-ems)
  (require 'w3m)
  (require 'w3m-extension)
(add-hook 'w3m-mode-hook 'w3m-link-numbering-mode))
(setq w3m-use-cookies t)
(defalias 'www 'w3m)



(require 'revbufs)

;(require 'bookmark+)

;(add-hook 'after-init-hook 'org-agenda-list)
;(add-hook 'after-init-hook 'bookmark-bmenu-list)
(load-file (expand-file-name "~/.emacs.d/site-lisp/w3mkeymap.el"))
(bookmark-bmenu-list)

(add-to-list 'load-path "~/.emacs.d/twittering")
(require 'twittering-mode)
