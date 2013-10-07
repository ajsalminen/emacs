;; Turn off early to avoid momentary display.
(mapc
 (lambda (mode)
   (if (fboundp mode)
       (funcall mode -1)))
 '(menu-bar-mode tool-bar-mode scroll-bar-mode))

;; the mother of all load paths
;; TODO: consolidate "lisp" folder and "site-lisp"
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; (let ((default-directory (expand-file-name "~/.emacs.d/site-lisp/")))
;;   (add-to-list 'load-path default-directory)
;;   (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;       (normal-top-level-add-subdirs-to-load-path)))

;; (let ((default-directory "~/.emacs.d/site-lisp/"))
;;   (normal-top-level-add-to-load-path '("."))
;;   (normal-top-level-add-subdirs-to-load-path))

(setq more-load-paths '("~/.emacs.d/el-get/bbdb/lisp/"
                        "~/.emacs.d/el-get/bbdb-vcard/"
                        "~/.emacs.d/el-get/el-get"
                        "~/.emacs.d/el-get/google-weather"
			"~/.emacs.d/site-lisp"))

(setq load-path (append load-path more-load-paths))

(setq initsplit-sort-customizations t)
(setq initsplit-default-directory "~/.emacs.d/inits/")
(setq initsplit-dynamic-customizations-alist
      '(("^w3m-" "16-w3m-init.el" nil)
	("^\\(preview\\|font-latex\\|latex\\|tex\\)-"
	 "17-tex-init.el" nil)
	))

(require 'init-loader)
(init-loader-load "~/.emacs.d/inits/")

;; FIXME: doesn't seem to work
(require 'initsplit)

(eval-when-compile (require 'cl))

(require 'paredit)
(require 'highlight-parentheses)

(setq hl-paren-colors
      '("orange1" "yellow1" "greenyellow" "green1"
        "springgreen1" "cyan1" "slateblue1" "magenta1" "purple"))

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook (lambda () (rainbow-delimiters-mode t) (paredit-mode t)))
(add-hook 'emacs-lisp-mode-hook (lambda () (rainbow-delimiters-mode t) (paredit-mode t)))
(add-hook 'slime-repl-mode-hook (lambda () (rainbow-delimiters-mode t) (paredit-mode t)))

(require 'bookmark)

(require 'icicles)
(icy-mode 1)
(global-set-key "\C-x\ \C-r" 'icicle-recent-file)
;;(setq icicle-TAB-completion-methods (quote (fuzzy basic vanilla)))

(require 'smex)
(smex-initialize)
(setq smex-auto-update t)
(run-at-time t 360 '(lambda () (if (smex-detect-new-commands) (smex-update))))

(defvar prev-minibuffer-input-method nil "save previously set inputmethod")
(defun toggle-back-minibuffer-input ()
  (interactive)
  (progn
    (activate-input-method (if (boundp 'prev-minibuffer-input-method)
                               prev-minibuffer-input-method
                             current-input-method))))
;; (add-hook 'minibuffer-exit-hook 'toggle-back-minibuffer-input)

(defun enter-minibuf-with-toggle-input-method (f)
  (interactive)
  (progn
    (setq prev-minibuffer-input-method current-input-method)
    (activate-input-method nil)
    (funcall f)))

(defun smex-with-toggle ()
  (interactive)
  (enter-minibuf-with-toggle-input-method 'smex))

;; (global-set-key (kbd "C-'") 'smex-with-toggle)
(global-set-key (kbd "C-'") 'smex)

(defun smex-hack ()
  (interactive)
  (progn
    (smex)
    (keyboard-quit)
    (smex)))

;; (global-set-key (kbd "M-x") 'smex-hack)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(iswitchb-mode 1)

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                                     clojure-mode scheme-mode
                                                     haskell-mode ruby-mode
                                                     rspec-mode python-mode
                                                     c-mode c++-mode
                                                     objc-mode latex-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))

(define-key global-map (kbd "RET") 'reindent-then-newline-and-indent)

(setq emerge-diff-options "--ignore-all-space")

(defun machine-ip-address (dev)
  "Return IP address of a network device."
  (let ((info (network-interface-info dev)))
    (if info
        (format-network-address (car info) t))))

;; emergency settings end here


;;; this was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(el-get-standard-packages (quote ("semi" "apel" "el-get" "google-weather" "bbdb-vcard" "tail" "bbdb" "wanderlust"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(message "LOADING: packages initialized")


;;(require 'byte-code-cache)

(let ((nfsdir "~/.emacs.d/site-lisp")
      (cachedir "~/.elispcache"))
  (setq load-path (append load-path (list cachedir nfsdir)))
  (require 'elisp-cache)
  (setq elisp-cache-byte-compile-files t)
  (setq elisp-cache-freshness-delay 0)
  (elisp-cache nfsdir cachedir))

(require 'work-timer)
(setq work-timer-working-time 30)
;;(defalias 'work-timer-start 'p)


(defface egoge-display-time
  '((((type x w32 mac))
     ;; #060525 is the background colour of my default face.
     (:foreground "#060525" :inherit bold))
    (((type tty))
     (:foreground "blue")))
  "Face used to display the time in the mode line.")

;; This causes the current time in the mode line to be displayed in
;; `egoge-display-time-face' to make it stand out visually.
(setq display-time-string-forms
      '((propertize (concat " " 24-hours ":" minutes " ")
                    'face 'egoge-display-time)))
(display-time-mode 1)
(message "LOADING: various custom packages")

;; Scala configs
(let ((path "~/.emacs.d/scala"))
  (setq load-path (cons path load-path))
  (load "scala-mode-auto.el"))
(require 'scala-mode-auto)
(add-hook 'scala-mode-hook
          (lambda ()
            (local-set-key (kbd "RET") 'reindent-then-newline-and-indent)))

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(defun make-lift-doc-url (type &optional member)
  (ensime-make-java-doc-url-helper
   "http://main.scala-tools.org/mvnsites-snapshots/liftweb/scaladocs/" type member))

(add-to-list 'ensime-doc-lookup-map '("net\\.liftweb\\." . make-lift-doc-url))

(message "LOADING: scala lift stuff")


(defalias 'yes-or-no-p 'y-or-n-p)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)


;; (require 'pabbrev)

;; FIXME: not working under emacs 24.3
;; (require 'tabkey2)
;; (tabkey2-mode nil)

;; (setq dabbrev-case-fold-search t)

;; (require 'smart-tab)
;; (global-smart-tab-mode t)
;; (global-pabbrev-mode t)


;; (global-set-key (kbd "\t") 'smart-tab)
;; (global-set-key '[tab] 'smart-tab)
;;(global-set-key '[C-tab] 'pabbrev-expand-maybe)
;;(define-key pabbrev-mode-map (kbd "C-;") 'pabbrev-expand-maybe)



;;(put 'org-mode 'pabbrev-global-mode-excluded-modes t)
;;(add-to-list 'pabbrev-global-mode-excluded-modes 'org-mode)
;;(add-hook 'text-mode-hook 'pabbrev-mode)

(require 'flyspell)
(setq flyspell-issue-welcome-flag nil)

(require 'reftex)
(setq reftex-toc-split-windows-horizontally t)
(setq reftex-allow-automatic-rescan t)
(setq reftex-auto-update-selection-buffers t)
(setq reftex-enable-partial-scans t)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode

(message "LOADING: load latex/reftex")
(setq reftex-plug-into-AUCTeX t)

;; (add-hook 'reftex-mode-hook 'reftex-toc)

(setq TeX-default-mode 'japanese-latex-mode)

(defun reftex-toc-rescan-after-save (&rest ignore)
  (interactive)
  (if (boundp 'reftex-last-toc-file)
      (switch-to-buffer-other-window
       (reftex-get-file-buffer-force reftex-last-toc-file)
       (reftex-toc t t))
    (reftex-toc t t)))


;; (add-hook 'LaTeX-mode-hook
;; (lambda ()
;; (add-hook 'after-save-hook (lambda ()
;; (save-excursion
;; (reftex-toc-rescan-after-save))))))

;; (add-hook 'LaTeX-mode-hook 'reftex-toc-rescan-after-save)
;; (add-hook 'latex-mode-hook 'reftex-toc-rescan-after-save)


;; Minimal OS X-friendly configuration of AUCTeX. Since there is no
;; DVI viewer for the platform, use pdftex/pdflatex by default for
;; compilation. Furthermore, use 'open' to view the resulting PDF.
;; Until Preview learns to refresh automatically on file updates, Skim
;; (http://skim-app.sourceforge.net) is a nice PDF viewer.
(setq TeX-PDF-mode t)
(setq TeX-view-program-selection
      '(((output-dvi style-pstricks)
         "dvips and PDF Viewer")
        (output-dvi "PDF Viewer")
        (output-pdf "PDF Viewer")
        (output-html "Safari")))
(setq TeX-view-program-list
      '(("dvips and PDF Viewer" "%(o?)dvips %d -o && open %f")
        ("PDF Viewer" "open %o")
        ("Safari" "open %o")))


(require 'hideshow)
(require 'fold-dwim)
(defalias 'to 'fold-dwim-toggle)
(defalias 'sho 'fold-dwim-show-all)
(defalias 'hi 'fold-dwim-hide-all)

(add-hook 'LaTeX-mode-hook (lambda ()
                             (TeX-fold-mode 1)))

(require 'yatex)
(setq YaTeX-fill-column nil)

;; ;; Alias the two major modes for fast switching
(defalias 'jl 'yatex-mode)
(defalias 'el 'japanese-latex-mode)

(require 'tex)
(add-to-list 'TeX-clean-default-intermediate-suffixes "\\.fdb_latexmk")

(eval-after-load "tex"
  '(add-to-list 'TeX-command-list '("m" "latexmk -pv -pdf %t" TeX-run-TeX nil t
                                    :help "Run Latexmk on file")))

(eval-after-load "tex"
  '(add-to-list 'TeX-command-list '("ubuntumk" "latexmk %t && platex %t && latexmk -pdfdvi %t" TeX-run-TeX nil t
                                    :help "Run Latexmk on file (with hacks from ubuntu environment)")))


;; (add-hook 'TeX-mode-hook 'reftex-toc)


(message "LOADING: pre ESS")

(setq ess-etc-directory "~/.emacs.d/ess-5.11/etc")
(require 'ess-site)
(require 'ess-eldoc)
(setq ess-source-directory (expand-file-name "~/ESS_Rdump/"))

(require 'ess-tracebug)
(add-hook 'ess-post-run-hook 'ess-debug t)
(add-hook 'ess-post-run-hook 'ess-traceback t)
(require 'ess-R-object-tooltip)
(require 'r-utils)

(add-to-list 'same-window-buffer-names "*Buffer List*")

(require 'yasnippet)
;; Develop and keep personal snippets under ~/emacs.d/mysnippets
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
        "~/.emacs.d/yasnippet-go/go-mode"
        ))
(yas/load-directory "~/.emacs.d/lisp/yasnippet/snippets")
(setq yas/root-directory "~/.emacs.d/lisp/mysnippets")


;; (mapc 'yas/load-directory yas/root-directory)

;;; (push 'yas-snippet-dirs "~/.emacs.d/yasnippet-go/go-mode")
;;; (add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippet-go/go-mode")

;; FIXME: disable for now (emacs 24.3 issues)
;; (yas-global-mode 1)
;; (setq yas/trigger-key (kbd "C-TAB"))
;; (setq yas/next-field-key (kbd "TAB"))


;; (yas/initialize)

(defun yas/ido-prompt-fix (prompt choices &optional display-fn)
  (when (featurep 'ido)
    (yas/completing-prompt prompt choices display-fn #'ido-completing-read)))

(setq yas/prompt-functions '(yas/ido-prompt-fix yas/dropdown-prompt yas/x-prompt))

;; Load the snippets
(yas/load-directory yas/root-directory)

(setq yas/wrap-around-region t)

(add-hook 'yas/minor-mode-on-hook
          '(lambda ()
             (define-key yas/minor-mode-map yas/trigger-key 'yas/expand)))

(require 'anything-c-yasnippet)
(global-set-key (kbd "C-c y") 'anything-c-yas-complete)


;; autocomplete stuff
(require 'go-mode-load)
(require 'go-autocomplete)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c i") 'go-goto-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd \"M-.\") 'godef-jump)))

(require 'flymake)
(require 'go-flymake)
(require 'go-errcheck)



(require 'auto-complete-config)


(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(require 'ac-company)
;; 対象の全てで補完を有効にする
(global-auto-complete-mode t)
(ac-company-define-source ac-source-company-xcode company-xcode)
;; objc-mode で補完候補を設定
(setq ac-modes (append ac-modes '(objc-mode)))

(setq ac-expand-on-auto-complete nil)
(setq ac-auto-start nil)
(setq ac-dwim nil) ; To get pop-ups with docs even if a word is uniquely completed
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

;; (require 'auto-complete-yasnippet)

(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(global-set-key "\M-/" 'hippie-expand)

(message "LOADING: yasnippet loading")


;; (global-set-key (kbd "C-c t") 'toggle-transparency)
(global-set-key (kbd "C-c t") '(lambda() (interactive) (recenter 1)))

(require 'maxframe)
;; (add-hook 'window-setup-hook 'maximize-frame t)


;; recentf stuff
(require 'recentf)
(setq recentf-keep '(file-remote-p file-readable-p))
(setq recentf-auto-cleanup 'never)
(setq recentf-max-saved-items 10000)
(setq recentf-max-menu-items 10000)
(require 'recentf-ext)
(recentf-mode 1)
;;(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(message "LOADING: recentf stuff")

(defalias 'message-box 'message)

(require 'dired+)
(define-key dired-mode-map "W" 'diredp-mark-region-files)

(require 'magit)
(require 'magit-svn)
(defalias 'mg 'magit-status)
(setq magit-revert-item-confirm t)

(defun magit-commit-then-push ()
  (interactive)
  (progn
    (magit-log-edit-commit)
    (magit-push)))

(define-key magit-log-edit-mode-map (kbd "C-x C-s") 'magit-commit-then-push)

(require 'gist)
(setq gist-use-curl t)

(message "LOADING: highlight stuff start")

;; ;; highlight current line
;; (require 'highline)
;; ;; (global-hl-line-mode t)
;; ;; To customize the background color
;; (set-face-background 'hl-line "#222") ;; Emacs 22 Only

;; (require 'hl-line+)
;; (toggle-hl-line-when-idle nil)

;; (require 'hl-spotlight)
;; ;; (global-hl-spotlight-mode t)
;; (setq hl-spotlight-height 0)

;; (require 'highlight-current-line)
;; ;; (highlight-current-line-on t)
;; (setq highlight-current-line-globally nil)
;; (set-face-background 'highlight-current-line-face "#222")
;;(add-hook 'highlight-current-line-hook (lambda () (redisplay t)))

;; (require 'col-highlight)
;; ;; to enable at all times
;; ;; (column-highlight-mode t)
;; (toggle-highlight-column-when-idle nil)
;; (col-highlight-set-interval 200000)
;; (set-face-background 'col-highlight "#222")


(message "highlight stuff end")

;; (add-hook 'iswitchb-minibuffer-setup-hook (lambda () (toggle-iswitchb-input)))
;; (add-hook 'minibuffer-setup-hook (lambda () (activate-input-method nil)))

(defun iswitchb-toggle-input-method ()
  (interactive)
  (enter-minibuf-with-toggle-input-method 'iswitchb-buffer))

(global-set-key "\C-xb" 'iswitchb-toggle-input-method)

(setq iswitchb-use-virtual-buffers t)
(require 'filecache)
(require 'iswitchb-fc)

(defun file-cache-iswitchb-file ()
  "Using iswitchb, interactively open file from file cache'.
First select a file, matched using iswitchb against the contents
in `file-cache-alist'. If the file exist in more than one
directory, select directory. Lastly the file is opened."
  (interactive)
  (let* ((file (file-cache-iswitchb-read "File: "
                                         (mapcar
                                          (lambda (x)
                                            (car x))
                                          file-cache-alist)))
         (record (assoc file file-cache-alist)))
    (find-file
     (concat
      (if (= (length record) 2)
          (car (cdr record))
        (file-cache-iswitchb-read
         (format "Find %s in dir: " file) (cdr record))) file))))

(defun file-cache-iswitchb-read (prompt choices)
  (let ((iswitchb-make-buflist-hook
         (lambda ()
           (setq iswitchb-temp-buflist choices))))
    (iswitchb-read-buffer prompt)))

(global-set-key "\C-cf" 'file-cache-iswitchb-file)


(add-hook 'iswitchb-define-mode-map-hook
          (lambda ()
            (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
            (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

(file-cache-add-directory "~/projects/ghub")

(defun file-cache-add-this-file ()
  (and buffer-file-name
       (file-exists-p buffer-file-name)
       (file-cache-add-file buffer-file-name)))
(add-hook 'kill-buffer-hook 'file-cache-add-this-file)

(message "LOADING: cache files")

;; File Name Cache
;; http://www.emacswiki.org/emacs/FileNameCache
(eval-after-load
    "filecache"
  '(progn
     (message "Loading file cache...")
     (file-cache-add-directory-list load-path)))


(require 'cursor-chg)

(defun recompile-emacsd ()
  (interactive)
  (byte-recompile-directory "~/.emacs.d" 0 t))

(defalias 'brd 'recompile-emacsd)

;; Remember the place
(require 'saveplace)
(setq-default save-place t)
(savehist-mode t)
(setq server-visit-hook (quote (save-place-find-file-hook)))


;; I always compile my .emacs, saves me about two seconds
;; startuptime. But that only helps if the .emacs.elc is newer
;; than the .emacs. So compile .emacs if it's not.
(when (and user-init-file
           (equal (file-name-extension user-init-file) "elc"))
  (let* ((source (file-name-sans-extension user-init-file))
         (alt (concat source ".el")))
    (setq source (cond ((file-exists-p alt) alt)
                       ((file-exists-p source) source)
                       (t nil)))
    (when source
      (when (file-newer-than-file-p source user-init-file)
        (byte-compile-file source)
        (load-file source)
        (eval-buffer nil nil)
        (delete-other-windows) ))))

(message "LOADING: pre image mode")

(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)

(add-hook 'iimage-mode-hook (lambda () (add-to-list 'iimage-mode-image-regex-alist
                                                    (cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex
                                                                  "\\)\\]") 1))))
(setq display-time-world-list '(("PST8PDT" "Bay Area")
                                ("EST5EDT" "New York")
                                ("GMT0BST" "London")
                                ("CET-1CDT" "Paris")
                                ("IST-5:30" "Bangalore")
                                ("JST-9" "Tokyo")))

(require 'calendar)
(require 'japanese-holidays)
(setq calendar-holidays
      (append japanese-holidays local-holidays other-holidays))
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
(setq mark-holidays-in-calendar t)

;; 日曜日を赤字にする場合、以下の設定を追加します。
(setq calendar-weekend-marker 'diary)
(add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
(add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)


;;for carbon emacs
(unless (fboundp 'calendar-extract-day)
  (defalias 'calendar-extract-day (symbol-function 'extract-calendar-day))
  (defalias 'calendar-extract-month (symbol-function 'extract-calendar-month))
  (defalias 'calendar-extract-year (symbol-function 'extract-calendar-year)))


(setq calendar-month-name-array
      ["January" "February" "March" "April" "May" "June"
       "July" "August" "September" "October" "November" "December"])

(setq calendar-day-name-array
      ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"])

;; 週の先頭の曜日
(setq calendar-week-start-day 0) ; 日曜日は0, 月曜日は1

(message "LOADING: calendar")

(defun start-calfw ()
  (interactive)
  (require 'calfw) ; 初回一度だけ
  ;; (cfw:open-calendar-buffer)
  ;; (cfw:contents-debug-data)
  (require 'calfw-ical)
  (cfw:install-ical-schedules)
  (require 'calfw-org)
  (cfw:install-org-schedules)
  (cfw:open-org-calendar))


;; ここまで

;; 思いついたコードやメモコードを書いて保存できるようにするための設定
;; (auto-install-from-emacswiki "open-junk-file.el")
(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%Y%m%d_%H%M%s_junk.utf")
(global-set-key "\C-c\C-j" 'open-junk-file)
;; ここまで


;; iPhone stuff
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

(ffap-bindings)
(autoload 'ffap-href-enable "ffap-href" nil t)

;; 探すパスは ffap-c-path で設定する
;; (setq ffap-c-path
;; '("/usr/include" "/usr/local/include"))
;; 新規ファイルの場合には確認する
(setq ffap-newfile-prompt t)
;; ffap-kpathsea-expand-path で展開するパスの深さ
(setq ffap-kpathsea-depth 5)

(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$" (".hh" ".h"))
        ("\\.hh$" (".cc" ".C"))

        ("\\.c$" (".h"))
        ("\\.h$" (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.C$" (".H" ".hh" ".h"))
        ("\\.H$" (".C" ".CC"))

        ("\\.CC$" (".HH" ".H" ".hh" ".h"))
        ("\\.HH$" (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))

        ("\\.hpp$" (".cpp" ".c"))))
(add-hook 'objc-mode-hook
          (lambda ()
            (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)))

(require 'auto-complete-clang)
(setq clang-completion-suppress-error 't)
(setq clang-completion-flags '("-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" "/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator4.3.sdk" "-I." "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200"))

;; ac-company で company-xcode を有効にする
(ac-company-define-source ac-source-company-xcode company-xcode)
;; objc-mode で補完候補を設定
(setq ac-modes (append ac-modes '(objc-mode)))
;; hook
(add-hook 'objc-mode-hook
          (lambda ()
            (setq tab-width 2)
            (define-key objc-mode-map (kbd "\t") 'ac-complete)
            ;; XCode を利用した補完を有効にする
            (push 'ac-source-clang-complete ac-sources)
            (push 'ac-source-company-xcode ac-sources)))

;; 補完ウィンドウ内でのキー定義
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)
(define-key ac-completing-map (kbd "M-/") 'ac-stop)
;; 補完が自動で起動するのを停止
(setq ac-auto-start nil)
;; 起動キーの設定
(ac-set-trigger-key "TAB")
;; 候補の最大件数 デフォルトは 10件
(setq ac-candidate-max 20)

(require 'auto-complete-latex)
(setq ac-l-dict-directory "~/.emacs.d/ac-l-dict/")
(setq ac-modes (append ac-modes '(LaTeX-mode latex-mode YaTeX-mode)))
(add-hook 'LaTeX-mode-hook 'ac-l-setup)
(add-hook 'latex-mode-hook 'ac-l-setup)
(add-hook 'YaTeX-mode-hook 'ac-l-setup)

;; etags-table の機能を有効にする
(require 'etags-table)
(add-to-list 'etags-table-alist
             '("\\.[mh]$" "~/tags/objc.TAGS"))
;; auto-complete に etags の内容を認識させるための変数
;; 以下の例だと3文字以上打たないと補完候補にならないように設定してあります。requires の次の数字で指定します
(defvar ac-source-etags
  '((candidates . (lambda ()
                    (all-completions ac-target (tags-completion-table))))
    (candidate-face . ac-candidate-face)
    (selection-face . ac-selection-face)
    (requires . 3))
  "etags をソースにする")
;; objc で etags からの補完を可能にする
(add-hook 'objc-mode-hook
          (lambda ()
            (push 'ac-source-etags ac-sources)))


(add-hook 'c-mode-common-hook
          '(lambda()
             (make-variable-buffer-local 'skeleton-pair)
             (make-variable-buffer-local 'skeleton-pair-on-word)
             (setq skeleton-pair-on-word t)
             (setq skeleton-pair t)
             (make-variable-buffer-local 'skeleton-pair-alist)
             (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
             (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)))

(setq cua-enable-cua-keys nil)
(cua-mode t)

(require 'find-file)
(add-to-list 'ff-other-file-alist '("\\.mm?$" (".h")))
(add-to-list 'ff-other-file-alist '("\\.h$" (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm")))

(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$" (".hh" ".h"))
        ("\\.hh$" (".cc" ".C"))

        ("\\.c$" (".h"))
        ("\\.h$" (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.C$" (".H" ".hh" ".h"))
        ("\\.H$" (".C" ".CC"))

        ("\\.CC$" (".HH" ".H" ".hh" ".h"))
        ("\\.HH$" (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))

        ("\\.hpp$" (".cpp" ".c"))))

(require 'flymake)
(defvar xcode:gccver "4.2.1")
(defvar xcode:sdkver "4.3")
(defvar xcode:sdkpath "/Developer/Platforms/iPhoneSimulator.platform/Developer")
(defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))
(defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/gcc-" xcode:gccver))
(defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" xcode:sdk))
(defvar flymake-last-position nil)
(defvar flymake-objc-compile-options '("-I."))

;; this really doesn't work, there's just no way
(defun flymake-objc-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list flymake-objc-compiler (append flymake-objc-compile-default-options flymake-objc-compile-options (list local-file)))))

;; (add-hook 'objc-mode-hook
;; (lambda ()
;; (push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
;; (push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)
;; (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
;; (flymake-mode t))))

;; (defun flymake-display-err-minibuffer ()
;; "現在行の error や warinig minibuffer に表示する"
;; (interactive)
;; (let* ((line-no (flymake-current-line-no))
;; (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;; (count (length line-err-info-list)))
;; (while (> count 0)
;; (when line-err-info-list
;; (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
;; (full-file (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;; (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;; (line (flymake-ler-line (nth (1- count) line-err-info-list))))
;; (message "[%s] %s" line text)))
;; (setq count (1- count)))))

;; (defadvice flymake-goto-next-error (after display-message activate compile)
;; "次のエラーへ進む"
;; (flymake-display-err-minibuffer))

;; (defadvice flymake-goto-prev-error (after display-message activate compile)
;; "前のエラーへ戻る"
;; (flymake-display-err-minibuffer))

;; (defadvice flymake-mode (before post-command-stuff activate compile)
;; "エラー行にカーソルが当ったら自動的にエラーが minibuffer に表示されるように
;; post command hook に機能追加"
;; (set (make-local-variable 'post-command-hook)
;; (add-hook 'post-command-hook 'flymake-display-err-minibuffer)))

(defvar *xcode-project-root* nil)

(defun xcode--project-root ()
  (or *xcode-project-root*
      (setq *xcode-project-root* (xcode--project-lookup))))

(defun xcode--project-lookup (&optional current-directory)
  (when (null current-directory) (setq current-directory default-directory))
  (cond ((xcode--project-for-directory (directory-files current-directory)) (expand-file-name current-directory))
        ((equal (expand-file-name current-directory) "/") nil)
        (t (xcode--project-lookup (concat (file-name-as-directory current-directory) "..")))))

(defun xcode--project-for-directory (files)
  (let ((project-file nil))
    (dolist (file files project-file)
      (if (> (length file) 10)
          (when (string-equal (substring file -10) ".xcodeproj") (setq project-file file))))))

(defun xcode--project-command (options)
  (concat "cd " (xcode--project-root) "; " options))

(defun xcode/build-compile ()
  (interactive)
  (compile (xcode--project-command (xcode--build-command))))

(defun xcode/build-list-sdks ()
  (interactive)
  (message (shell-command-to-string (xcode--project-command "xcodebuild -showsdks"))))

(defun xcode--build-command (&optional target configuration sdk)
  (let ((build-command "xcodebuild"))
    (if (not target)
        (setq build-command (concat build-command " "))
      (setq build-command (concat build-command " -target " target)))
    (if (not configuration)
        (setq build-command (concat build-command " "))
      (setq build-command (concat build-command " -configuration " configuration)))
    (when sdk (setq build-command (concat build-command " -sdk " sdk)))
    build-command))

;; yeah, I should set a variable somewhere
(defun xcode/build ()
  (interactive)
  (compile (xcode--project-command (xcode--build-command nil nil "iphonesimulator4.3"))))

(setq compilation-scroll-output t)

;; helps catch xcodebuild bug for jumpy jumpy

;; FIXME: this probably messes up my compile
;; (add-to-list 'compilation-error-regexp-alist '("\\(.*?\\):\\([0-9]+\\): error.*$" 1 2))



;; 自動的な表示に不都合がある場合は以下を設定してください
;; post-command-hook は anything.el の動作に影響する場合があります
(define-key global-map (kbd "C-c d") 'flymake-display-err-minibuffer)

(set-face-background 'flymake-errline "red")
(set-face-background 'flymake-warnline "yellow")

(defun xcode:buildandrun ()
  (interactive)
  (do-applescript
   (format
    (concat
     "tell application \"Xcode\" to activate \r"
     "tell application \"System Events\" \r"
     " tell process \"Xcode\" \r"
     " key code 36 using {command down} \r"
     " end tell \r"
     "end tell \r" ))))

(add-hook 'objc-mode-hook
          (lambda ()
            (define-key objc-mode-map (kbd "C-c C-r") 'xcode:buildandrun)))


(require 'basic-edit-toolkit)

(require 'w3m-load)

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

(require 'revbufs)

(require 'bookmark+)

;;(add-hook 'after-init-hook 'org-agenda-list)
;;(add-hook 'after-init-hook 'bookmark-bmenu-list)

(bookmark-bmenu-list)

(require 'alpaca)

;;(require 'todochiku)
;;(load-file "~/.emacs.d/site-lisp/work-timer.el")

;;(setq work-timer-working-time 10)
;;(global-set-key (kbd "C-x t m") 'work-timer-start)

;;(require 'epom)
;;(global-set-key (kbd "C-x t m") 'epom-start-cycle)

(require 'pomodoro)
(global-set-key (kbd "C-x t m") 'pomodoro-work)
(global-set-key (kbd "C-x t d") 'pomodoro-done)
(global-set-key (kbd "C-x t l") 'pomodoro-later)

(require 'weblogger)
(require 'zencoding-mode)

(defalias 'bl 'weblogger-start-entry)
(defalias 'bll 'weblogger-select-configuration)

(add-hook 'weblogger-entry-mode-hook 'turn-off-auto-fill)
(add-hook 'weblogger-entry-mode-hook 'ispell-minor-mode)
(add-hook 'weblogger-entry-mode-hook 'flyspell-mode)

(require 'textile-minor-mode)

;;(add-hook 'weblogger-entry-mode-hook 'textile-minor-mode)

(message "LOADING: blogging")
(defun publish-post ()
  (interactive)
  (textile-to-html-buffer-respect-weblogger)
  (weblogger-publish-entry))

(define-key weblogger-entry-mode-map "\C-x\C-s" 'publish-post)

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/site-lisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; (require 'auto-async-byte-compile)
;; (setq auto-async-byte-compile-exclude-files-regexp "org\\|junk\\|\\.revive\\.el\\|init\\.el")

;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(setq uniquify-separator ":")

(require 'screen-lines)
;; (add-hook 'text-mode-hook 'turn-on-screen-lines-mode)

(require 'summarye)

(defun my-ido-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map "\C-k" 'ido-next-match)
  (define-key ido-completion-map "\C-j" 'ido-prev-match)
  (define-key ido-completion-map "\C-n" 'ido-next-match)
  (define-key ido-completion-map "\C-p" 'ido-prev-match))

(add-hook 'ido-setup-hook 'my-ido-keys)
(defalias 'qrr 'query-replace-regexp)

(require 'fuzzy)
(turn-on-fuzzy-isearch)

(require 'enclose)
(enclose-remove-encloser "'")
;; (add-hook 'LaTeX-mode-hook 'enclose-mode)
(add-hook 'weblogger-entry-mode 'enclose-mode)

(message "LOADING: ido keys")

;; (autoload 'mode-compile "mode-compile"
;;   "Command to compile current buffer file based on the major mode" t)
;; (global-set-key "\C-cc" 'mode-compile)
;; (autoload 'mode-compile-kill "mode-compile"
;;   "Command to kill a compilation launched by `mode-compile'" t)
;; (global-set-key "\C-ck" 'mode-compile-kill)

(require 'eldoc-extension)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(setq path-to-ctags "/usr/local/bin/ctags")

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name))))

(setq tags-revert-without-query t)

(require 'etags-table)
(require 'etags-select)
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)

(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
(require 'dired-sort-map)

(require 'rinari)
(require 'rhtml-mode)
(require 'ruby-electric)


;; (require 'textmate)
;; (textmate-mode)
;; (define-key *textmate-mode-map* (kbd "M-;") 'comment-or-uncomment-region-or-line)
;; (global-set-key "\M-T" 'transpose-words)

(defun is-rails-project ()
  (when (textmate-project-root)
    (file-exists-p (expand-file-name "config/environment.rb" (textmate-project-root)))))

(defun run-rails-test-or-ruby-buffer ()
  (interactive)
  (if (is-rails-project)
      (let* ((path (buffer-file-name))
             (filename (file-name-nondirectory path))
             (test-path (expand-file-name "test" (textmate-project-root)))
             (command (list ruby-compilation-executable "-I" test-path path)))
        (pop-to-buffer (ruby-compilation-do filename command)))
    (ruby-compilation-this-buffer)))


(autoload 'ruby-mode "ruby-mode" nil t)
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-hook 'ruby-mode-hook '(lambda ()
                             (setq ruby-deep-arglist t)
                             (setq ruby-deep-indent-paren nil)
                             (setq c-tab-always-indent nil)
                             (require 'inf-ruby)
                             (require 'ruby-compilation)
                             (define-key ruby-mode-map (kbd "M-r") 'run-rails-test-or-ruby-buffer)))

(autoload 'rhtml-mode "rhtml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
(add-hook 'rhtml-mode '(lambda ()
                         (define-key rhtml-mode-map (kbd "M-s") 'save-buffer)))

(message "LOADING: rhtml/yaml stuff")

(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(setq cssm-indent-function #'cssm-c-style-indenter)
(add-hook 'css-mode-hook '(lambda ()
                            (require 'css-complete)
                            (setq css-indent-level 2)
                            (setq css-indent-offset 2)))

(require 'sense-region)
(sense-region-on)

(require 'dired-sort-map)

(require 'breadcrumb)
(global-set-key [(control tab)] 'bc-set) ;; Shift-SPACE for set bookmark
(global-set-key [(control c)(u)] 'bc-previous) ;; M-j for jump to previous
(global-set-key [(control c)(i)] 'bc-next) ;; Shift-M-j for jump to next
(global-set-key [(meta up)] 'bc-local-previous) ;; M-up-arrow for local previous
(global-set-key [(meta down)] 'bc-local-next) ;; M-down-arrow for local next
(global-set-key [(control c)(n)] 'bc-goto-current) ;; C-c j for jump to current bookmark
(global-set-key [(control c)(m)] 'bc-list) ;; C-x M-j for the bookmark menu list

(global-set-key [(control tab)] 'other-frame)
(global-set-key [(shift control tab)] '(lambda() (interactive) (other-frame -1)))

;; redo+ is broken in 24.3 and above
(when (not (and (>= emacs-major-version 24) (>= emacs-minor-version 3)))
  (progn
    (require 'redo+)
    (global-set-key (kbd "C-M-/") 'redo)
    (setq undo-no-redo t)
    (setq undo-limit 600000)
    (setq undo-strong-limit 900000)))

(require 'goto-chg)
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)

(require 'midnight)

(message "LOADING: window movement")

(windmove-default-keybindings 'meta)

(define-prefix-command 'numwin-bindings-keymap)
(define-key numwin-bindings-keymap (vector ?7) 'windmove-left)
(define-key numwin-bindings-keymap (vector ?8) 'windmove-right)
(define-key numwin-bindings-keymap (vector ?9) 'windmove-up)
(define-key numwin-bindings-keymap (vector ?0) 'windmove-down)
(global-set-key (kbd "C-x 7") 'numwin-bindings-keymap)

(load "~/.emacs.d/haskell-mode/haskell-site-file.el")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(setq haskell-font-lock-symbols t)
;; (setq haskell-hoogle-command "~/.cabal/bin/hoogle")

(message "LOADING: igrep")

(require 'igrep)
(setq igrep-options "-ir")
(igrep-define lgrep (igrep-use-zgrep nil) (igrep-regex-option "-n -0u8"))
(igrep-find-define lgrep (igrep-use-zgrep nil) (igrep-regex-option "-n -0u8"))

(require 'grep-a-lot)
(grep-a-lot-setup-keys)
(grep-a-lot-advise igrep)

(require 'grep-edit)

(require 'cedet)
;; (require 'jde)
(autoload 'jde-mode "jde" "JDE mode." t)
;; (add-to-list 'auto-mode-alist '("\\java\\'" . jde-mode))

;; (semantic-load-enable-minimum-features)
;; (require 'malabar-mode)
;; (setq malabar-groovy-lib-dir "~/emacs.d/malabar-1.5-SNAPSHOT/lib")
;; (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))



;; (load-file "~/.emacs.d/site-lisp/mvn.el")

(require 'undo-tree)
(global-undo-tree-mode)

(message "LOADING: insert")

(defun insert-time ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d-%R")))

(find-function-setup-keys)

(defun isearch-yank-symbol ()
  "*Put symbol at current point into search string."
  (interactive)
  (let ((sym (symbol-at-point)))
    (if sym
        (progn
          (setq isearch-regexp t
                isearch-string (concat "\\_<" (regexp-quote (symbol-name sym)) "\\_>")
                isearch-message (mapconcat 'isearch-text-char-description isearch-string "")
                isearch-yank-flag t))
      (ding)))
  (isearch-search-and-update))

(define-key isearch-mode-map "\M-E" 'isearch-yank-symbol)

(require 'switch-window)
(setq switch-window-increase 10)
(setq switch-window-timeout 3)

(require 'sr-speedbar)

(message "LOADING: sr-speedbar")

(require 'backup-dir)
(setq tramp-bkup-backup-directory-info nil)
(add-to-list 'bkup-backup-directory-info
             (list tramp-file-name-regexp ""))
(add-to-list 'bkup-backup-directory-info
             (list tramp-file-name-regexp ""))
(setq tramp-bkup-backup-directory-info bkup-backup-directory-info)



(autoload 'ange-ftp "ange-ftp" nil t)
;;(add-hook 'ange-ftp-process-startup-hook 'ecb-deactivate)
(autoload 'tramp "tramp" nil t)
(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*") ;
(setq tramp-persistency-file-name nil)

(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

(setq-default line-spacing 0)

(require 'cssh)

(require 'list-processes+)
(defalias 'lp 'list-processes+)

(require 'yaoddmuse)
(setq yaoddmuse-username "baron")
;; (yaoddmuse-update-pagename nil)

;; trouble with zsh in emacs
(setq shell-file-name (executable-find "bash"))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

(require 'eshell)
(require 'shell-pop)
(setq eshell-save-history-on-exit t)
(shell-pop-set-internal-mode "eshell")
(shell-pop-set-window-height 60)

(defun eshell-maybe-bol ()
  (interactive)
  (let ((p (point)))
    (eshell-bol)
    (if (= p (point))
        (beginning-of-line))))


(message "LOADING: eshell activated")

(add-hook 'eshell-mode-hook
          (lambda ()
            (define-key eshell-mode-map (kbd "C-a") 'eshell-maybe-bol)
            (define-key eshell-mode-map (kbd "C-r") 'eshell-isearch-backward)))

(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'eshell-load-hook 'ansi-color-for-comint-mode-on)
(autoload 'ansi-color-apply-on-region "ansi-color" nil t)
(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
                              eshell-last-output-end))
(add-hook 'eshell-output-filter-functions 'eshell-handle-ansi-color)

(when (require 'pcmpl-auto nil t)
  (when (require 'pcmpl-ssh nil t)
    (add-hook 'eshell-mode-hook 'pcomplete-shell-setup)))

(setq eshell-cmpl-ignore-case t)
(setq eshell-glob-include-dot-files t)
(setq eshell-glob-include-dot-dot t)
(setq eshell-ask-to-save-history nil)
(setq eshell-cmpl-cycle-completions t)
(setq eshell-history-file-name "~/.bash_history")
(setq eshell-history-size 1000000)
(setq eshell-hist-ignoredups t)

;; shell
(when (require 'shell-history nil t)
  (when (require 'anything-complete nil t)
    (add-hook 'shell-mode-hook
              (lambda ()
                (define-key shell-mode-map (kbd "C-r") 'anything-complete-shell-history)))

    (use-anything-show-completion 'anything-complete-shell-history
                                  '(length anything-c-source-complete-shell-history))))

(defun ido-eshell-history ()
  "Prompt with a completing list of unique eshell history items.

The selected item will be placed at the prompt on the eshell switched to by (eshell).
If existing, the current prompt will be deleted."
  (interactive)
  (progn
    (eshell)
    (end-of-buffer)
    (eshell-bol)
    (unless (= (point) (point-max))
      (kill-line))
    (let ((history nil)
          (index (1- (ring-length eshell-history-ring))))
      ;; taken from em-hist.el, excepting the duplicate check
      (while (>= index 0)
        (let ((hist (eshell-get-history index)))
          (when (not (member hist history))
            (setq history (cons hist history))))
        (setq index (1- index)))
      (let* ((item (if (and (boundp 'ido-mode) ido-mode)
                       (ido-completing-read "Select history item: "
                                            history)
                     (completing-read "Select history item: "
                                      history))))
        (insert item)))))
(add-hook 'eshell-mode-hook (lambda ()
                              (define-key
                                eshell-mode-map "\C-c\C-x" 'ido-eshell-history)))


(autoload 'multi-eshell "multi-eshell" t)
(setq multi-eshell-name "*eshell*")
(setq multi-eshell-shell-function `(eshell))

(load-library "~/.emacs.d/site-lisp/shell-toggle-patched.el")
(autoload 'shell-toggle "shell-toggle"
  "Toggles between the *shell* buffer and whatever buffer you are editing."
  t)
(autoload 'shell-toggle-cd "shell-toggle"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
(setq shell-toggle-launch-shell 'shell-toggle-eshell)


(defalias 'sh 'shell-toggle-cd)
(require 'lispxmp)

;; needed since OSX 's "ls" command is different from unix
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

(defalias 'qrr 'query-replace-regexp)

;; (require 'header2)
;; (add-hook 'emacs-lisp-mode-hook 'auto-make-header)

(require 're-builder+)

(message "LOADING: rebuilder")


(defun reb-query-replace (to-string)
  "Replace current RE from point with `query-replace-regexp'."
  (interactive
   (progn (barf-if-buffer-read-only)
          (list (query-replace-read-to (reb-target-binding reb-regexp)
                                       "Query replace" t))))
  (with-current-buffer reb-target-buffer
    (query-replace-regexp (reb-target-binding reb-regexp) to-string)))

(define-key reb-mode-map "\C-g" 'reb-quit)
(define-key reb-mode-map "\C-w" 'reb-copy)
(define-key reb-mode-map "\C-s" 'reb-next-match)
(define-key reb-mode-map "\C-r" 'reb-prev-match)
(define-key reb-mode-map "\M-%" 'reb-query-replace)

(defalias 'reb 're-builder)

(require 'text-translator)
(global-set-key "\C-x\M-t" 'text-translator)

;; options to switch enjine
;; (setq text-translator-default-engine "excite.co.jp_enja")
;; (setq text-translator-default-engine "google.com_enja")

(defun insert-translation-buffer ()
  (interactive)
  (newline)
  (insert-buffer "*translated*")
  (newline))

(defun insert-translation ()
  (interactive)
  (progn
    (text-translator nil)
    (sleep-for 1))
  (insert-translation-buffer))

(global-set-key "\C-x\M-r" 'insert-translation)

;; quick and dirty buffer menu sorting
(define-key Buffer-menu-mode-map (kbd "M-s s") '(lambda() (interactive) (Buffer-menu-sort 2)))
(define-key Buffer-menu-mode-map (kbd "M-s d") '(lambda() (interactive) (Buffer-menu-sort 3)))
(define-key Buffer-menu-mode-map (kbd "M-s f") '(lambda() (interactive) (Buffer-menu-sort 4)))
(define-key Buffer-menu-mode-map (kbd "M-s g") '(lambda() (interactive) (Buffer-menu-sort 5)))

(autoload 'espresso-mode "espresso" "Javascript mode" t)
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js" . espresso-mode))

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(message "LOADING: javascript espresso")

(defun espresso-custom-setup ()
  (setq tab-width 4)
  (moz-minor-mode 1))

(add-hook 'espresso-mode-hook 'espresso-custom-setup)

;; quick thumbs mode navigation
(add-hook 'thumbs-mode-hook (lambda ()
                              (define-key thumbs-mode-map (kbd "j") 'next-line)
                              (define-key thumbs-mode-map (kbd "k") 'previous-line)
                              (define-key thumbs-mode-map (kbd "n") 'next-line)
                              (define-key thumbs-mode-map (kbd "p") 'previous-line)
                              (define-key thumbs-mode-map (kbd "l") 'forward-char)
                              (define-key thumbs-mode-map (kbd "h") 'backward-char)
                              (define-key thumbs-mode-map (kbd "f") 'forward-char)
                              (define-key thumbs-mode-map (kbd "b") 'backward-char)))

;; image view mode
(add-hook 'thumbs-view-image-mode-hook (lambda ()
                                         (define-key thumbs-view-image-mode-map (kbd "j") 'thumbs-next-image)
                                         (define-key thumbs-view-image-mode-map (kbd "k") 'thumbs-previous-image)
                                         (define-key thumbs-view-image-mode-map (kbd "n") 'thumbs-next-image)
                                         (define-key thumbs-view-image-mode-map (kbd "p") 'thumbs-previous-image)
                                         (define-key thumbs-view-image-mode-map (kbd "f") 'thumbs-next-image)
                                         (define-key thumbs-view-image-mode-map (kbd "b") 'thumbs-previous-image)
                                         (define-key thumbs-view-image-mode-map (kbd "Q") '(lambda()
                                                                                             (interactive)
                                                                                             (thumbs-display-thumbs-buffer)
                                                                                             (thumbs-kill-buffer)))))

(mouse-avoidance-mode 'exile)

(require 'cache)
(require 'c-eldoc)
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

(require 'goto-chg)

;; (require 'slack-rtm)

(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)

(require 'htmlutils)

(load-file "~/.emacs.d/site-lisp/anything-git-project.el")

(require 'auto-highlight-symbol-config)
(add-to-list 'ahs-modes 'scala-mode)

(set-face-attribute 'ahs-face nil :foreground "Black" :background "LightBlue2")
(set-face-attribute 'ahs-plugin-defalt-face nil :foreground "Black" :background "Orange1")

(setq disabled-command-function nil)

(require 'window-numbering)
(window-numbering-mode nil)

(require 'window-number)
(window-number-mode t)
(autoload 'window-number-meta-mode "window-number"
  "A global minor mode that enables use of the M- prefix to select
windows, use `window-number-mode' to display the window numbers in
the mode-line."
  t)

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))



(load "~/.emacs.d/nxhtml/autostart.el")
(setq mumamo-chunk-coloring 'no-chunks-colored)


(require 'gse-number-rect)
(global-set-key "\C-hj" 'number-rectangle)

(require 'nazna)

(require 'dired-copy-paste)

(require 'rainbow-mode)

(require 'move-region)

(require 'bm)

(when (require 'auto-mark nil t)
  (setq auto-mark-command-class-alist
        '((anything . anything)
          (goto-line . jump)
          (indent-for-tab-command . ignore)
          (undo . ignore)))
  (setq auto-mark-command-classifiers
        (list (lambda (command)
                (if (and (eq command 'self-insert-command)
                         (eq last-command-char ? ))
                    'ignore))))
  (global-auto-mark-mode 1))

(defalias 'dj 'dired-jump-other-window)

(require 'generic-x)

(autoload 'tidy-buffer "tidy" "Run Tidy HTML parser on current buffer" t)
(autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
(autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
(autoload 'tidy-build-menu "tidy" "Install an options menu for HTML Tidy." t)


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

(autoload 'crontab-edit "crontab"
  "Function to allow the easy editing of crontab files." t)
(autoload 'crontab-mode "crontab-mode" "font-locking for crontab" t)

(add-to-list 'auto-mode-alist '("\\.cron\\(tab\\)?\\'" . crontab-mode))
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\.[^el]+" . crontab-mode))

(message "LOADING: crontab")

(cond
 ((>= emacs-major-version '23)
  (progn
    (setq x-select-enable-clipboard t)
    (set-clipboard-coding-system 'utf-8)

    (require 'zlc)
    (zlc-mode t)
    (setq zlc-select-completion-immediately nil)
    (setq delete-by-moving-to-trash nil))))

(require 'savekill)

(message "LOADING: savekill")

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

(require 'sequential-command-config)
(sequential-command-setup-keys)

(require 'transpose-frame)

(add-to-list 'auto-mode-alist
             '("/\\(rfc\\|std\\)[0-9]+\\.txt\\'" . rfcview-mode))
(autoload 'rfcview-mode "rfcview" nil t)

(autoload 'get-rfc-view-rfc "get-rfc" "Get and view an RFC" t nil)
(autoload 'get-rfc-view-rfc-at-point "get-rfc" "View the RFC at point" t nil)
(autoload 'get-rfc-grep-rfc-index "get-rfc" "Grep rfc-index.txt" t nil)
(setq get-rfc-local-rfc-directory "~/Dropbox/rfc/")
(setq get-rfc-open-in-new-frame nil)

(require 'google)
(defalias 'g 'google-code)

(require 'elisp-format)

(require 'color-moccur)
(require 'moccur-edit)
(setq moccur-split-word t)
(global-set-key (kbd "C-c o") 'occur-by-moccur)

(message "LOADING: moccur")

;; adapted from
;; http://d.hatena.ne.jp/derui/20100223/1266929390
(require 'viewer)
(viewer-stay-in-setup)
(setq viewer-modeline-color-unwritable "tomato"
      viewer-modeline-color-view "orange")
(viewer-change-modeline-color-setup)


(setq view-read-only t)
(defvar pager-keybind
  `( ;; vi-like
    ("a" . ,(lambda () (interactive)
              (let ((anything-c-moccur-enable-initial-pattern nil))
                (anything-c-moccur-occur-by-moccur))))
    (";" . anything)
    ("h" . backward-word)
    ("l" . forward-word)
    ("j" . next-line)
    ("k" . previous-line)
    ("b" . scroll-down)
    (" " . scroll-up)
    ;; w3m-like
    ;; ("m" . gene-word)
    ("i" . win-delete-current-window-and-squeeze)
    ("w" . forward-word)
    ("e" . backward-word)
    ("(" . point-undo)
    (")" . point-redo)
    ("J" . ,(lambda () (interactive) (scroll-up 1)))
    ("K" . ,(lambda () (interactive) (scroll-down 1)))
    ;; bm-easy
    ;; ("." . bm-toggle)
    ;; ("[" . bm-previous)
    ;; ("]" . bm-next)
    ;; langhelp-like
    ("c" . scroll-other-window-down)
    ("v" . scroll-other-window)
    ))

(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
          (define-key keymap key cmd))))
  keymap)

(defadvice find-file
  (around find-file-switch-to-view-file (file &optional wild) activate)
  (if (and (not (file-writable-p file))
           (not (file-directory-p file)))
      (view-file file)
    ad-do-it))

(message "LOADING: find file")



(which-func-mode 1)
(setq which-func-modes t)
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)

(setq header-line-format
      (list "-"
            "%b--"
            ;; Note that this is evaluated while making the list.
            ;; It makes a mode-line construct which is just a string.
            ":"
            '(:eval (current-time-string))
            " "
            '(which-func-mode ("" which-func-format))
            '(line-number-mode "L%l--")
            '(column-number-mode "C%c--")
            ))

(require 'summarye)
(defalias 'summarize-funcs 'se/make-summary-buffer)

(require 'http-twiddle)

(message "LOADING: eshell")

(defun eshell/ff (file)
  (find-file-other-window file))

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

(require 'rebound)
(rebound-mode t)


(when (and (executable-find "cmigemo")
           (require 'migemo))

  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (migemo-init))


(require 'muse-mode)
(require 'muse-html)
(require 'muse-latex)
(require 'muse-texinfo)
(require 'muse-docbook)
(require 'muse-project)
(require 'muse-journal )

(message "LOADING: muse")

(setq muse-project-alist
      '(("Journal" ("~/journal/"
                    :default "journal"))))

(require 'load-directory)

;; delete this after the power crisis
;; (require 'tepco-power-status)
;; (require 'yasima)
;; (yasima-mode)


(require 'sql)
;; (autoload 'sql-mode "sql-mode" "SQL Editing Mode" t)
(setq auto-mode-alist
      (append '(("\\.sql$" . sql-mode)
                ("\\.tbl$" . sql-mode)
                ("\\.sp$" . sql-mode))
              auto-mode-alist))

(eval-after-load "sql"
  '(lambda () (progn
                (require 'sql-indent)
                (require 'sql-transform)
                (add-hook 'sql-mode-hook
                          (function (lambda ()
                                      (local-set-key "\C-cu" 'sql-to-update)))))))

;; (defadvice sql-send-region (after sql-store-in-history)
;; "The region sent to the SQLi process is also stored in the history."
;; (let ((history (buffer-substring-no-properties start end)))
;; (save-excursion
;; (set-buffer sql-buffer)
;; (message history)
;; (if (and (funcall comint-input-filter history)
;; (or (null comint-input-ignoredups)
;; (not (ring-p comint-input-ring))
;; (ring-empty-p comint-input-ring)
;; (not (string-equal (ring-ref comint-input-ring 0)
;; history))))
;; (ring-insert comint-input-ring history))
;; (setq comint-save-input-ring-index comint-input-ring-index)
;; (setq comint-input-ring-index nil))))

;; (ad-activate 'sql-send-region)

(defun my-sqli-setup ()
  "Set the input ring file name based on the product name."
  (setq sql-input-ring-file-name
        (concat "~/." (symbol-name sql-product) "_history"))
  (setq sql-input-ring-separator "\n"))

(add-hook 'sql-interactive-mode-hook 'my-sqli-setup)

(require 'pydoc-info)

(autoload 'php-mode "php-mode")
(setq auto-mode-alist
      (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq php-mode-force-pear t)
(add-hook 'php-mode-user-hook
          '(lambda ()
             (setq php-manual-path "~/Dropbox/php_manual/")))

(require 'php-repl)

(require 'drupal-mode)
(autoload 'drupal-mode "drupal-mode" "Major mode for editing drupal php " t)


(message "LOADING: drupal")

(add-to-list 'auto-mode-alist '("\\.\\(module\\|test\\|install\\|theme\\)$" . drupal-mode))
(add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.info" . conf-windows-mode))

(require 'php-doc nil t)
(setq php-doc-directory "~/Dropbox/php_manual/")
(add-hook 'php-mode-hook
          (lambda ()
            (local-set-key "\t" 'php-doc-complete-function)
            (local-set-key (kbd "\C-c h") 'php-doc)
            (set (make-local-variable 'eldoc-documentation-function)
                 'php-doc-eldoc-function)
            (eldoc-mode 1)))

(require 'wide-n)

(require 'change-case)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(require 'delicious)

(require 'whitespace)
(setq whitespace-display-mappings '((space-mark ?\ [?\u00B7]) (newline-mark ?\n [?$ ?\n]) (tab-mark ?\t [?\u00BB ?\t])))

(require 'dabbrev-ja)

(require 'navi2ch)

(require 'fastnav)
(global-set-key "\M-z" 'fastnav-zap-up-to-char-forward)
(global-set-key "\M-Z" 'fastnav-zap-up-to-char-backward)
(global-set-key (kbd "C-c ;") 'fastnav-jump-to-char-forward)
(global-set-key (kbd "C-c ,") 'fastnav-jump-to-char-backward)

(require 'android-mode)
(setq android-mode-sdk-dir "~/android-sdk")

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
(setq ack-executable (executable-find "ack-grep"))
(setq ack-and-a-half-executable ack-executable)

(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-samee "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)


(message "LOADING: ack")

;; (require 'gtags)
;; (defun gtags-root-dir ()
;; "Returns GTAGS root directory or nil if doesn't exist."
;; (with-temp-buffer
;; (if (zerop (call-process "global" nil t nil "-pr"))
;; (buffer-substring (point-min) (1- (point-max)))
;; nil)))

;; (defun gtags-update ()
;; "Make GTAGS incremental update"
;; (call-process "global" nil nil nil "-u"))

;; (defun gtags-update-hook ()
;; (when (gtags-root-dir)
;; (gtags-update)))

;; (add-hook 'after-save-hook #'gtags-update-hook)

;; (defun ww-next-gtag ()
;; "Find next matching tag, for GTAGS."
;; (interactive)
;; (let ((latest-gtags-buffer
;; (car (delq nil (mapcar (lambda (x) (and (string-match "GTAGS SELECT" (buffer-name x)) (buffer-name x)) )
;; (buffer-list)) ))))
;; (cond (latest-gtags-buffer
;; (switch-to-buffer latest-gtags-buffer)
;; (next-line)
;; (gtags-select-it nil)))))


;; (add-hook 'gtags-mode-hook
;; (lambda()
;; (local-set-key [(control meta ,)] 'ww-next-gtag)
;; (local-set-key (kbd "M-.") 'gtags-find-tag) ; find a tag, also M-.
;; (local-set-key (kbd "M-,") 'gtags-find-rtag))) ; reverse tag

;; (require 'elscreen)
;; (require 'elscreen-w3m)
;; (require 'elscreen-color-theme)
;; (require 'elscreen-server)
;; (require 'elscreen-wl)
;; (require 'elscreen-dired)
;; (require 'elscreen-gf)

(message "LOADING: elscreen")

(require 'multiple-line-edit)
(global-set-key "\C-c<" 'mulled/edit-trailing-edges)
(global-set-key "\C-c>" 'mulled/edit-leading-edges)


(require 'auto-indent-mode)
;; (auto-indent-global-mode)

(defmacro append-to-list (to lst)
  `(setq ,to (append ,lst ,to)))

;; FIXME: probably doesn't work
;; (append-to-list auto-indent-disabled-modes-list '("makefile-automake-mode" "makefile-gmake-mode" "makefile-makepp-mode" "makefile-bsdmake-mode" "makefile-imake-mode"))

(append-to-list auto-indent-disabled-modes-list '(makefile-automake-mode makefile-gmake-mode makefile-makepp-mode makefile-bsdmake-mode makefile-imake-mode))

(require 'smartchr)

(defun smartchr-custom-keybindings ()
  (local-set-key (kbd "=") (smartchr '(" = " " == " "=")))
  (local-set-key (kbd "!") (smartchr '("!" "!=")))
  ;; !! がカーソルの位置
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  (local-set-key (kbd "-") (smartchr '("-" "->`!!'" "-=")))
  (local-set-key (kbd "+") (smartchr '("+" "++" "+=")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[ [`!!'] ]" "[")))
  (local-set-key (kbd "{") (smartchr '("{\n`!!'\n}" "{`!!'}" "{")))
  (local-set-key (kbd "`") (smartchr '("\``!!''" "\`")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\""))))

(defun smartchr-custom-keybindings-objc ()
  (local-set-key (kbd "@") (smartchr '("@\"`!!'\"" "@"))))

(add-hook 'c-mode-common-hook 'smartchr-custom-keybindings)
(add-hook 'objc-mode-hook 'smartchr-custom-keybindings-objc)

(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

(require 'rfringe)

(require 'org2blog-autoloads)

;; (defvar no-easy-keys-minor-mode-map (make-keymap)
;;   "no-easy-keys-minor-mode keymap.")

;; (let ((f (lambda (m)
;;            `(lambda () (interactive)
;;               (message (concat "No! use " ,m " instead."))))))
;;   (dolist (l '(("<left>" . "C-b") ("<right>" . "C-f") ("<up>" . "C-p")
;;                ("<down>" . "C-n")
;;                ("<C-left>" . "M-f") ("<C-right>" . "M-b") ("<C-up>" . "M-{")
;;                ("<C-down>" . "M-}")
;;                ("<M-left>" . "M-f") ("<M-right>" . "M-b") ("<M-up>" . "M-{")
;;                ("<M-down>" . "M-}")
;;                ("<delete>" . "C-d") ("<C-delete>" . "M-d")
;;                ("<M-delete>" . "M-d") ("<next>" . "C-v") ("<C-next>" . "M-x <")
;;                ("<prior>" . "M-v") ("<C-prior>" . "M-x >")
;;                ("<home>" . "C-a") ("<C-home>" . "M->")
;;                ("<C-home>" . "M-<") ("<end>" . "C-e") ("<C-end>" . "M->")))
;;     (define-key no-easy-keys-minor-mode-map
;;       (read-kbd-macro (car l)) (funcall f (cdr l)))))

;; (define-minor-mode no-easy-keys-minor-mode
;;   "A minor mode that disables the arrow-keys, pg-up/down, delete and backspace." t " no-easy-keys"
;;   'no-easy-keys-minor-mode-map :global t)

;; (no-easy-keys-minor-mode nil)

(message "LOADING: no easy keys")

;; (require 'scratch-log)
;; (setq sl-scratch-log-file "~/Dropbox/.scratch-log")
;; (setq sl-prev-scratch-string-file "~/Dropbox/.scratch-log-prev")

(require 'fuzzy-format)
(setq fuzzy-format-default-indent-tabs-mode nil)
(global-fuzzy-format-mode t)

(require 'htmlize)

(message "LOADING: ace jump")

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'clipboard-to-kill-ring)
(clipboard-to-kill-ring t)

(defun write-string-to-file (string file)
  (interactive "sEnter the string: \nFFile to save to: ")
  (with-temp-buffer
    (insert string)
    (when (file-writable-p file)
      (write-region (point-min)
                    (point-max)
                    file))))

(message "LOADING: string to file")

;; FIXME: doesn't work
;; (require 'workgroups)
;; (workgroups-mode 1)
;; (setq wg-prefix-key (kbd "C-x w"))

;; (defun load-wg ()
;;   (interactive)
;;   (let ((file "~/.emacs.d/wg"))
;;     (progn
;;       (unless (file-exists-p file)
;;         (write-string-to-file " " file))
;;       (wg-load file))))

(setq emacs-directory "~/.emacs.d/")
(setq backup-directory "~/.saves")

(require 'backups-mode)

(server-start)
;; sudo-ext requires server
(when (and (>= emacs-major-version 23) (eq window-system 'x))
  (require 'sudo-ext))

(require 'wc)

(autoload 'dictionary-search "dictionary"
  "Ask for a word and search it in all dictionaries" t)
(autoload 'dictionary-match-words "dictionary"
  "Ask for a word and search all matching words in the dictionaries" t)
(autoload 'dictionary-lookup-definition "dictionary"
  "Unconditionally lookup the word at point." t)
(autoload 'dictionary "dictionary"
  "Create a new dictionary buffer" t)
(autoload 'dictionary-mouse-popup-matching-words "dictionary"
  "Display entries matching the word at the cursor" t)
(autoload 'dictionary-popup-matching-words "dictionary"
  "Display entries matching the word at the point" t)
(autoload 'dictionary-tooltip-mode "dictionary"
  "Display tooltips for the current word" t)
(autoload 'global-dictionary-tooltip-mode "dictionary"
  "Enable/disable dictionary-tooltip-mode for all buffers" t)

;; (global-set-key "\C-hx" 'dictionary-search)
(global-set-key "\C-hx" 'dictionary-lookup-definition)
(global-set-key "\C-hz" 'dictionary-match-words)

;; these are utility commands for compiling c
(define-key mode-specific-map "q" 'compile)
(define-key mode-specific-map "x" 'recompile)
(define-key mode-specific-map "\C-z" 'shell-command)

(defun my-tabs-makefile-hook ()
  (setq indent-tabs-mode t))
(add-hook 'makefile-mode-hook 'my-tabs-makefile-hook)

(add-hook 'makefile-mode-hook
          (lambda()
            (setq show-trailing-whitespace t)))

(add-hook 'makefile-mode-hook
          (lambda()
            (auto-indent-minor-mode -1)))

(add-hook 'makefile-mode-hook 'whitespace-mode)

(setq-default indent-tabs-mode nil)


(require 'make-mode)
(define-key makefile-mode-map (kbd "RET") 'newline)

(setq compilation-auto-jump-to-first-error t)

(require 'valgrind)

(setq redisplay-dont-pause t)


(require 'frame-cmds)

;; (require 'ime-frame)

;; (defun recenter-frame ()
;;   (interactive)
;;   (if window-system
;;       (progn
;;         ;;        (fit-frame)
;;         (set-frame-size (selected-frame) 80 50)
;;         (frame-center))))

;; (recenter-frame)

(eval-after-load "man" '(require 'man-completion))

(require 'kindly-mode)
(setq kindly:use-auto-bookmark-p nil)
(setq kindly:font-face '(:family "Monaco" :height 125 :width condensed))

(require 'fit-frame)
;; (require 'autofit-frame)
;; (add-hook 'after-make-frame-functions 'fit-frame)

(setq fit-frame-max-width 80)

;; (require 'offlineimap)
(require 'mu4e)

;; (add-hook 'mu4e-main-mode-map-hook
;;           (lambda ()
;;             (define-key mu4e-main-mode-map "u" 'mu4e-update-index)))


;; use this for debugging
(setq debug-on-error nil)
;; (setq mu4e-html2text-command "w3m -dump -cols 80 -T text/html")
(setq mu4e-html2text-command "w3m -dump -T text/html")
(setq mu4e-get-mail-command "mbsync -aq")
(setq mu4e-update-interval 3000)
(add-hook 'mu4e-headers-mode-hook '(lambda () (visual-line-mode -1)))
(add-hook 'mu4e-view-mode-hook '(lambda () (kindly-mode)))
(require 'sr-speedbar)
(setq sr-speedbar-right-side t)
(add-hook 'speedbar-load-hook 'fit-frame)
(add-hook 'speedbar-load-hook '(lambda ()
                                 (interactive)
                                 (speedbar-get-focus)))


(ignore-errors
  (load-file "~/.mufolders.el"))

(defun wolfram-alpha-query (term)
  (interactive (list (read-string "Ask Wolfram Alpha: " (word-at-point))))
  (require 'w3m-search)
  (w3m-browse-url (concat "http://m.wolframalpha.com/input/?i=" (w3m-search-escape-query-string
                                                                 term))))

(setq longlines-wrap-follows-window-size t)
(global-visual-line-mode)

;; (require 'ido-ubiquitous)
;; (ido-ubiquitous-mode 1)

(autoload 'elisp-slime-nav-mode "elisp-slime-nav")
(add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode t)))
(eval-after-load 'elisp-slime-nav '(diminish 'elisp-slime-nav-mode))

(require 'browse-kill-ring)


;; magic invocations to prevent encoding errors for cjk
(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-language-environment 'utf-8)
;; (set-keyboard-coding-system 'utf-8-mac) ; For old Carbon emacs on OS X only
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(unless (eq system-type 'windows-nt)
  (set-selection-coding-system 'utf-8))
(prefer-coding-system 'utf-8)

;; ucs-normalize-NFC-region で濁点分離を直す
;; M-x ucs-normalize-NFC-buffer または "C-x RET u" で、
;; バッファ全体の濁点分離を直します。
;; 参考：
;; http://d.hatena.ne.jp/nakamura001/20120529/1338305696
;; http://www.sakito.com/2010/05/mac-os-x-normalization.html

(require 'ucs-normalize)
(prefer-coding-system 'utf-8-hfs)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)

(defun ucs-normalize-NFC-buffer ()
  (interactive)
  (ucs-normalize-NFC-region (point-min) (point-max))
  )

(global-set-key (kbd "C-x RET u") 'ucs-normalize-NFC-buffer)


(require 'google-translate)
(setq google-translate-default-source-language "ja")
(setq google-translate-default-target-language "en")

(defun google-translate-flip-languages ()
  (interactive)
  (let* ((src-lang google-translate-default-source-language)
         (tgt-lang google-translate-default-target-language))
    (setq google-translate-default-source-language tgt-lang)
    (setq google-translate-default-target-language src-lang)))

(defun google-translate-region-or-line ()
  (interactive)
  (let (beg end)
    (progn
      (if (region-active-p)
          (setq beg (region-beginning) end (region-end))
        (setq beg (line-beginning-position) end (line-end-position)))
      (let* ((langs (google-translate-read-args nil nil))
             (source-language (car langs))
             (target-language (cadr langs)))
        (google-translate-translate
         source-language target-language
         (buffer-substring-no-properties beg end)
         ))
      )))

;; takes prefix arg to toggle languages
(defun google-translate-region-or-line ()
  (interactive)
  (let (beg end)
    (progn
      (if (region-active-p)
          (setq beg (region-beginning) end (region-end))
        (setq beg (line-beginning-position) end (line-end-position)))
      (let* ((langs (google-translate-read-args nil nil))
             (source-language (car langs))
             (target-language (cadr langs))
             (string (buffer-substring-no-properties beg end)))
        (if current-prefix-arg
            (google-translate-translate source-language target-language string)
          (google-translate-translate target-language source-language string)
          )))))

(global-set-key "\C-c\C-w" 'google-translate-at-point)
(global-set-key (kbd "C-c g") 'google-translate-region-or-line)

(require 'http-get)

(defvar alc-toppage-url "http://eow.alc.co.jp")
(defvar alc-encoding 'utf-8)
(defvar alc-encoding-str "UTF-8")
(defvar alc-http-param-alist '(("ref" . "sa")))

(defun alc-http-param ()
  (reduce #'(lambda (x y) (concat x "&" y))
          (mapcar #'(lambda (cons)
                      (format "%s=%s"
                              (first cons)
                              (http-url-encode (rest cons) alc-encoding)))
                  alc-http-param-alist)))

(defun alc-make-url (word)
  (cond ((string= word "") alc-toppage-url)
        (t (format "%s/%s/%s/?%s"
                   alc-toppage-url
                   (http-url-encode word alc-encoding)
                   alc-encoding-str
                   (alc-http-param)))))

(defun alc (arg)
  (interactive "sWORD: ")
  (browse-url (alc-make-url
               (cond ((string= arg "") (or (current-word) ""))
                     (t arg)))))

;; (global-set-key "\C-c\C-w" 'alc)


(require 'highlight-symbol)

;; (global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [(control *)] 'highlight-symbol-next)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)

(autoload 'word-count-mode "word-count"
  "Minor mode to count words." t nil)

(setq sentence-end-double-space nil)

(load-file (expand-file-name "~/.emacs.d/keymacros.el"))


(message "LOADING: window revive")

(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)

(setq revive:major-mode-command-alist-private
      '((w3m-mode . w3m)
        ("*w3m*" . w3m)))

(defalias 'resume-save 'save-current-configuration)

;; (define-key global-map (kbd "C-x S") 'save-current-configuration)
;; (define-key global-map (kbd "C-x F") 'resume)
(add-hook 'kill-emacs-hook 'save-current-configuration)


(message "LOADING: extra settings")

(setq abbrev-file-name "~/.abbrev_defs")
(setq save-abbrevs t)
(if (file-exists-p abbrev-file-name)
    (quietly-read-abbrev-file))

(setq default-abbrev-mode t)

(require 'gitconfig-mode)
(add-to-list 'auto-mode-alist '("/\\.gittrees\\'" . gitconfig-mode))

;; should restore all buffers, etc.
(resume)
(message "********** successfully initialized **********")
