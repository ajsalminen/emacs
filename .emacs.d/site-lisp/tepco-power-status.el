;;; Get Tepco Power Status
;;; Require: getenv, wget, perl
;;; Using API: http://denki.cuppat.net/
;;; Using CSV: http://www.tepco.co.jp/forecast/html/images/juyo-j.csv
;;; Author: @takaxp(twitter)
;;; Version:
;;;;  v0.3.1 (2011-03-25@20:11) # [FIX] Set user variable correctly
;;;   v0.2.9 (2011-03-25@15:15) # Add (tepco-power-status-csv) to show change
;;;   v0.2.1 (2011-03-25@00:59) # Show old data when source is unavailable
;;;   v0.1.5 (2011-03-24@15:59) # Compatible with an initial format
;;;   v0.1.4 (2011-03-24@14:43) # Compatible with a new format
;;;   v0.1.3 (2011-03-24@01:43) # Verify existence of a downloaded file
;;;   v0.1.2 (2011-03-23@22:26) # Set user variable
;;;   v0.1.1 (2011-03-23@21:37) # Test under linux env.
;;;   v0.1.0 (2011-03-23@20:54) # The initial release
;;; Tested: MacOSX (10.6.7), Emacs (nextstep 23.3.1, local build)
;;;         openSUSE (11.4), Emacs (23.2.1 with GTK+)
;;; Usage:
;;;   1. Put this elisp into your load-path
;;;   2. Add (require 'tepco-power-status) in your .emacs
;;;   3. M-x tepco-power-status, the current status will be shown in echo area
;;;   4. (tepco-power-status) run automatically every hour as default
;;;   X. for auto-install user, download form
;;;      http://dl.dropbox.com/u/2440/2011/tepco-power-status.el
;;; Note:
;;;   - This elisp will create a new directory in your {HOME}
;;;   - There is no warranty for this free software
;;;   - 100 man [kW] (in Japanese) = 1.00[GW]

(defvar tepco-power-data-savedir (concat (getenv "HOME") "/.tepco-power/")
  "Specify a directory to save a download file. like /path/to/the/dir/")

(defvar tepco-power-status-interval 3600
  "Specify an interval to run (tepco-power-status), 3600=1hour")

(defvar tepco-power-display-change-interval 3
  "Specify an interval to run (tepco-power-status-csv)
   after the execution of (tepco-power-status)")

(add-hook 'after-init-hook
	  '(lambda ()
	     (run-at-time nil tepco-power-status-interval 'tepco-power-status)))

(defun tepco-power-status ()
  "Show usage rate of the current tepco power generation"
  (interactive)
  (progn
    (setq tepco-power-data-file
	  (concat "denki.cuppat.net/data/"
		  (format-time-string "%Y%m%d") ".json"))
    (setq tepco-power-data-url (concat "http://" tepco-power-data-file))
    (shell-command-to-string
     (concat "wget -r " tepco-power-data-url
	     " -P " tepco-power-data-savedir ))
    (setq tepco-power-data
	  (concat tepco-power-data-savedir tepco-power-data-file))
    (setq tepco-power-data-today
	  (concat tepco-power-data-savedir "denki.cuppat.net/data/today.json"))
    (when (file-exists-p tepco-power-data)
      (tepco-power-file-copy tepco-power-data tepco-power-data-today))
    (cond ((file-exists-p tepco-power-data-today)
	   (tepco-data-read tepco-power-data-today))
	  (t
	   (message
	    "ERROR: %s is not ready. Try again later." tepco-power-data-url)))

    (sit-for tepco-power-display-change-interval)
    (tepco-power-status-csv)))

(defun tepco-data-read (tepco-power-data)
  (setq tepco-power-data-list
	(split-string
	 (shell-command-to-string
	  (concat "perl -ne '/,\(\\d+\)].*?:\(\\d+\),/;print \"$1 $2\";' "
		  tepco-power-data))))
  (setq tepco-power-result (string-to-number (car tepco-power-data-list)))
  (setq tepco-power-capacity
	(string-to-number (car (cdr tepco-power-data-list))))
  (cond ((zerop tepco-power-capacity) (setq tepco-power-used 0))
	(t (setq tepco-power-used
		 (/ (* 100 (float tepco-power-result)) tepco-power-capacity))))

  (message
   (concat " << Tepco Power Status >>                      "
	   "Used: %.1f[%s] (%.2f/%.2f[GW]) ")
   tepco-power-used "%" (/ tepco-power-result 100)
   (/ (float tepco-power-capacity) 100)))

(defun tepco-power-status-csv ()
  (interactive)
  (setq tepco-power-data-csv-filename "juyo-j.csv")
  (setq tepco-power-data-csv-file-path "www.tepco.co.jp/forecast/html/images/")
  (setq tepco-power-data-csv-url
	(concat "http://" tepco-power-data-csv-file-path
		tepco-power-data-csv-filename))
  (shell-command-to-string
   (concat "wget -r " tepco-power-data-csv-url
	   " -P " tepco-power-data-savedir ))
  (setq tepco-csv-file
	(concat tepco-power-data-savedir tepco-power-data-csv-file-path
		tepco-power-data-csv-filename))
  (message "%s" (tepco-power-status-change-string tepco-csv-file))
  (tepco-power-file-copy tepco-csv-file
			 (concat tepco-power-data-savedir
				 tepco-power-data-csv-file-path
				 (format-time-string "%Y%m%d") ".csv")))

(defun tepco-power-status-change-string (tepco-csv-file)
  (setq data-list
	(split-string
	 (shell-command-to-string
	  (concat "perl -ne '/,\(.+\),\(\\d+\),\(\\d+\)/;print \"$1 $2 $3 \";' "
			  tepco-csv-file))))
  (setq yesterday-result 0)
  (setq today-result 0)
  (let ((current-index 1))
    (while (and (not (string= "0" (nth current-index data-list)))
		(< current-index (length data-list)))
      (setq today-result (nth current-index data-list))
      (setq yesterday-result (nth (+ current-index 1) data-list))
      (setq current-index (+ current-index 3)))
    (setq used-change
	  (/ (float (- (string-to-number today-result)
		       (string-to-number yesterday-result))) 100)))
  (concat " << Tepco Power Status >>                      "
	  (if (< 0 used-change)
	      "Status: OVER (Change +"
	    "Status: GOOD (Change ")
	  (format "%.2f" used-change) "[GW])"))

(defun tepco-power-file-copy (source-file copy-file)
  (save-excursion
    (set-buffer (find-file-noselect source-file))
    (write-region (point-min) (point-max) copy-file nil 0)
    (kill-buffer)))

(provide 'tepco-power-status)
