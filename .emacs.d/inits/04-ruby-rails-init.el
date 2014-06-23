(require 'rvm)
(rvm-use-default)

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(setq ruby-deep-indent-paren nil)
(global-set-key (kbd "C-c i i") 'inf-ruby)
(global-set-key (kbd "C-c i a") 'rvm-activate-corresponding-ruby)

(projectile-global-mode)
(add-hook 'ruby-mode-hook 'projectile-on)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(add-hook 'ruby-mode-hook 'robe-mode)
