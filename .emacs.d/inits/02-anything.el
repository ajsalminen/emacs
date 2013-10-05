(require 'anything-config)

;; (require 'anything-startup)
(global-set-key (kbd "C-z") 'anything)
(global-set-key (kbd "C-h h") 'anything)

(setq anything-idle-delay 0.3)
(setq anything-input-idle-delay 0.2)
(setq anything-candidate-number-limit 100)
(require 'anything-c-shell-history)
(require 'anything-yaetags)
(global-set-key (kbd "M-.") 'anything-yaetags-find-tag)
;; (global-set-key (kbd "M-.") 'find-tag)

(require 'anything-match-plugin)
(require 'eijiro)
(setq eijiro-directory "~/Downloads/EDP-124/EIJIRO/") ; 英辞郎の辞書を置いているディレクトリ

(setq anything-sources
      '(anything-c-source-recentf
        anything-c-source-info-pages
        anything-c-source-info-elisp
        anything-c-source-buffers
        ;; anything-c-source-shell-history
        anything-c-source-file-name-history
        anything-c-source-locate
        anything-c-source-occur))

(require 'descbinds-anything)
(descbinds-anything-install)
(defalias 'rf 'anything-recentf)
