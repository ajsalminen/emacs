(require 'diminish)
(diminish 'abbrev-mode "Abv")
(diminish 'auto-complete-mode)
(diminish 'auto-highlight-symbol-mode)
(diminish 'eldoc-mode)
(diminish 'flyspell-mode "f")
(diminish 'highlight-parentheses-mode)
(diminish 'rainbow-delimiters-mode)
(diminish 'icicle-mode)
(diminish 'paredit-mode "PE")
(diminish 'reftex-mode)
(if (featurep 'scim)
    (diminish 'scim-mode))
(diminish 'undo-tree-mode)
(diminish 'window-number-mode)
;; (diminish 'yas/minor-mode "Y")

(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (setq mode-name "el")))

(add-hook 'LaTeX-mode-hook
          (lambda()
            (setq TeX-base-mode-name "lx")))
