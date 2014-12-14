;; Originally based on: http://www.emacswiki.org/Journal

;; Since list people have asked for this a couple times, I thought
;;the code below belongs in a more public place.  So here it is.
;;Free, GPL'd code for whoever.
;;Enjoy,
;;ken fisler
;;

(if (file-directory-p "~/dailylog/")
    (setq-default journal-dir "~/dailylog/"))

(defun journal-now ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive)                 ; permit invocation in minibuffer
  (when (> (count-lines (point-min) (point-max)) 0)
    (goto-char (point-max))
    (newline 2))
  (insert (format-time-string "%-I:%M %p"))
  (newline))

(defun journal ()
  "Open TEXT file named after today's date, format YYYY-MM-DD-Day.txt,
in subdirectory named in variable journal-dir, set in ~/.emacs,
else in $HOME."
  (interactive)
  (let* ((filename (concat (format-time-string "%Y-%m-%d-%a" nil) ".txt"))
         (journal-path (concat journal-dir filename)))
    (message "opening journal file: %s" journal-path)
    (switch-to-buffer-other-window (find-file-noselect journal-path))
    (journal-now)))

