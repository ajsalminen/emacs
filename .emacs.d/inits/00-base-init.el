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
