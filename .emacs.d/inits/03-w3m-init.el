;; (require 'w3m-load)

(require 'w3m-extension)
(autoload 'w3m-filter "w3m-filter")
(setq w3m-use-filter t)
(setq w3m-default-display-inline-images t)
(setq w3m-key-binding 'lynx)
(w3m-lnum-mode 1)
;;; (w3m-link-numbering-mode 1)
(setq w3m-session-load-last-sessions t)
(setq w3m-session-load-crashed-sessions t)


;;(add-hook 'w3m-mode-hook 'w3m-link-numbering-mode)
(setq w3m-use-cookies t)

(autoload 'wget "wget" "wget interface for Emacs." t)
(autoload 'wget-web-page "wget" "wget interface to download whole web page." t)
(setq wget-download-directory "~/Downloads")
(setq wget-max-window-height 10)

(require 'w3m-wget)

(defun w3m-wget-images (&optional buffer-position)
  (interactive)
  (let ((pos (or buffer-position (point))))
    (progn
      (w3m-next-image)
      (when (< pos (point))
        (let ((link (w3m-anchor)))
          (if link
              (progn
                (wget (w3m-anchor))
                (w3m-wget-images pos))))))))

(define-key w3m-mode-map (kbd "w") 'w3m-wget)
(define-key w3m-mode-map (kbd "W") 'w3m-wget-images)

(add-hook 'w3m-display-hook
          (lambda (url)
            (rename-buffer
             (format "*w3m: %s*" (or w3m-current-title
                                     w3m-current-url)) t)))

(setq w3m-verbose t)
(setq w3m-message-silent nil)
(setq url-show-status nil) ;;don't need to know how you're doing url-http

(autoload 'w3m-goto-url "w3m")
(defalias 'www 'w3m)
(defalias 'w3m-safe-view-this-url 'w3m-view-this-url)

(defun wws ()
  "Use Google (English) to search for WHAT."
  (interactive)
  (w3m-search-advance "http://www.google.com/search?hl=en&safe=off&ie=UTF-8&oe=UTF-8&q=" "Google Web EN" 'utf-8))

(defun wwo (&optional url)
  (interactive)
  (let ((url-at-point (thing-at-point 'url)))
    (message (format "browse url: %s" url-at-point))
    (if (and (not (eq url-at-point nil)) (string-match "https?://[a-zA-Z0-9\-]+[.]+[a-zA-Z0-9\-]+" url-at-point))
        (w3m-view-url-with-external-browser url-at-point)
      (w3m-view-url-with-external-browser))))

;; (setq w3m-new-session-in-background nil)

(defun w3m-browse-clipboard ()
  "uses the clipboard if it's an url, otherwise calls w3m-browse-url"
  (interactive)
  (let ((cliptext (current-kill 0 t)))
    (if (string-match "https?://.*$" cliptext)
        (w3m-browse-url (match-string 0 cliptext))
      (w3m))))

(define-key w3m-mode-map (kbd "p") 'w3m-previous-buffer)
(define-key w3m-mode-map (kbd "n") 'w3m-next-buffer)
(define-key w3m-mode-map (kbd "y") 'w3m-delete-buffer)

(defun w3m-view-this-url-background-session ()
  (interactive)
  (save-window-excursion
    (let ((in-background-state w3m-new-session-in-background))
      (setq w3m-new-session-in-background t)
      (w3m-view-this-url-new-session)
      (setq w3m-new-session-in-background in-background-state))))

(define-key w3m-mode-map (kbd "C-;") 'w3m-view-this-url-background-session)

;; (defalias 'wws 'w3m-search-google-web-en)
(defalias 'wwe 'w3m-search-emacswiki)
(defalias 'wwso 'w3m-search-stack-overflow)
;; (defalias 'wwo 'w3m-view-url-with-external-browser)
(defalias 'ww 'w3m-browse-clipboard)
(setq browse-url-browser-function 'w3m)
;; (setq browse-url-browser-function 'browse-url-default-macosx-browser)

;;(load-file (expand-file-name "~/.emacs.d/site-lisp/w3mkeymap.el"))
;;(add-hook 'w3m-mode-hook '(lambda () (use-local-map dka-w3m-map)))

(defun w3m-search-stack-overflow ()
  "search stack overflow"
  (interactive)
  (w3m-search-advance "http://stackoverflow.com/search?q=" "Stack Overflow" 'utf-8))

(defun w3m-search-alc (string)
  "search alc"
  (interactive "sSearch ALC: ")
  (let ((search-string (format "http://eow.alc.co.jp/%s/UTF-8/" (w3m-url-encode-string string 'utf-8)))
        (oldbuf (current-buffer))
        (query (format "%s" string)))
    (progn
      (w3m-browse-url search-string)
      (switch-to-buffer oldbuf))))

(defun w3m-search-alc (string)
  "search alc"
  (interactive "sSearch ALC: ")
  (let ((search-string (format "http://eow.alc.co.jp/search?q=%s" (w3m-url-encode-string string 'utf-8)))
        (oldbuf (current-buffer))
        (query (format "%s" string)))
    (progn
      (w3m-browse-url search-string)
      (switch-to-buffer oldbuf))))

(defun w3m-search-alc (string)
  "search alc"
  (interactive "sSearch ALC: ")
  (let ((search-string (format "http://eow.alc.co.jp/search?q=%s" (w3m-url-encode-string string 'utf-8)))
        (oldbuf (current-buffer))
        (query (format "%s" string)))
    (progn
      (browse-url search-string))))

(defun w3m-search-alc-at-point ()
  (interactive)
  (let ((text (if mark-active
                  (buffer-substring (point) (mark))
                (thing-at-point 'word))))
    (set-text-properties 0 (length text) nil text)
    (if (eq text nil)
        (call-interactively 'w3m-search-alc)
      (w3m-search-alc text))))

(defun alc-w3m-displayed (&optional url)
  (interactive)
  (if (string-match "eow\\.alc\\.co\\.jp" url)
      (let ((buffer-read-only nil)
            (beg (point-min)))
        (save-excursion
          (if (re-search-forward "検索文字[^列]" nil t)
              (delete-region (point) (point-min)))
          (while (re-search-forward "列[ \t]+" nil t)
            (replace-match"検索文字列: "))
          (delete-trailing-whitespace)
          (delete-blank-lines)))))

(add-hook 'w3m-display-hook 'alc-w3m-displayed)

(defun w3m-search-weblio (string)
  "search alc"
  (interactive "sSearch weblio: ")
  (let ((search-string (format "http://ejje.weblio.jp/content/%s" (w3m-url-encode-string string 'utf-8)))
        (oldbuf (current-buffer))
        (query (format "%s" string)))
    (progn
      (w3m-browse-url search-string)
      (switch-to-buffer oldbuf))))

(defun w3m-search-weblio (string)
  "search alc"
  (interactive "sSearch weblio: ")
  (let ((search-string (format "http://ejje.weblio.jp/content/%s" (w3m-url-encode-string string 'utf-8)))
        (oldbuf (current-buffer))
        (query (format "%s" string)))
    (progn
      (browse-url search-string)
      )))

(setq browse-url-browser-function 'browse-url-default-macosx-browser)
(setq browse-url-generic-program "open")

(defun w3m-search-weblio-at-point ()
  (interactive)
  (let ((text (if mark-active
                  (buffer-substring (point) (mark))
                (thing-at-point 'word))))
    (set-text-properties 0 (length text) nil text)
    (if (eq text nil)
        (call-interactively 'w3m-search-weblio)
      (w3m-search-weblio text))))

;; http://d.hatena.ne.jp/setoryohei/20121220/1356059447

(defun string-word-or-region ()
  "If region is selected, this returns the string of the region. If not, this returns the string of the word on which the cursor is."
  (let ((editable (not buffer-read-only))
        (pt (save-excursion (mouse-set-point last-nonmenu-event)))
        beg end)
    (if (and mark-active
             (<= (region-beginning) pt) (<= pt (region-end)) )
        (setq beg (region-beginning)
              end (region-end))
      (save-excursion
        (goto-char pt)
        (backward-char 1)
        (setq end (progn (forward-word) (point)))
        (setq beg (progn (backward-word) (point)))))
    (buffer-substring-no-properties beg end)))

(defun search-google()
  "Search by google"
  (interactive)
  (let* ((str (string-word-or-region)))
    (browse-url
     (concat "http://google.com/search?q=\"" str "\""))))

(defalias 'wwa 'w3m-search-alc)
(defalias 'wwr 'w3m-search-alc-at-point)
(defalias 'wwd 'w3m-search-weblio-at-point)
(global-set-key (kbd "C-c j") 'w3m-search-alc-at-point)
(global-set-key (kbd "C-c e") 'w3m-search-weblio-at-point)
(global-set-key (kbd "C-c e") '(lambda ()
                                 (interactive)
                                 (w3m-search-weblio-at-point)
                                 (w3m-search-alc-at-point)
                                 ))

(message "LOADING: w3m settings")
