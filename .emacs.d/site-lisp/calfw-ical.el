;;; calfw-ical.el --- calendar view for ical format

;; Copyright (C) 2011  SAKURAI Masashi

;; Author: SAKURAI Masashi <m.sakurai at kiwanami.net>
;; Keywords: calendar

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A bridge from ical to calfw.
;; The API and interfaces have not been confirmed yet.

;;; Installation:

;; Here is a minimum sample code:
;; (require 'calfw-ical)
;; (cfw:install-ical-schedules)
;; (setq cfw:ical-calendar-contents-sources '("http://www.google.com/calendar/ical/.../basic.ics"))

;; Executing the following command, this program clears caches to refresh the ICS data.
;; (cfw:ical-calendar-clear-cache)

;;; Code:

(require 'calfw)
(require 'icalendar)
(require 'url)

(defun cfw:decode-to-calendar (dec)
  (cfw:date
   (nth 4 dec) (nth 3 dec) (nth 5 dec)))

(defun cfw:ical-event-get-dates (event)
  "Return date-time information from iCalendar event object:
period event (list 'period start-date end-date), time span
event (list 'time date start-time end-time).  The period includes
end-date.  This function is copied from
`icalendar--convert-ical-to-diary' and modified.  Recursive
events have not been supported yet."
  (let*
      ((dtstart (icalendar--get-event-property event 'DTSTART))
       (dtstart-zone (icalendar--find-time-zone
                      (icalendar--get-event-property-attributes event 'DTSTART) zone-map))
       (dtstart-dec (icalendar--decode-isodatetime dtstart nil dtstart-zone))
       (start-d (cfw:decode-to-calendar dtstart-dec))
       (start-t (icalendar--datetime-to-colontime dtstart-dec))

       (dtend (icalendar--get-event-property event 'DTEND))
       (dtend-zone (icalendar--find-time-zone
                    (icalendar--get-event-property-attributes event 'DTEND) zone-map))
       (dtend-dec (icalendar--decode-isodatetime dtend nil dtend-zone))
       (dtend-1-dec (icalendar--decode-isodatetime dtend -1 dtend-zone))

       (duration (icalendar--get-event-property event 'DURATION))

       end-d end-1-d end-t)

    (when (and dtstart
               (string=
                (cadr (icalendar--get-event-property-attributes
                       event 'DTSTART))
                "DATE"))
      (setq start-t nil))

    (when duration
      (let ((dtend-dec-d (icalendar--add-decoded-times
                          dtstart-dec
                          (icalendar--decode-isoduration duration)))
            (dtend-1-dec-d (icalendar--add-decoded-times
                            dtstart-dec
                            (icalendar--decode-isoduration duration t))))
        (if (and dtend-dec (not (eq dtend-dec dtend-dec-d)))
            (message "Inconsistent endtime and duration for %s" dtend-dec))
        (setq dtend-dec dtend-dec-d)
        (setq dtend-1-dec dtend-1-dec-d)))
    (setq end-d (if dtend-dec
                    (cfw:decode-to-calendar dtend-dec)
                  start-d))
    (setq end-1-d (if dtend-1-dec
                      (cfw:decode-to-calendar dtend-1-dec)
                    start-d))
    (setq end-t (if (and
                     dtend-dec
                     (not (string=
                           (cadr
                            (icalendar--get-event-property-attributes
                             event 'DTEND))
                           "DATE")))
                    (icalendar--datetime-to-colontime dtend-dec)
                  start-t))
    (cond
     ((and start-t (equal start-d end-d))
      (list 'time start-d start-t end-t))
     ((equal start-d end-1-d)
      (list 'time start-d "" ""))
     (t
      (list 'period start-d nil end-1-d)))))

(defun cfw:ical-convert-ical-to-calfw (ical-list)
  (let* ((event-list (icalendar--all-events ical-list))
         (error-string "") (event-ok t) (found-error nil)
         (zone-map (icalendar--convert-all-timezones ical-list))
         periods contents)

    (loop for e in event-list
          for (dtag date start end) = (cfw:ical-event-get-dates e)
          for event-ok = nil
          do
          (condition-case error-val
              (progn
                (cond
                 ;; recurring event
                 ;; TODO...

                 ;; non-recurring event
                 ;; period event
                 ((eq dtag 'period)
                  (push (list date end (icalendar--format-ical-event e)) periods)
                  (setq event-ok t))
                 ;; time event
                 ((eq dtag 'time)
                  (let ((prv (cfw:contents-get-internal date contents))
                        (line
                         (format "%s %s" start
                                 (icalendar--format-ical-event e))))
                    (if prv (nconc prv (list line))
                      (push (list date line) contents)))
                  (setq event-ok t)))

                ;; add all other elements unless the user doesn't want to have
                ;; them
                (unless event-ok
                  (message "Ignoring event \"%S\"" e)))
            (error
             (message "Ignoring event \"%s\"" e)
             (setq found-error t)
             (setq error-string (format "%s\n%s\nCannot handle this event: %s"
                                        error-val error-string e))
             (message "%s" error-string))))
    (append contents (list (cons 'periods periods)))))

(defun cfw:ical-debug (f)
  (interactive)
  (let ((buf (cfw:ical-url-to-buffer f)))
    (unwind-protect
        (pp-display-expression
         (with-current-buffer buf
           (icalendar--normalize-buffer)
           (cfw:ical-convert-ical-to-calfw
            (icalendar--read-element nil nil)))
         "*ical-debug*")
      (kill-buffer buf))))

(defvar cfw:ical-calendar-contents-sources  nil "a list of URL of iCalendar (contents)")

(defvar cfw:ical-calendar-annotations-sources  nil "a list of URL of iCalendar (annotations)")

(defvar cfw:ical-calendar-contents-sources-cache nil "[internal]")
(defvar cfw:ical-calendar-annotations-sources-cache nil "[internal]")

(defun cfw:ical-calendar-clear-cache ()
  (interactive)
  (setq cfw:ical-calendar-contents-sources-cache nil
        cfw:ical-calendar-annotations-sources-cache nil))

(defun cfw:ical-url-to-buffer (url)
  (let* ((url-code (url-generic-parse-url url))
         (type (url-type url-code)))
    (cond
     (type
      (let ((buf (url-retrieve-synchronously url))
            (dbuf (get-buffer-create "*calfw-tmp*"))
            pos)
        (unwind-protect
            (when (setq pos (url-http-symbol-value-in-buffer
                             'url-http-end-of-headers buf))
              (with-current-buffer dbuf
                (erase-buffer)
                (decode-coding-string
                 (with-current-buffer buf
                   (buffer-substring (1+ pos) (point-max)))
                 'utf-8 nil dbuf)))
          (kill-buffer buf))
        dbuf))
     (t ; assume local file
      (let ((buf (find-file-noselect (expand-file-name url) t)))
        (with-current-buffer buf (set-visited-file-name nil))
        buf)))))

(defmacro cfw:ical-with-buffer (url &rest body)
  (let (($buf (gensym)))
    `(let ((,$buf (cfw:ical-url-to-buffer ,url)))
       (unwind-protect
           (with-current-buffer ,$buf ,@body)
         (kill-buffer ,$buf)))))
(put 'cfw:ical-with-buffer 'lisp-indent-function 1)

(defun cfw:ical-normalize-buffer ()
  (save-excursion
    (goto-char (point-min))
     (while (re-search-forward "\n " nil t)
       (replace-match "")))
  (set-buffer-modified-p nil))

(defun cfw:ical-to-calendar (begin end)
  (unless cfw:ical-calendar-contents-sources-cache
    (setq cfw:ical-calendar-contents-sources-cache
          (loop for s in cfw:ical-calendar-contents-sources
                for cal-list =
                (cfw:ical-with-buffer s
                  (cfw:ical-normalize-buffer)
                  (cfw:ical-convert-ical-to-calfw
                   (icalendar--read-element nil nil)))
                with contents = nil
                do
                (loop for (date . lst) in cal-list
                      do
                      (cfw:contents-add date lst contents))
                finally return contents)))
  (loop for (date . lst) in cfw:ical-calendar-contents-sources-cache
        if (eq 'periods date)
        collect
        (cons 'periods
              (loop for (rstart rend title) in lst
                    if (and (cfw:date-less-equal-p begin rend)
                            (cfw:date-less-equal-p rstart end))
                    collect (list rstart rend title)))
        else if (cfw:date-between begin end date)
        collect (cons date lst)))

(defun cfw:ical-to-annotation (begin end)
  (unless cfw:ical-calendar-annotations-sources-cache
    (setq cfw:ical-calendar-annotations-sources-cache
          (loop for s in cfw:ical-calendar-annotations-sources
                for cal-list =
                (cfw:ical-with-buffer s
                  (cfw:ical-convert-ical-to-calfw
                   (icalendar--read-element nil nil)))
                with annotations = nil
                do
                (loop for (date . lst) in cal-list
                      do
                      (cfw:contents-add date lst annotations))
                finally return annotations)))
  (loop for (date . lst) in cfw:ical-calendar-annotations-sources-cache
        if (eq 'periods date)
        collect
        (cons 'periods
              (loop for (rstart rend title) in lst
                    if (and (cfw:date-less-equal-p begin rend)
                            (cfw:date-less-equal-p rstart end))
                    collect (list rstart rend title)))
        else if (cfw:date-between begin end date)
        collect (cons date lst)))

(defun cfw:install-ical-schedules ()
  (add-to-list 'cfw:contents-functions 'cfw:ical-to-calendar)
  (add-to-list 'cfw:annotations-functions 'cfw:ical-to-annotation))


(provide 'calfw-ical)
;;; calfw-ical.el ends here

