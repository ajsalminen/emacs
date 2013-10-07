(require 'twittering-mode)
(autoload 'twittering-numbering "twittering-numbering" nil t)
(add-hook 'twittering-mode-hook 'twittering-numbering)

(setq twittering-connection-type-order
      '(wget curl urllib-http native urllib-https))

(setq twittering-use-master-password t)
(setq twittering-url-show-status nil)
(setq twittering-number-of-tweets-on-retrieval 200)
(setq twittering-icon-mode nil)
;; (setq twittering-timer-interval 900)

(if (and (boundp 'jmp-api-key) (boundp 'jmp-user-name))
    (progn (defvar jmp-api-url
             (format "http://api.j.mp/shorten?version=2.0.1&login=%s&apiKey=%s&format=text&longUrl=" jmp-user-name jmp-api-key))
           (add-to-list 'twittering-tinyurl-services-map
                        `(jmp . ,jmp-api-url))
           ;; api key and other information in custom.el
           (setq twittering-tinyurl-service 'jmp)))

(define-key twittering-mode-map (kbd "S-<tab>") 'twittering-goto-previous-thing)
(define-key twittering-mode-map (kbd "<S-tab>") 'twittering-goto-previous-thing)
(define-key twittering-mode-map (kbd "<S-iso-lefttab>") 'twittering-goto-previous-thing)
(define-key twittering-mode-map [(shift tab)] 'twittering-goto-previous-thing)
(define-key twittering-mode-map (kbd "S-TAB") 'twittering-goto-previous-thing)
(define-key twittering-mode-map (kbd "S-<return>") 'wwo)

(add-hook 'twittering-edit-mode-hook (lambda ()
                                       (ispell-minor-mode)
                                       (flyspell-mode)))

(add-hook 'twittering-mode-hook (lambda ()
                                  (twittering-search "emacs exclude:retweets filter:links")
                                  (twittering-search "emacs exclude:retweets")))

(defalias 'tw 'twittering-mode)
(defalias 'tt 'twittering-update-status-interactive)

(setq twittering-initial-timeline-spec-string
      '(":home"
        ":replies"
        ":favorites"
        ":direct_messages"
        ":search/lift scala/"
        ":search/twitter/"
        ":search/keysnail/"
        ":search/vimperator/"
        ":search/emacs/"
        ":search/eshell/"
        "richstyles/foo"))

(define-key twittering-edit-mode-map "\M-j" 'twittering-edit-replace-at-point)
(define-key twittering-edit-mode-map "\M-q" 'twittering-edit-cancel-status)
(define-key twittering-edit-mode-map "\M-s" 'twittering-edit-post-status)

(defun twittering-mode-exit ()
  "twittering-mode を終了する。"
  (interactive)
  (when (y-or-n-p "Really exit twittering-mode? ")
    (if twittering-timer
        (twittering-stop))
    (dolist (buf (twittering-get-buffer-list))
      (if (get-buffer buf)
          (kill-buffer buf))))
  (garbage-collect))

(defalias 'twe 'twittering-mode-exit)
(message "LOADING: twittering mode setup")
