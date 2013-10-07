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
