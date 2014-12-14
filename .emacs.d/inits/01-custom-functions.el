(eval-when-compile (require 'cl))

(defun machine-ip-address (dev)
  "Return IP address of a network device."
  (let ((info (network-interface-info dev)))
    (if info
        (format-network-address (car info) t))))

(defun ib ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))


(defun short-file-name ()
  "Display the file path and name in the modeline"
  (interactive "*")
  (setq-default mode-line-buffer-identification '("%12b")))

(defun long-file-name ()
  "Display the full file path and name in the modeline"
  (interactive "*")
  (setq-default mode-line-buffer-identification
                '("%S:" (buffer-file-name "%f"))))


;; Reload .emacs file by typing: Mx reload.
(defun reload-init ()
  "Reloads .emacs interactively."
  (interactive)
  (load "~/.emacs.d/init.el"))

;; (if (file-exists-p "~/projects/ghub")
;;     (setq default-directory "~/projects/ghub"))

(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha `(,value ,value)))

(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(80 50))))


(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

(global-set-key (kbd "M-RET") 'toggle-fullscreen)

;; Common copying and pasting functions
(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (save-excursion
    (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point)))
          (end (progn (forward-word arg) (point))))
      (copy-region-as-kill beg end))))

(global-set-key (kbd "C-c w") (quote copy-word))

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line "
  (interactive "P")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (copy-region-as-kill beg end)))

(global-set-key (kbd "C-c k") (quote copy-line))

(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (save-excursion
    (let ((beg (progn (backward-paragraph 1) (point)))
          (end (progn (forward-paragraph arg) (point))))
      (copy-region-as-kill beg end))))

(global-set-key (kbd "C-c p") (quote copy-paragraph))

(defun copy-string (&optional arg)
  "Copy a sequence of string into kill-ring"
  (interactive)
  (setq onPoint (point))
  (let ((beg (progn (re-search-backward "[\t ]" (line-beginning-position) 3 1)
                    (if (looking-at "[\t ]") (+ (point) 1) (point))))
        (end (progn (goto-char onPoint) (re-search-forward "[\t ]" (line-end-position) 3 1)
                    (if (looking-back "[\t ]") (- (point) 1) (point) ) )))
    (copy-region-as-kill beg end))
  (goto-char onPoint))


(global-set-key (kbd "C-c r") (quote copy-string))
(global-set-key (kbd "C-c s") 'ispell-word)
(global-set-key (kbd "M-s") 'ispell)


(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region (start end)
  (interactive "r")
  (let ((fill-column (point-max)))
    (fill-region start end nil)))

(message "LOADING: point stuff")

(defun point-to-top ()
  "Put cursor on top line of window, like Vi's H."
  (interactive)
  (move-to-window-line 0))

(defun point-to-bottom ()
  "Put cursor at bottom of last visible line, like Vi's L."
  (interactive)
  (move-to-window-line -1)
  (re-search-backward "\\S " (point-min) t 5))

(defun point-to-middle ()
  "Put cursor on middle line of window"
  (interactive)
  (let ((win-height (if (> (count-screen-lines) (window-height))
                        (window-height)
                      (count-screen-lines))))
    (move-to-window-line (floor (* win-height 0.4)))))

(global-set-key (kbd "C-x x") 'point-to-top)
(global-set-key (kbd "C-x c") 'point-to-bottom)
(global-set-key (kbd "C-x g") 'point-to-middle)
(global-set-key (kbd "C-x r e") 'string-insert-rectangle)

(defalias 'hb 'hide-body)
(defalias 'sb 'show-all)
(defalias 'he 'hide-entry)
(defalias 'se 'show-entry)

;; numbering rects usage:
;; http://d.hatena.ne.jp/rubikitch/20110221/seq
(defun number-rectangle (start end format-string from)
  "Delete (don't save) text in the region-rectangle, then number it."
  (interactive
   (list (region-beginning) (region-end)
         (read-string "Number rectangle: " (if (looking-back "^ *") "%d. " "%d"))
         (read-number "From: " 1)))
  (save-excursion
    (goto-char start)
    (setq start (point-marker))
    (goto-char end)
    (setq end (point-marker))
    (delete-rectangle start end)
    (goto-char start)
    (loop with column = (current-column)
          while (<= (point) end)
          for i from from do
          (insert (format format-string i))
          (forward-line 1)
          (move-to-column column)))
  (goto-char start))

(defun count-string-matches (regexp string)
  (with-temp-buffer
    (insert string)
    (count-matches regexp (point-min) (point-max))))
(defun seq (format-string from to)
  "Insert sequences with FORMAT-STRING.
FORMAT-STRING is like `format', but it can have multiple %-sequences."
  (interactive
   (list (read-string "Input sequence Format: ")
         (read-number "From: " 1)
         (read-number "To: ")))
  (save-excursion
    (loop for i from from to to do
          (insert (apply 'format format-string
                         (make-list (count-string-matches "%[^%]" format-string) i))
                  "\n")))
  (end-of-line))

(defun duplicate-this-line-forward (n)
  "Duplicates the line point is on. The point is next line.
 With prefix arg, duplicate current line this many times."
  (interactive "p")
  (when (eq (point-at-eol)(point-max))
    (save-excursion (end-of-line) (insert "\n")))
  (save-excursion
    (beginning-of-line)
    (dotimes (i n)
      (insert-buffer-substring (current-buffer) (point-at-bol)(1+ (point-at-eol))))))

(message "LOADING: number rect")

(defun byte-compile-all-my-files ()
  "byte compile everything"
  (interactive)
  (byte-recompile-directory "~/.emacs.d/site-lisp" 0 t)
  (byte-recompile-directory "~/.emacs.d" 0 t)
  (byte-recompile-directory "~/.emacs.d/wanderlust" 0 t)
  (byte-recompile-directory "~/.emacs.d/vim" 0 t)
  (byte-recompile-directory "~/.emacs.d/ensime_2.9.1-0.7.6/elisp" 0 t)
  (byte-recompile-directory "~/.emacs.d/twittering" 0 t))

(defalias 'by 'byte-compile-all-my-files)

(defun echo-time-now ()
  (interactive)
  (message (format-time-string current-time-format (current-time))))

(defalias 'ti 'echo-time-now)

(defun toggle-line-spacing ()
  "Toggle line spacing between no extra space to extra half line height."
  (interactive)
  (if (eq line-spacing nil)
      (setq-default line-spacing 0.5) ; add 0.5 height between lines
    (setq-default line-spacing nil)))

(defalias 'ts 'toggle-line-spacing)

(defalias 'ir 'indent-region)

(defun fixup-spaces ()
  (interactive)
  (save-excursion
    (if(eq mark-active
           nil)
        (progn
          (beginning-of-line)
          ;; (line-beginning-position)
          (while (re-search-forward "[ ]+" (line-end-position) t)
            (replace-match " " nil nil)))
      (progn
        (goto-char (region-beginning))
        (while (re-search-forward "[ ]+" (region-end) t)
          (replace-match " " nil nil))))))

(defun fixup-buffer-spaces ()
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (fixup-spaces)))

(defun save-elisp-to-local ()
  (interactive)
  (write-file "~/.emacs.d/site-lisp/"))

(message "LOADING: save elisp")

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

;; prompt when quitting Emacs in GUI
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs t))
    (message "Canceled exit")))

(global-set-key (kbd "C-x C-c") 'ask-before-closing)

(defun date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d.%m.%Y")
            (format-time-string "%Y-%m-%d"))))

(defun timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))


(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun menu-bar-redisplay-hack ()
  (interactive)
  (progn
    (tool-bar-mode)
    (tool-bar-mode -1)))

(defun make-three-split-frame ()
  (interactive)
  (set-frame-width (selected-frame) 185)
  (set-frame-height (selected-frame) 50)
  (delete-other-windows)
  (split-window-right)
  (split-window-below)
  (menu-bar-redisplay-hack))

(defun make-laptop-wide-frame ()
  (interactive)
  (set-frame-width (selected-frame) 185)
  (set-frame-height (selected-frame) 50)
  (menu-bar-redisplay-hack))


(global-set-key (kbd "C-S-n")
                (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))

(global-set-key (kbd "C-S-p")
                (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-S-f")
                (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))

(global-set-key (kbd "C-S-b")
                (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))


(defun apply-named-macro-to-region-lines (top bottom)
  "Apply named keyboard macro to all lines in the region."
  (interactive "r")
  (let ((macro (intern
                (completing-read "kbd macro (name): "
                                 obarray
                                 (lambda (elt)
                                   (and (fboundp elt)
                                        (or (stringp (symbol-function elt))
                                            (vectorp (symbol-function elt))
                                            (get elt 'kmacro))))
                                 t))))
    (apply-macro-to-region-lines top bottom macro)))

(defun apply-function-to-region-lines (fn)
  (interactive "aFunction to apply to lines in region: ")
  (save-excursion
    (goto-char (region-end))
    (let ((end-marker (copy-marker (point-marker)))
          next-line-marker)
      (goto-char (region-beginning))
      (if (not (bolp))
          (forward-line 1))
      (setq next-line-marker (point-marker))
      (while (< next-line-marker end-marker)
        (let ((start nil)
              (end nil))
          (goto-char next-line-marker)
          (save-excursion
            (setq start (point))
            (forward-line 1)
            (set-marker next-line-marker (point))
            (setq end (point)))
          (save-excursion
            (let ((mark-active nil))
              (narrow-to-region start end)
              (funcall fn)
              (widen)))))
      (set-marker end-marker nil)
      (set-marker next-line-marker nil))))


(defun select-current-line ()
  (interactive)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (move-end-of-line nil)
  (setq deactivate-mark nil))

(defun strip-whitespace-and-newlines-in-region (start end)
  (interactive "*r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (while (re-search-forward "[ \t\r\n]+" nil t)
        (replace-match "" nil nil))
      )))

(defun strip-whitespace-and-newlines-in-region (start end)
  (interactive "*r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (while (re-search-forward "[ \t\r\n]+" nil t)
        (replace-match "" nil nil))
      )))

(defun strip-whitespace-and-newlines-in-region-or-line ()
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (strip-whitespace-and-newlines-in-region beg end)))

(global-set-key (kbd "M-L") (lambda ()
                              (interactive)
                              (strip-whitespace-and-newlines-in-region-or-line)))

(defun strip-whitespace-in-region (start end)
  (interactive "*r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (while (re-search-forward "[ \t\r]+" nil t)
        (replace-match "" nil nil))
      )))


;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(define-key global-map "\M-q" 'unfill-paragraph)

(defun my-forward-word (arg)
  (interactive "p")
  (let ((char-category
         '(lambda (ch)
            (when ch
              (let* ((c (char-category-set ch))
                     ct)
                (cond
                 ((aref c ?a)
                  (cond
                   ((or (and (>= ?z ch) (>= ch ?a))
                        (and (>= ?Z ch) (>= ch ?A))
                        (and (>= ?9 ch) (>= ch ?0))
                        (= ch ?-) (= ch ?_))
                    'alphnum)
                   (t
                    'ex-alphnum)))
                 ((aref c ?j) ; Japanese
                  (cond
                   ((aref c ?K) 'katakana)
                   ((aref c ?A) '2alphnum)
                   ((aref c ?H) 'hiragana)
                   ((aref c ?C) 'kanji)
                   (t 'ja)))
                 ((aref c ?k) 'hankaku-kana)
                 ((aref c ?r) 'j-roman)
                 (t 'etc))))))
        (direction 'char-after)
        char type)
    (when (null arg) (setq arg 1))
    (when (> 0 arg)
      (setq arg (- arg))
      (setq direction 'char-before))
    (while (> arg 0)
      (setq char (funcall direction))
      (setq type (funcall char-category char))
      (while (and (prog1 (not (eq (point) (point-max)))
                    (cond ((eq direction 'char-after)
                           (goto-char (1+ (point))))
                          (t
                           (goto-char (1- (point))))))
                  (eq type (funcall char-category (funcall direction)))))
      (setq arg (1- arg)))
    type))

(defun my-backward-word (arg)
  (interactive "p")
  (my-forward-word (- (or arg 1))))

;; 素のforward-word, backward-wordを潰す
(global-set-key "\M-F" 'my-forward-word)
(global-set-key "\M-B" 'my-backward-word)
(global-set-key "\M-f" 'forward-word)
(global-set-key "\M-b" 'backward-word)

(global-set-key (kbd "M-K") (lambda ()
                              (interactive)
                              (join-line -1)))

;; quick and dirty buffer menu sorting
(define-key Buffer-menu-mode-map (kbd "M-s s") '(lambda() (interactive) (Buffer-menu-sort 2)))
(define-key Buffer-menu-mode-map (kbd "M-s d") '(lambda() (interactive) (Buffer-menu-sort 3)))
(define-key Buffer-menu-mode-map (kbd "M-s f") '(lambda() (interactive) (Buffer-menu-sort 4)))
(define-key Buffer-menu-mode-map (kbd "M-s g") '(lambda() (interactive) (Buffer-menu-sort 5)))

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))

(defun sudo-edit (&optional arg)
  (interactive "p")
  (if arg
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun sudo-edit-current-file ()
  (interactive)
  (find-alternate-file (concat "/sudo:root@localhost:" (buffer-file-name (current-buffer)))))

(message "LOADING: sudo edit (not working)")

;; ;; code from failed sudo attempt
;; (require 'sudo)

;; (defun sudo-before-save-hook ()
;; (set (make-local-variable 'sudo:file) (buffer-file-name))
;; (when sudo:file
;; (unless(file-writable-p sudo:file)
;; (set (make-local-variable 'sudo:old-owner-uid) (nth 2 (file-attributes sudo:file)))
;; (when (numberp sudo:old-owner-uid)
;; (unless (= (user-uid) sudo:old-owner-uid)
;; (when (y-or-n-p
;; (format "File %s is owned by %s, save it with sudo? "
;; (file-name-nondirectory sudo:file)
;; (user-login-name sudo:old-owner-uid)))
;; (sudo-chown-file (int-to-string (user-uid)) (sudo-quoting sudo:file))
;; (add-hook 'after-save-hook
;; (lambda ()
;; (sudo-chown-file (int-to-string sudo:old-owner-uid)
;; (sudo-quoting sudo:file))
;; (if sudo-clear-password-always
;; (sudo-kill-password-timeout)))
;; nil ;; not append
;; t ;; buffer local hook
;; )))))))


;; (add-hook 'before-save-hook 'sudo-before-save-hook)

;; credit to Benjamin Riefenstahl <Benjamin.Riefenstahl@epost.de>
(defun benny-antiword-file-handler (operation &rest args)
  ;; First check for the specific operations
  ;; that we have special handling for.
  (cond ((eq operation 'insert-file-contents)
         (apply 'benny-antiword-insert-file args))
        ((eq operation 'file-writable-p)
         nil)
        ((eq operation 'write-region)
         (error "Word documents can't be written"))
        ;; Handle any operation we don't know about.
        (t (let ((inhibit-file-name-handlers
                  (cons 'benny-antiword-file-handler
                        (and (eq inhibit-file-name-operation operation)
                             inhibit-file-name-handlers)))
                 (inhibit-file-name-operation operation))
             (apply operation args)))))

(defun benny-antiword-insert-file (filename &optional visit beg end replace)
  (set-buffer-modified-p nil)
  (setq buffer-file-name (file-truename filename))
  (setq buffer-read-only t)
  (let ((start (point))
        (inhibit-read-only t))
    (if replace (delete-region (point-min) (point-max)))
    (save-excursion
      (let ((coding-system-for-read 'utf-8)
            (filename (encode-coding-string
                       buffer-file-name
                       (or file-name-coding-system
                           default-file-name-coding-system))))
        (call-process "antiword" nil t nil "-m" "UTF-8.txt"
                      filename))
      (list buffer-file-name (- (point) start)))))

(defun no-word ()
  (interactive)
  (progn
    (benny-antiword-insert-file (buffer-file-name) nil nil nil t)
    (beginning-of-buffer)))

(add-to-list 'auto-mode-alist '("\\.doc\\'" . no-word))


(defalias 'yes-or-no-p 'y-or-n-p)

(when (executable-find "vlc")

  (defun vlc-command (&rest args)
    (interactive)
    (shell-command (concat "vlc " (mapconcat 'identity args " "))))

  (defun vlc-play ()
    (interactive)
    (vlc-command "play"))

  (defun vlc-pause ()
    (interactive)
    (vlc-command "pause"))

  (defalias 'vlc 'vlc-command)
  (defalias 'vlp 'vlc-play)
  (defalias 'vlpp 'vlc-pause)
  )


;; to ensure that junk files get saved by default
(defun write-and-find-file (filename)
  (progn
    (message filename)

    (find-file-other-window filename)
    (write-file filename)))


;; open dired marked files at once
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map "F" 'my-dired-find-file)
     (defun my-dired-find-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))))

(defun paste-over-mode ()
  (interactive)
  (delete-selection-mode 1))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defalias 'mg 'magit-status)

(defun wolfram-alpha-query (term)
  (interactive (list (read-string "Ask Wolfram Alpha: " (word-at-point))))
  (require 'w3m-search)
  (w3m-browse-url (concat "http://m.wolframalpha.com/input/?i=" (w3m-search-escape-query-string
                                                                 term))))

(defun replace-smart-quotes (beg end)
  "Replace 'smart quotes' in buffer or region with ascii quotes."
  (interactive "r")
  (format-replace-strings '(("\x201C" . "\"")
                            ("\x201D" . "\"")
                            ("\x2018" . "'")
                            ("\x2019" . "'")
			    ("\u2026" . "..."))
                          nil beg end))

(defun unfill-region (beg end)
      "Unfill the region, joining text paragraphs into a single
    logical line.  This is useful, e.g., for use with
    `visual-line-mode'."
      (interactive "*r")
      (let ((fill-column (point-max)))
        (fill-region beg end)))

(defun prepare-text-file-formatting-ebook ()
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "<.*?>" nil t)
    (replace-match ""))
    (goto-char (point-min))
  (while (re-search-forward "\\\\\\*\\\\\\*\\\\\\*" nil t)
    (replace-match "##\\\\\*\\\\\*\\\\\*"))
  (replace-smart-quotes (point-min) (point-max))
  (unfill-region (point-min) (point-max))
  (format-replace-strings '(("\x201C" . "\""))
                          nil (point-min) (point-max)))
