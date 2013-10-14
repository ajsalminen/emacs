;; workaround for cocoa emacs byte-compiling
(eval-when-compile (require 'cl))

(when (eq window-system 'ns)
  (setq warning-suppress-types nil)
  (setq ispell-program-name "/usr/local/bin/aspell"))

;; (add-to-list 'exec-path (getenv "PATH"))
;; (push "/usr/local/bin/scala/bin/" exec-path)
;; (push "/usr/local/bin/" exec-path)
;; (push "/usr/bin/" exec-path)
;; Setup PATH

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

  ;; fix fonts
  (defun fix-mac-fonts ()
    (interactive)
    (let* ((size 12) ; ASCIIフォントのサイズ [9/10/12/14/15/17/19/20/...]
           (asciifont "Menlo") ; ASCIIフォント
           (jpfont "Hiragino Kaku Gothic Pro") ; 日本語フォント
           (h (* size 10))
           (fontspec (font-spec :family asciifont))
           (jp-fontspec (font-spec :family jpfont)))
      (set-face-attribute 'default nil :family asciifont :height h)
      (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
      (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
      (set-fontset-font nil 'katakana-jisx0201 jp-fontspec) ; 半角カナ
      (set-fontset-font nil '(#x0080 . #x024F) fontspec) ; 分音符付きラテン
      (set-fontset-font nil '(#x0370 . #x03FF) fontspec) ; ギリシャ文字
      ))

  ;; apologetic hack to make sure my mac input is used
  (defun set-mac-input ()
    (interactive)
    (progn
      (setq default-input-method "MacOSX")
      (set-input-method "MacOSX")
      (toggle-input-method)))

  (add-hook 'after-init-hook 'set-mac-input))

;; only use this on a mac
(when (and (>= emacs-major-version 23) (or (eq window-system 'ns) (eq window-system 'x)))
  (require 'todochiku)
  (setq todochiku-icons-directory "~/.emacs.d/todochiku-icons")
  (add-hook 'org-timer-done-hook '(lambda()
                                    (todochiku-message "Pomodoro" "completed" (todochiku-icon 'alarm)))))


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
(message "LOADING: xcode/iphone stuff")
