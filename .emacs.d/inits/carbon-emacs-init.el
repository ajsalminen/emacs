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
