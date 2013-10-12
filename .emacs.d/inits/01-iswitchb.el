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

;; File Name Cache
;; http://www.emacswiki.org/emacs/FileNameCache
(eval-after-load
    "filecache"
  '(progn
     (message "Loading file cache...")
     (file-cache-add-directory-list load-path)))
