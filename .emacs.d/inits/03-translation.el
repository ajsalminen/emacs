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
(require 'google-translate-default-ui)
(setq google-translate-default-source-language "ja")
(setq google-translate-default-target-language "en")

(defun google-translate-flip-languages ()
  (interactive)
  (let* ((src-lang google-translate-default-source-language)
         (tgt-lang google-translate-default-target-language))
    (setq google-translate-default-source-language tgt-lang)
    (setq google-translate-default-target-language src-lang)))

;; The functions below are a mess of copy and pasted code, redifined functions and other egregious crimes to programming

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

;;  a native function to add the translated string to the clipboard
(defun google-translate-translate (source-language target-language text)
  "Translate TEXT from SOURCE-LANGUAGE to TARGET-LANGUAGE.

Pops up a buffer named *Google Translate* with available translations
of TEXT.  To deal with multi-line regions, sequences of white space
are replaced with a single space.  If the region contains not text, a
message is printed."
  (let ((text-stripped
         (replace-regexp-in-string "[[:space:]\n\r]+" " " text)))
    (if (or (= (length text-stripped) 0)
            (string= text-stripped " "))
        (message "Nothing to translate.")
      (let* ((json
              (json-read-from-string
               (google-translate-insert-nulls
                (google-translate-http-response-body
                 (google-translate-format-request-url
                  `(("client" . "t")
                    ("ie"     . "UTF-8")
                    ("oe"     . "UTF-8")
                    ("sl"     . ,source-language)
                    ("tl"     . ,target-language)
                    ("text"   . ,text-stripped)))))))
             (text-phonetic
              (mapconcat #'(lambda (item) (aref item 3))
                         (aref json 0) ""))
             (translation
              (mapconcat #'(lambda (item) (aref item 0))
                         (aref json 0) ""))
             (translation-phonetic
              (mapconcat #'(lambda (item) (aref item 2))
                         (aref json 0) ""))
             (dict (aref json 1)))
        ;; the line below was added to add the translated string to the kill ring
        (kill-new translation)
        (with-output-to-temp-buffer "*Google Translate*"
          (set-buffer "*Google Translate*")
          (insert
           (format "Translate from %s to %s:\n"
                   (if (string-equal source-language "auto")
                       (format "%s (detected)"
                               (google-translate-language-display-name
                                (aref json 2)))
                     (google-translate-language-display-name
                      source-language))
                   (google-translate-language-display-name
                    target-language)))
          (google-translate-paragraph
           text
           'google-translate-text-face)
          (when (and google-translate-show-phonetic
                     (not (string-equal text-phonetic "")))
            (google-translate-paragraph
             text-phonetic
             'google-translate-phonetic-face))
          (google-translate-paragraph
           translation
           'google-translate-translation-face)
          (when (and google-translate-show-phonetic
                     (not (string-equal translation-phonetic "")))
            (google-translate-paragraph
             translation-phonetic
             'google-translate-phonetic-face))
          (when dict
            ;; DICT is, if non-nil, a dictionary article represented by
            ;; a vector of items, where each item is a 2-element vector
            ;; whose zeroth element is the name of a part of speech and
            ;; whose first element is a vector of translations for that
            ;; part of speech.
            (loop for item across dict do
                  (let ((index 0))
                    (unless (string-equal (aref item 0) "")
                      (insert (format "\n%s\n" (aref item 0)))
                      (loop for translation across (aref item 1) do
                            (insert (format "%2d. %s\n"
                                            (incf index) translation))))))))))))



(defun google-translate-translate (source-language target-language text)
  "Translate TEXT from SOURCE-LANGUAGE to TARGET-LANGUAGE.

Pops up a buffer named *Google Translate* with available translations
of TEXT. To deal with multi-line regions, sequences of white space
are replaced with a single space. If the region contains not text, a
message is printed."
  (let* ((buffer-name "*Google Translate*")
         (json (google-translate-request source-language
                                         target-language
                                         text)))
    (if (null json)
        (message "Nothing to translate.")
      (let* ((auto-detected-language (aref json 2))
             (text-phonetic (google-translate-json-text-phonetic json))
             (translation (google-translate-json-translation json))
             (translation-phonetic (google-translate-json-translation-phonetic json))
             (detailed-translation (google-translate-json-detailed-translation json))
             (suggestion (when (null detailed-translation)
                           (google-translate-json-suggestion json))))

        ;; the line below was added to add the translated string to the kill ring
        (kill-new translation)
        (with-output-to-temp-buffer buffer-name
          (set-buffer buffer-name)
          (google-translate--buffer-output-translation-title source-language
                                                             target-language
                                                             auto-detected-language)
          (google-translate--buffer-output-translating-text text)
          (when detailed-translation
            (google-translate--buffer-output-text-phonetic text-phonetic))
          (google-translate--buffer-output-translation translation)
          (when detailed-translation
            (google-translate--buffer-output-translation-phonetic translation-phonetic))
          (if detailed-translation
              (google-translate--buffer-output-detailed-translation
               detailed-translation
               translation)
            (when suggestion
              (google-translate--buffer-output-suggestion suggestion
                                                          source-language
                                                          target-language))))))))

(defun translate-window-configuration ()
    "setup translation windows"
    (interactive)

    (progn
      (delete-other-windows)

      ;; some hackish steps to ensure the window gets fitted to scree (not fullscreen)
      (set-frame-width (selected-frame) 30)
      (toggle-frame-maximized)
      (modify-all-frames-parameters '((fullscreen . maximized)))

      (recenter)
      (select-window (split-window-right))
      (select-window (split-window-vertically))
      (split-window-vertically)
      (delete-window)
      (other-window 1)
      (switch-to-buffer "*Google Translate*")
      (other-window 1)))

(defalias 'tin 'translate-window-configuration)
