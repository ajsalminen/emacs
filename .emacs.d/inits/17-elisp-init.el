(require 'paredit)
(require 'highlight-parentheses)

(setq hl-paren-colors
      '("orange1" "yellow1" "greenyellow" "green1"
        "springgreen1" "cyan1" "slateblue1" "magenta1" "purple"))

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook (lambda () (rainbow-delimiters-mode t) (paredit-mode t)))
(add-hook 'emacs-lisp-mode-hook (lambda () (rainbow-delimiters-mode t) (paredit-mode t)))
(add-hook 'slime-repl-mode-hook (lambda () (rainbow-delimiters-mode t) (paredit-mode t)))

(require 'eldoc-extension)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
