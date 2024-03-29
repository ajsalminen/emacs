;; (setq popwin:special-display-config nil)

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-height 0.5)
(setq special-display-function
      'popwin:special-display-popup-window)
(push '(dired-mode :position top) popwin:special-display-config)
(push '("*Compile-Log*" :height 10) popwin:special-display-config)
(push '("*Shell Command Output*" :height 30) popwin:special-display-config)
;; (push '("*compilation*" :height 10) popwin:special-display-config)
(push '("*Warnings*" :height 10 :noselect t) popwin:special-display-config)
(push '("*mu4e-loading*" :height 10 :noselect t) popwin:special-display-config)
(push '("*Help*" :height 10 :noselect nil) popwin:special-display-config)
(push '(ess-help-mode :height 20) popwin:special-display-config)
(push '("*translated*" :height 10 :noselect t) popwin:special-display-config)
(push '("*Process List*" :height 10) popwin:special-display-config)
(push '("*Locate*" :height 10 :noselect t) popwin:special-display-config)
(push '("*Moccur*" :height 20 :position bottom) popwin:special-display-config)
(push '("*wget.*" :regexp t :height 10 :position bottom) popwin:special-display-config)
(push '(" *auto-async-byte-compile*" :height 10) popwin:special-display-config)
(push '("\*grep\*.*" :regexp t :height 20) popwin:special-display-config)
(push '("function\-in\-.*" :regexp t) popwin:special-display-config)
(push '("*magit-diff*") popwin:special-display-config)
(push '("*wclock*" :height 10 :noselect t :position bottom) popwin:special-display-config)
(push '(Man-mode :stick t :height 20) popwin:special-display-config)
(push '("*Google Translate*" :height 20 :stick t :position bottom :noselect t) popwin:special-display-config)
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)

(defun popwin:define-advice (func buffer)
  (eval `(defadvice ,func (around popwin activate)
           (save-window-excursion ad-do-it)
           (popwin:popup-buffer ,buffer)
           (goto-char (point-min)))))

(popwin:define-advice 'vc-diff "*vc-diff*")
(popwin:define-advice 'magit-diff-working-tree "*magit-diff*")
(popwin:define-advice 'describe-key "*Help*")
(popwin:define-advice 'describe-function "*Help*")
(popwin:define-advice 'describe-mode "*Help*")
;; (popwin:define-advice 'auto-async-byte-compile "*auto-async-byte-compile*")
;; (popwin:define-advice 'text-translator-all "*translated*")
