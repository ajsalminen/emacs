;; migemo options

;; obsolete init condition
(when (and (executable-find "cmigemo")
           (require 'migemo))
  (progn
    (require 'migemo)
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs"))
    (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
    (setq migemo-user-dictionary nil)
    (setq migemo-regex-dictionary nil)
    (setq migemo-coding-system 'utf-8-unix)
    (migemo-init)))

;; migemo options end


;; ctags
(autoload 'ctags-update "ctags-update" "update TAGS using ctags" t)
(autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on `ctags-auto-update-mode'." t)
(add-hook 'c-mode-common-hook  'turn-on-ctags-auto-update-mode)
;; (add-hook 'emacs-lisp-mode-hook  'turn-on-ctags-auto-update-mode)

;; ctags end


;; ace jump
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; ace jump end
