(eval-after-load 'icicles
  '(progn
     (icy-mode 1)
     (global-set-key "\C-x\ \C-r" 'icicle-recent-file)
     ;;(setq icicle-TAB-completion-methods (quote (fuzzy basic vanilla)))
     ))


(eval-after-load "smex-autoloads"
  '(progn
     (setq smex-auto-update t)
     (global-set-key (kbd "M-x") 'smex)
     (global-set-key (kbd "M-X") 'smex-major-mode-commands)
     ;; This is your old M-x.
     (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
     (iswitchb-mode 1)
     (global-set-key (kbd "C-'") 'smex))

  (defun my-ido-keys ()
    "Add my keybindings for ido."
    (define-key ido-completion-map "\C-k" 'ido-next-match)
    (define-key ido-completion-map "\C-j" 'ido-prev-match)
    (define-key ido-completion-map "\C-n" 'ido-next-match)
    (define-key ido-completion-map "\C-p" 'ido-prev-match))

  (add-hook 'ido-setup-hook 'my-ido-keys))

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
