;; these are timers to save stuff
(run-at-time nil (* 60 5) 'org-save-all-org-buffers)

;; FIXME: too much unnecessary junk (just need the temp buffer part
(run-at-time nil (* 60 30) '(lambda ()
                              (let (clipboard-enabled-var x-select-enable-clipboard)
                                (progn
                                  (setq x-select-enable-clipboard nil)
                                  (save-current-configuration)
                                  ;; from here
                                  (setq kill-ring (cdr kill-ring))
                                  (setq kill-ring (cdr kill-ring))
                                  (setq x-select-enable-clipboard clipboard-enabled-var)
                                  (if (car kill-ring)
                                      (with-temp-buffer
                                        (insert (car kill-ring))
                                        (clipboard-kill-ring-save (goto-char (point-min)) (goto-char (point-max)))))))))
