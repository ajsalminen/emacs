(require 'color-theme)
(require 'color-theme-invaders)

(defun reset-emacs-italics ()
  "this goes through the fonts and removes italics"
  (interactive)
  (mapc
   (lambda (face)
     (set-face-attribute face nil :weight 'normal :underline nil :slant 'normal))
   (face-list)))


(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-invaders)
     (reset-emacs-italics)))

(defun color-theme-reset ()
  (interactive)
  (color-theme-reset-faces))
