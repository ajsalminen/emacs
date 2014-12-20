(add-hook 'text-mode-hook 'flyspell-mode)

;; Completion words longer than 4 characters
(custom-set-variables
  '(ac-ispell-requires 3)
  '(ac-ispell-fuzzy-limit 2))

(eval-after-load "auto-complete"
  '(progn
      (ac-ispell-setup)))

;; (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
;; (add-hook 'mail-mode-hook 'ac-ispell-ac-setup)

(require 'company-ispell)

; auto-capitalize stuff
(autoload 'auto-capitalize-mode "auto-capitalize"
  "Toggle `auto-capitalize' minor mode in this buffer." t)
(autoload 'turn-on-auto-capitalize-mode "auto-capitalize"
  "Turn on `auto-capitalize' minor mode in this buffer." t)
(autoload 'enable-auto-capitalize-mode "auto-capitalize"
  "Enable `auto-capitalize' minor mode in this buffer." t)
(add-hook 'text-mode-hook 'turn-on-auto-capitalize-mode)
(setq auto-capitalize-words '("I" "I've" "I'm" "I'll"))
