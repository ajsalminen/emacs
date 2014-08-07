;; ‘display-time-mode’ – Enable the display of the current time, see DisplayTime
;; ‘line-number-mode’ – Enable or disable the display of the current line number, see also LineNumbers
;; ‘column-number-mode’ – Enable or disable the display of the current column number
;; ‘size-indication-mode’ (for Emacs 22 and up) – Enable or disable the current buffer size, Emacs 22 and later, see size-indication-mode
;; ‘display-battery-mode’ – Enable or disable laptop battery information, see DisplayBatteryMode.

(setq display-time-format "[%H:%M]")
(setq display-time-24hr-format t)
(setq display-time-mail-string "")
(setq display-time-default-load-average nil)
(display-time-mode)
;; (column-number-mode)
;; (size-indication-mode)

(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (yas-minor-mode . " Ys")
    (paredit-mode . " Pe")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (fundamental-mode . "")
    (text-mode . "tx")
    (smart-tab-mode . "")
    (fundamental-mode . "")
    (undo-tree-mode . " Ut")
    (elisp-slime-nav-mode . " EN")
    (projectile-mode . " PJ")
    (helm-gtags-mode . " HG")
    (flymake-mode . " Fm")
    (company-mode . " Co")
    ;; Major modes
    (lisp-interaction-mode . "Li")
    (python-mode . "Py")
    (ruby-mode   . "Rb")
    (emacs-lisp-mode . "El")
    (markdown-mode . "Md")))

(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)
(add-hook 'fundamental-mode-hook 'clean-mode-line)

(setq frame-title-format '("" invocation-name "@" system-name "     "
                           global-mode-string))

(defun buffer-progress-percentage ()
  (interactive)
  (let* ((pos (point))
         (total (buffer-size))
         (percent (if (> total 50000)
                      ;; Avoid overflow from multiplying by 100!
                      (/ (+ (/ total 200) (1- pos)) (max (/ total 100) 1))
                    (/ (+ (/ total 2) (* 100 (1- pos))) (max total 1))))
         )
    (message "(%d%%)" percent)
))

;; (require 'powerline)
;; (setq powerline-default-separator 'bar)
;; (powerline-default-theme)

(setq mode-line-format
      '("[%+]"
        "%e|"
        "%@|"
        ;; "%p|"
        "%P|"
        "%c|"
        "%I|"
        "[L:%l]"
        ;; mode-line-front-space
        ;; mode-line-mule-info
        mode-line-client
        mode-line-modified
        ;; mode-line-auto-compile
        mode-line-remote
        mode-line-frame-identification
        mode-line-buffer-identification
        " "
        ;; mode-line-position
        ;; (vc-mode vc-mode)
        " "
        mode-line-misc-info "|"
        ;; mode-line-modes "|"
        ;; mode-line-end-spaces
        ))
