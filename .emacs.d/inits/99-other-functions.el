(defun translation-setup ()
  (interactive)
  (google-translate-flip-languages)
  (paste-over-mode)
  (translate-window-configuration)
  (flyspell-mode))

(require 'flyspell)
(defun flyspell-save-word-to-dict ()
  (interactive)
  (let ((current-location (point))
         (word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct 'save nil (car word) current-location (cadr word) (caddr word) current-location))))

(define-key flyspell-mode-map [?\C-\:] 'flyspell-save-word-to-dict)

(require 'dictionary)
(eval-after-load 'text-mode
  '(define-key text-mode-map (kbd "C-c d") 'dictionary-lookup-definition))

(global-set-key "\C-cd" 'dictionary-lookup-definition)


