;; All my custom settings that differ and/or can't be under version control
(setq custom-file "~/custom.el")
(load custom-file 'noerror)
(setq blog-file "~/blogs.el")
(load blog-file 'noerror)

(setq org2blog/wp-buffer-kill-prompt nil)

(setq Info-directory-list
      '("/usr/local/share/info" "~/info" "~/devdocs" "/usr/share/info" "/usr/local/info" "/usr/share/info/emacs-23"))

(setq initial-scratch-message nil)
(setq-default indent-tabs-mode nil)

;; frame stuff

;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))

;; commenting this out so the restore stuff kicks in
;; (set-frame-parameter (selected-frame) 'alpha '(100 100))
;; (add-to-list 'default-frame-alist '(alpha 100 100))

;; just the frame thanks
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(blink-cursor-mode nil)
(setq blink-cursor-interval nil)
(setq blink-cursor-interval 0.8)

(transient-mark-mode 1)
(setq gc-cons-threshold 4000)
(setq gc-cons-percentage 0.05)
(setq use-dialog-box nil)
(setq echo-keystrokes 0.1)
(setq history-length 1000)

(setenv (concat "/usr/local/libexec/git-core" ";" (getenv "GIT_EXEC_PATH")))

;; for stereoscopic tetris
(setq tetris-x-colors [[0 0 1] [0 0 1] [0 0 1] [1 0 0] [1 0 0] [1 0 0] [1 0 0]])

;; (defvar tetris-mode-map
;;   (let ((map (make-sparse-keymap 'tetris-mode-map)))
;;     (define-key map "n"		'tetris-start-game)
;;     (define-key map "q"		'tetris-end-game)
;;     (define-key map "p"		'tetris-pause-game)

;;     (define-key map " "		'tetris-move-bottom)
;;     (define-key map [left]	'tetris-move-left)
;;     (define-key map [right]	'tetris-move-right)
;;     (define-key map [up]	'tetris-rotate-prev)
;;     (define-key map [down]	'tetris-rotate-next)
;;     map))


(define-key tetris-mode-map "j" 'tetris-move-left)
(define-key tetris-mode-map "k" 'tetris-move-right)
(define-key tetris-mode-map "l" 'tetris-rotate-prev)
(define-key tetris-mode-map ";" 'tetris-rotate-next)

(message "LOADING: loaded custom stuff")
