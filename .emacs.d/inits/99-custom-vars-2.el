;; utf-8 all the way
(setq current-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(if (< emacs-major-version 24)
    (setq default-buffer-file-coding-system 'utf-8)
  (setq buffer-file-coding-system 'utf-8))

(setq locale-coding-system 'utf-8)


(setq frame-title-format '("" invocation-name "@" system-name " "
                           global-mode-string "%b %+%+ %f" ))

(defvar current-time-format "%a %H:%M:%S")

(setq warning-suppress-types '(undo discard-info))

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)


;; yas vars to load before package.el otherwise throws error
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
        "~/.emacs.d/yasnippet-go/go-mode"
        ))
;; (yas/load-directory "~/.emacs.d/lisp/yasnippet/snippets")
(setq yas/root-directory "~/.emacs.d/lisp/mysnippets")


(setq safe-local-variable-values '((whitespace-style face tabs spaces trailing lines space-before-tab::space newline indentation::space empty space-after-tab::space space-mark tab-mark newline-mark)
                                   ))
