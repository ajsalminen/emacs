;; All my custom settings that differ and/or can't be under version control
(setq custom-file "~/custom.el")
(load custom-file 'noerror)
(setq blog-file "~/blogs.el")
(load blog-file 'noerror)

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

(message "LOADING: loaded custom stuff")

;; utf-8 all the way
(setq current-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(if (< emacs-major-version 24)
    (setq default-buffer-file-coding-system 'utf-8)
  (setq buffer-file-coding-system 'utf-8))

(setq locale-coding-system 'utf-8)


(setq frame-title-format '("" invocation-name "@" system-name " "
                           global-mode-string "%b %+%+ %f" ))

(defvar current-time-format "%a %H:%M:%S")

(setq warning-suppress-types '(undo discard-info))

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)


;; yas vars to load before package.el otherwise throws error
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
        "~/.emacs.d/yasnippet-go/go-mode"
        ))
;; (yas/load-directory "~/.emacs.d/lisp/yasnippet/snippets")
(setq yas/root-directory "~/.emacs.d/lisp/mysnippets")


(setq safe-local-variable-values '((whitespace-style face tabs spaces trailing lines space-before-tab::space newline indentation::space empty space-after-tab::space space-mark tab-mark newline-mark)
                                   ))

(setq sentence-end-double-space nil)

(setq open-junk-file-find-file-function 'write-and-find-file)

(delete-selection-mode 1)

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

