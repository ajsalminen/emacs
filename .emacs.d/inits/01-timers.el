;; these are timers to save stuff

(run-at-time nil (* 60 5) 'org-save-all-org-buffers)
(run-at-time nil (* 60 30) '(lambda ()
                              (progn
                                (save-current-configuration)
                                (setq kill-ring (cdr kill-ring))
                                (setq kill-ring (cdr kill-ring)))))
