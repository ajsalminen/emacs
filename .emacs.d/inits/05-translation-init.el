(require 'text-translator)
(global-set-key "\C-x\M-t" 'text-translator)

;; options to switch enjine
;; (setq text-translator-default-engine "excite.co.jp_enja")
;; (setq text-translator-default-engine "google.com_enja")

(defun insert-translation-buffer ()
  (interactive)
  (newline)
  (insert-buffer "*translated*")
  (newline))

(defun insert-translation ()
  (interactive)
  (progn
    (text-translator nil)
    (sleep-for 1))
  (insert-translation-buffer))

(global-set-key "\C-x\M-r" 'insert-translation)
