(require 'color-theme)
(require 'color-theme-invaders)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-invaders)))

(defun color-theme-reset ()
  (interactive)
  (color-theme-reset-faces))
