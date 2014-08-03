(defun translation-setup ()
  (interactive)
  (google-translate-flip-languages)
  (paste-over-mode)
  (translate-window-configuration)
  (flyspell-mode))

