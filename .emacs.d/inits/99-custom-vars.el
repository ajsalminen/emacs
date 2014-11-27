(setq sentence-end-double-space nil)

(setq open-junk-file-find-file-function 'write-and-find-file)

(delete-selection-mode 1)

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;; kill by logical lines
(define-key visual-line-mode-map [remap kill-line] nil)
(define-key visual-line-mode-map "\C-k" 'kill-line)

(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

(setq spray-wpm 800)

(setq wc-goal-modeline-format "[%tw(%w)]")
