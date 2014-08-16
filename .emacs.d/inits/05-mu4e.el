;; (require 'offlineimap)
(require 'mu4e)

;; (add-hook 'mu4e-main-mode-map-hook
;;           (lambda ()
;;             (define-key mu4e-main-mode-map "u" 'mu4e-update-index)))


;; ;; use this for debugging
;; (setq debug-on-error nil)

;; (setq mu4e-html2text-command "w3m -dump -cols 80 -T text/html")
(setq mu4e-html2text-command "w3m -dump -T text/html")
(setq mu4e-get-mail-command "mbsync -aq")
(setq mu4e-update-interval 3000)
;; (add-hook 'mu4e-headers-mode-hook '(lambda () (visual-line-mode -1)))
;; (add-hook 'mu4e-view-mode-hook '(lambda () (kindly-mode)))
;; (require 'sr-speedbar)
;; (setq sr-speedbar-right-side t)
;; (add-hook 'speedbar-load-hook 'fit-frame)
;; (add-hook 'speedbar-load-hook '(lambda ()
;;                                  (interactive)
;;                                  (speedbar-get-focus)))


(ignore-errors
  (load-file "~/.mufolders.el"))
