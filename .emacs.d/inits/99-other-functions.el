(defun translation-setup ()
  (interactive)
  (google-translate-flip-languages)
  (paste-over-mode)
  (translate-window-configuration)
  (flyspell-mode))

(defun flyspell-save-word-to-dict ()
  (interactive)
  (let ((current-location (point))
         (word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct 'save nil (car word) current-location (cadr word) (caddr word) current-location))))

(define-key flyspell-mode-map [?\C-\:] 'flyspell-save-word-to-dict)
