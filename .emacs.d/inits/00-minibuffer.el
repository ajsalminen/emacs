(require 'icicles)
(icy-mode 1)
(global-set-key "\C-x\ \C-r" 'icicle-recent-file)
;;(setq icicle-TAB-completion-methods (quote (fuzzy basic vanilla)))

(require 'smex)
(smex-initialize)
(setq smex-auto-update t)
(run-at-time t 360 '(lambda () (if (smex-detect-new-commands) (smex-update))))

(defvar prev-minibuffer-input-method nil "save previously set inputmethod")
(defun toggle-back-minibuffer-input ()
  (interactive)
  (progn
    (activate-input-method (if (boundp 'prev-minibuffer-input-method)
                               prev-minibuffer-input-method
                             current-input-method))))
;; (add-hook 'minibuffer-exit-hook 'toggle-back-minibuffer-input)

(defun enter-minibuf-with-toggle-input-method (f)
  (interactive)
  (progn
    (setq prev-minibuffer-input-method current-input-method)
    (activate-input-method nil)
    (funcall f)))

(defun smex-with-toggle ()
  (interactive)
  (enter-minibuf-with-toggle-input-method 'smex))

;; (global-set-key (kbd "C-'") 'smex-with-toggle)
(global-set-key (kbd "C-'") 'smex)

(defun smex-hack ()
  (interactive)
  (progn
    (smex)
    (keyboard-quit)
    (smex)))

;; (global-set-key (kbd "M-x") 'smex-hack)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(iswitchb-mode 1)
