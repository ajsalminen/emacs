;; these are timers to save stuff

(run-at-time nil (* 60 5) 'org-save-all-org-buffers)
(run-at-time nil (* 60 30) 'save-current-configuration)
