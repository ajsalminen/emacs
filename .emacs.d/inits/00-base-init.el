;;; UNCOMMENT THIS TO DEBUG TROUBLE GETTING EMACS UP AND RUNNING.
(setq debug-on-error t)
(setq eval-expression-debug-on-error t)
(setq lang "en_US")
(setq inhibit-splash-screen t)

(setq font-lock-verbose nil)
(setq byte-compile-verbose nil)
(setq bcc-cache-directory "~/.elispcache")

;; Emergency stuff that I want before debugging init files


;; Since i'm using mac ports now
(when (featurep 'mac)
  (mac-auto-ascii-mode 1))


(defun init-loader-re-load (re dir &optional sort)
  (let ((load-path (cons dir load-path)))
    (dolist (el (init-loader--re-load-files re dir sort))
      (condition-case e
          (let ((time (car (benchmark-run (load (file-name-sans-extension el))))))
            (init-loader-log (format "loaded %s. %s" (locate-library el) time)))
        (error
         ;; (init-loader-error-log (error-message-string e)) ；削除
         (init-loader-error-log (format "%s. %s" (locate-library el) (error-message-string e))) ;追加
         )))))


(mouse-avoidance-mode 'exile)
