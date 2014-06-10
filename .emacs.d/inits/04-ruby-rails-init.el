(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(setq ruby-deep-indent-paren nil)
(global-set-key (kbd "C-c i i") 'inf-ruby)
(global-set-key (kbd "C-c i a") 'rvm-activate-corresponding-ruby)

(projectile-global-mode)
(add-hook 'ruby-mode-hook 'projectile-on)

(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))

(add-hook 'ido-setup-hook 'ido-define-keys)

(add-hook 'projectile-mode-hook 'projectile-rails-on)
