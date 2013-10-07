(defvar prev-buffer-input-method nil "save previously set inputmethod")
(make-variable-buffer-local 'prev-buffer-input-method)

(require 'vim)

(defun vim-mode-toggle-with-input ()
  (interactive)
  (if vim-mode
      (progn
        (activate-input-method (if (boundp 'prev-buffer-input-method)
                                   prev-buffer-input-method
                                 current-input-method))
        (vim-mode 0))
    (progn
      (setq prev-buffer-input-method current-input-method)
      (inactivate-input-method)
      (vim-mode t))))

(global-set-key (kbd "C-c v") 'vim-mode-toggle-with-input)

(message "LOADING: vim mode")

(defun input-mode-toggle-enter ()
  (interactive)
  (progn
    (activate-input-method (if (boundp 'prev-buffer-input-method)
                               prev-buffer-input-method
                             current-input-method))))

(add-hook 'vim:insert-mode-on-hook 'input-mode-toggle-enter)

(vim:omap (kbd "SPC") 'vim:scroll-page-down)
(vim:omap (kbd "S-SPC") 'vim:scroll-page-up)
(vim:nmap (kbd "C-z") 'anything)
(vim:nmap (kbd "C-S-z") 'vim:activate-emacs-mode)
(vim:map (kbd "C-S-z") 'vim:activate-normal-mode :keymap vim:emacs-keymap)

(push '(magit-mode . insert) vim:initial-modes)
(push '(magit-log-edit-mode . insert) vim:initial-modes)
(push '(w3m-mode . insert) vim:initial-modes)
(push '(eshell-mode . insert) vim:initial-modes)
(push '(debugger-mode . insert) vim:initial-modes)

;; (vim:omap (kbd "SPC") 'vim:scroll-page-down)
;; (vim:ovim:insert-mode-on-hook
;; upon entering vim mode

;; (defun input-mode-toggle-exit ()
;; (interactive)
;; (progn
;; (setq prev-buffer-input-method current-input-method)
;; (inactivate-input-method)))

;; (remove-hook 'vim:insert-mode-off-hook 'input-mode-toggle-exit)
