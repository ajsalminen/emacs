;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


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
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq initial-scratch-message nil)

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
(require 'color-theme-sunburst)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
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

(load-file "~/.emacs.d/cedet-1.0/common/cedet.el")
(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
(global-srecode-minor-mode 1)            ; Enable template insertion menu

(add-to-list 'load-path "~/.emacs.d/ecb-2.40")
(require 'ecb)
(semantic-load-enable-minimum-features)
(setq ecb-layout-name "left8")
(setq ecb-auto-activate t)
(setq ecb-tip-of-the-day nil)
(setq ecb-fix-window-size (quote width))
(setq ecb-compile-window-width (quote edit-window))
;;(setq ecb-maximize-ecb-window-after-selection t)

(add-to-list 'load-path "~/.emacs.d/auctex-11.86")
(load "auctex.el" nil t t)
(add-to-list 'load-path "~/.emacs.d/auctex-11.86/preview")
(load "preview-latex.el" nil t t)


(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;;(setq reftex-plug-into-AUCTeX t)

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

;; Reload .emacs file by typing: Mx reload.
(defun reload () "Reloads .emacs interactively."
  (interactive)
  (load "~/.emacs"))

(setq default-directory "~/projects/ghub")

(require 'smart-tab)
(global-smart-tab-mode t)

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
(setq recentf-max-menu-items 25)
;;(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(require 'icicles)
(icy-mode 1)
(global-set-key "\C-x\ \C-r" 'icicle-recent-file)

(add-to-list 'load-path "~/.emacs.d/magit")
(require 'magit)
(require 'magit-svn) 
(require 'gist)

;; highlight current line
(global-hl-line-mode 1)
;; To customize the background color
(set-face-background 'hl-line "#000")  ;; Emacs 22 Only

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


;; Hard Code the window dimensions, that's how we roll
(set-frame-position (selected-frame) 45 0)
(add-to-list 'default-frame-alist (cons 'width 150))
(add-to-list 'default-frame-alist (cons 'height 47))

(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

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

(server-start)