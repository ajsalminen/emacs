(when (and (< emacs-major-version 23) (eq window-system 'mac))
  (set-face-attribute 'default nil
                      :family "monaco"
                      :height 130)

  (set-fontset-font "fontset-default"
                    'katakana-jisx0201
                    '("ヒラギノ丸ゴ pro w4*" . "jisx0201.*"))

  (set-fontset-font "fontset-default"
                    'japanese-jisx0208
                    '("ヒラギノ丸ゴ pro w4*" . "jisx0208.*")))


(when (eq window-system 'mac)
  (remove-hook 'minibuffer-setup-hook 'mac-change-language-to-us))

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

;; Carbon Emacs keep Spotlight from triggering
(when
    (featurep 'carbon-emacs-package)
  (mac-add-ignore-shortcut '(control)))

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
