(eval-after-load 'icicles
  '(progn
     (icy-mode 1)
     (setq icicle-apropos-complete-keys (list (kbd "<tab>")))
     (global-set-key "\C-x\ \C-r" 'icicle-recent-file)
     (setq icicle-TAB-completion-methods '(fuzzy basic vanilla))
     (setq icicle-default-cycling-mode 'apropos)))


(eval-after-load "smex-autoloads"
  '(progn
     (setq smex-auto-update t)
     (global-set-key (kbd "M-x") 'execute-extended-command)
     (global-set-key (kbd "M-X") 'smex-major-mode-commands)
     ;; This is your old M-x.
     (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
     (iswitchb-mode 1)
     (global-set-key (kbd "C-'") 'smex)
     (setq ido-enable-flex-matching t)
     (setq ido-everywhere t)
     (defun my-ido-keys ()
       "Add my keybindings for ido."
       (define-key ido-completion-map "\C-k" 'ido-next-match)
       (define-key ido-completion-map "\C-j" 'ido-prev-match)
       (define-key ido-completion-map "\C-n" 'ido-next-match)
       (define-key ido-completion-map "\C-p" 'ido-prev-match))

     (add-hook 'ido-setup-hook 'my-ido-keys)))



;; (setq ido-decorations '("{" "}" " | " " | ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))
;; (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;; (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;; (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)


;;
;;; Key configuration for modal cycling within minibuffer
;; No need for configuration. They already work if configured for apropos-cycle.
;; (add-to-list 'icicle-modal-cycle-up-keys   (kbd "C-p"))
;; (add-to-list 'icicle-modal-cycle-down-keys (kbd "C-n"))
;;
;;; Key configuration for cycling fuzzy matching
;; icicle-apropos-complete-keys: S-tab by default
;; icicle-apropos-cycle-previous/next-keys: [next]/[prior] by default
;; (setq icicle-apropos-cycle-previous-keys (list (kbd "<A-tab>") (kbd "C-p") (kbd "<prior>")))
;; (setq icicle-apropos-cycle-next-keys     (list                 (kbd "C-n") (kbd "<next>")))
;;

;; (require 'smex)
;; (smex-initialize)

;; (run-at-time t 360 '(lambda () (if (smex-detect-new-commands) (smex-update))))

;; (defvar prev-minibuffer-input-method nil "save previously set inputmethod")
;; (defun toggle-back-minibuffer-input ()
;;   (interactive)
;;   (progn
;;     (activate-input-method (if (boundp 'prev-minibuffer-input-method)
;;                                prev-minibuffer-input-method
;;                              current-input-method))))
;; (add-hook 'minibuffer-exit-hook 'toggle-back-minibuffer-input)

;; (defun enter-minibuf-with-toggle-input-method (f)
;;   (interactive)
;;   (progn
;;     (setq prev-minibuffer-input-method current-input-method)
;;     (activate-input-method nil)
;;     (funcall f)))

;; (defun smex-with-toggle ()
;;   (interactive)
;;   (enter-minibuf-with-toggle-input-method 'smex))

;; (global-set-key (kbd "C-'") 'smex-with-toggle)


;; (defun smex-hack ()
;;   (interactive)
;;   (progn
;;     (smex)
;;     (keyboard-quit)
;;     (smex)))

;; (global-set-key (kbd "M-x") 'smex-hack)
