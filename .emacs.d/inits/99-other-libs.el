;; migemo options

;; obsolete init condition
(when (and (executable-find "cmigemo")
           (require 'migemo))

  (progn
    (require 'migemo)
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs"))
    (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
    (setq migemo-user-dictionary nil)
    (setq migemo-regex-dictionary nil)
    (setq migemo-coding-system 'utf-8-unix)
    (migemo-init)))

;; migemo options end


;; ctags
(autoload 'ctags-update "ctags-update" "update TAGS using ctags" t)
(autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on `ctags-auto-update-mode'." t)
(add-hook 'c-mode-common-hook  'turn-on-ctags-auto-update-mode)
;; (add-hook 'emacs-lisp-mode-hook  'turn-on-ctags-auto-update-mode)

;; ctags end


;; ace jump
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; ace jump end


;; junk file
;; 思いついたコードやメモコードを書いて保存できるようにするための設定
;; (auto-install-from-emacswiki "open-junk-file.el")
(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%Y%m%d_%H%M%s_junk.utf")
(global-set-key "\C-c\C-j" 'open-junk-file)
;; junk file end

;; auto install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/site-lisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
;; auto install end

;; tab completion
(require 'smart-tab)
(global-smart-tab-mode 1)
;; tab completion end


;; window switching
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)
;; window switching end
