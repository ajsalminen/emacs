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
    ;; C-j で半角英数モードをトグルする
    (scim-define-common-key ?\C-j t)
    ;; SCIM-Anthy 使用時に、選択領域を再変換できるようにする
    (scim-define-common-key 'S-henkan nil)
    (global-set-key [S-henkan] 'scim-anthy-reconvert-region)
    ;; SCIM がオフのままローマ字入力してしまった時に、プリエディットに入れ直す
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
      ;; '("Takaoゴシック" . "unicode-bmp")
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
