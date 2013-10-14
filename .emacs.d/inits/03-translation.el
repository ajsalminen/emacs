;; ucs-normalize-NFC-region で濁点分離を直す
;; M-x ucs-normalize-NFC-buffer または "C-x RET u" で、
;; バッファ全体の濁点分離を直します。
;; 参考：
;; http://d.hatena.ne.jp/nakamura001/20120529/1338305696
;; http://www.sakito.com/2010/05/mac-os-x-normalization.html

(require 'ucs-normalize)
(prefer-coding-system 'utf-8-hfs)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)

(defun ucs-normalize-NFC-buffer ()
  (interactive)
  (ucs-normalize-NFC-region (point-min) (point-max))
  )

(global-set-key (kbd "C-x RET u") 'ucs-normalize-NFC-buffer)


(require 'google-translate)
(setq google-translate-default-source-language "ja")
(setq google-translate-default-target-language "en")

(defun google-translate-flip-languages ()
  (interactive)
  (let* ((src-lang google-translate-default-source-language)
         (tgt-lang google-translate-default-target-language))
    (setq google-translate-default-source-language tgt-lang)
    (setq google-translate-default-target-language src-lang)))

(defun google-translate-region-or-line ()
  (interactive)
  (let (beg end)
    (progn
      (if (region-active-p)
          (setq beg (region-beginning) end (region-end))
        (setq beg (line-beginning-position) end (line-end-position)))
      (let* ((langs (google-translate-read-args nil nil))
             (source-language (car langs))
             (target-language (cadr langs)))
        (google-translate-translate
         source-language target-language
         (buffer-substring-no-properties beg end)
         ))
      )))

;; takes prefix arg to toggle languages
(defun google-translate-region-or-line ()
  (interactive)
  (let (beg end)
    (progn
      (if (region-active-p)
          (setq beg (region-beginning) end (region-end))
        (setq beg (line-beginning-position) end (line-end-position)))
      (let* ((langs (google-translate-read-args nil nil))
             (source-language (car langs))
             (target-language (cadr langs))
             (string (buffer-substring-no-properties beg end)))
        (if current-prefix-arg
            (google-translate-translate source-language target-language string)
          (google-translate-translate target-language source-language string)
          )))))

(global-set-key "\C-c\C-w" 'google-translate-at-point)
(global-set-key (kbd "C-c g") 'google-translate-region-or-line)
