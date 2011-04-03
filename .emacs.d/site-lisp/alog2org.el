;; Based on
;; Author: Magnus Henoch <magnus.henoch@gmail.com>
;; URL: http://bitbucket.org/legoscia/of2org

;; This is a simple script to import activity tracking from aloggers into org files

(defun alog2org (org-file)
  (interactive "fOrg mode file to create: ")
  (let ((of-data (csv-parse-buffer t)))
    ;; So now we have an alist with keys "Task ID", "Type" (only
    ;; "Inbox", "Action" or "Project", it seems), "Task", "Project",
    ;; "Context", "Start Date", "Due Date", "Completion Date",
    ;; "Duration", "Flagged" and "Notes".
    (with-temp-file org-file
      (org-mode)
      (dolist (entry of-data)
	(let (
	      ;; Task ID contains one dot per level, minus one.
	      (level (1+ (count ?. (alog2org-get "Task ID" entry))))
	      (type (alog2org-get "Type" entry))
	      (task (or (alog2org-get "¥«¥Æ¥´¥ê" entry) "unnamed task"))
	      ;; We don't need Project, as it's evident from the hierarchy.
	      (context (alog2org-get "Context" entry))
	      (start-date (alog2org-get "Started" entry))
	      (due-date (alog2org-get "Due Date" entry))
	      (completion-date (alog2org-get "Finished" entry))
	      (duration (alog2org-get "Duration" entry))
	      (flagged (alog2org-get "Flagged" entry))
	      (notes (alog2org-get "Notes" entry)))
	  (when (string= type "Inbox")
	    ;; Inbox doesn't have a name; let's give it one.
	    (setq task "Inbox"))
	  (let ((todo-state " "))
	    (insert (make-string level ?*) todo-state task "\n"))
	  ;; (org-entry-put (point) "Type" type)
	  (when context
	    (org-toggle-tag context 'on)
	    (org-entry-put (point) "Context" context))
	  (when start-date (org-clock-in nil (alog2org-parse-date start-date)))
	  (when due-date (org-clock-out t (alog2org-parse-date due-date)))
	  (when completion-date (org-add-planning-info 'closed (alog2org-parse-date completion-date)))
	  (when duration
	    ;; It seems that OmniFocus always stores effort as 42m.
	    ;; `string-to-number' ignores trailing non-digits, so it's
	    ;; perfect.
	    (let ((minutes (string-to-number duration)))
	      (org-entry-put (point) org-effort-property
			     (format "%d:%02d" (/ minutes 60) (% minutes 60)))))
	  (when (string= flagged "1")
	    (org-toggle-tag "flagged" 'on))
	  (when notes (insert notes "\n")))))))

(defun alog2org-get (key alist)
  "Get the value for KEY in ALIST, unless it is the empty string.
Return nil if KEY is not present in ALIST, or if the value for
KEY is the empty string."
  (let ((value (cdr (assoc key alist))))
    (and (not (zerop (length value))) value)))

(defun alog2org-parse-date (string)
  (date-to-time (replace-regexp-in-string "/" "-" string)))

(provide 'alog2org)