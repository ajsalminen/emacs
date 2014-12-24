(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)
             (define-key dired-mode-map "/" 'dired-isearch-filenames)))
