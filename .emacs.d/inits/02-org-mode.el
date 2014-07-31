;; org-modeを利用するための設定
(require 'org-install)
(require 'org-clock)
(require 'org-timer)
(require 'org-habit)

(require 'google-weather)
(require 'org-google-weather)
(require 'org-pomodoro)

(defun custom-org-agenda-mode-defaults ()
  (org-defkey org-agenda-mode-map "I" 'org-pomodoro)
  (org-defkey org-agenda-mode-map "O" 'org-pomodoro)
  (org-defkey org-agenda-mode-map (kbd "C-c C-x C-i") 'org-pomodoro)
  (org-defkey org-agenda-mode-map (kbd "C-c C-x C-o") 'org-pomodoro))

(defalias 'op 'org-pomodoro)

(add-hook 'org-agenda-mode-hook 'custom-org-agenda-mode-defaults 'append)

(define-key global-map "\C-cc" 'org-capture)

(setq org-export-with-sub-superscripts nil)
(setq org-startup-indented t)
(setq org-agenda-tags-column -79)
(setq org-tags-column -40)

(setq org-startup-truncated nil)
(setq org-return-follows-link t)

(setq org-agenda-include-diary t)
(setq org-agenda-window-setup 'other-frame)
(setq org-agenda-restore-windows-after-quit t)

;; (setq org-agenda-clockreport-parameter-plist '(:link nil :maxlevel 2 :fileskip0 t :compact t))
(setq org-agenda-clockreport-parameter-plist '(:link nil :maxlevel 2 :fileskip0 t :compact t :timestamp t :properties ("fee" "chars" "rate") :formula "$5=if($4 > 0,round($3/$4), string(\"\"))::@2$3=vsum(@2$3..@>$3)::@2$4=vsum(@2$4..@>$4)"))




;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
(setq org-agenda-files (list "~/org"))

(setq org-tag-faces
      '(("trans" .(:italic t :background "DodgerBlue1"))
        ("work" . (:italic t :background "dark blue"))))

(setq org-capture-templates
      '(("i" "Inbox" entry (file+headline "~/org/todo.org" "Inbox") "** TODO %? \n %i :inbox: %a \n SCHEDULED: %T \n %U")
        ("r" "Research" entry (file+headline "~/org/diss.org" "Research") "** TODO %? :research: \n %a")
        ("e" "Translation" entry (file+headline "~/org/trans.org" "Translation")  "** TODO %? :trans: \n :PROPERTIES: \n :type: %^{type|standard|pro|proofreading} \n :lang: %^{lang|je|ej} \n :END:\n %^{fee}p \n %^{chars}p \n :SCHEDULED: %t \n")
        ("T" "Writing" entry (file+headline "~/org/write.org" "Writing") "** TODO %? :write: \n %a")
        ("w" "Work" entry (file+headline "~/org/work.org" "Work") "** TODO %? :work: \n SCHEDULED: %t \n")
        ("l" "RIL" entry (file+headline "~/org/ril.org" "Ril") "** TODO %? :ril: \n %a")
        ("d" "Dev" entry (file+headline "~/org/dev.org" "Dev") "** TODO %? :dev: %i %a")
        ("h" "HJ" entry (file+headline "~/org/hj.org" "HJ") "* TODO %? :hj: \n \n Entered on %U\n %i\n %a")
        ("a" "Activity" entry (file+headline "~/org/activity.org" "Activity") "** TODO %? :activity: \n %a")
        ("p" "Personal" entry (file+headline "~/org/personal.org" "Personal") "* TODO %? :personal: \n SCHEDULED: %t \n \nEntered on %U\n %i\n %a")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
        ("DEFERRED" . shadow)
        ("CANCELED" . (:foreground "blue" :weight bold))))



;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-agenda-skip-unavailable-files t)
(setq org-log-done-with-time t)


(setq org-default-notes-file (concat org-directory "memo.org"))
(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "PENDING(p)" "|" "DONE(d!)" "CANCELED(c@)")))

(setq org-todo-keyword-faces
      '(("PENDING" . (:foreground "purple" :weight bold))))

;;(setq org-refile-targets (quote ((org-agenda-files :regexp . "*"))))
(setq org-refile-targets (quote ((org-agenda-files :level . 1))))


(setq org-clock-persist 'history)
(setq org-clock-mode-line-total 'current)
(org-clock-persistence-insinuate)

(setq org-timer-timer-is-countdown t)



;;copied straight from org, don't redisplay frames after push
(defun org-mobile-push-unobtrusive ()
  (interactive)
  (let ((a-buffer (get-buffer org-agenda-buffer-name)))
    (let ((org-agenda-buffer-name "*SUMO*")
          (org-agenda-filter org-agenda-filter)
          (org-agenda-redo-command org-agenda-redo-command))
      (save-window-excursion
        (org-mobile-check-setup)
        (org-mobile-prepare-file-lists)
        (run-hooks 'org-mobile-pre-push-hook)
        (message "Creating agendas...")
        (let ((inhibit-redisplay t)) (org-mobile-create-sumo-agenda))
        (message "Creating agendas...done")
        (org-save-all-org-buffers) ; to save any IDs created by this process
        (message "Copying files...")
        (org-mobile-copy-agenda-files)
        (message "Writing index file...")
        (org-mobile-create-index-file)
        (message "Writing checksums...")
        (org-mobile-write-checksums)
        (run-hooks 'org-mobile-post-push-hook)))
    (message "Files for mobile viewer staged")))


(setq org-timer-default-timer 25)
(setq org-clock-string-limit 35)

(add-hook 'org-clock-in-hook '(lambda ()
                                (if (not org-timer-current-timer)
                                    (org-timer-set-timer '(25)))))

(add-hook 'org-clock-out-hook '(lambda ()
                                 (org-timer-cancel-timer)
                                 (setq org-mode-line-string nil)))



(add-hook 'org-capture-after-finalize-hook '(lambda() (org-agenda-redo)))

(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 70)
(setq org-enforce-todo-dependencies t)

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states) ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(remove-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(defun org-cmp-title (a b)
  "Compare the titles of string A and B"
  (cond ((string-lessp a b) -1)
        ((string-lessp b a) +1)
        (t nil)))

(setq org-agenda-cmp-user-defined 'org-cmp-title)

;; for when timestamps get garbled by locale
(defun org-fix-timestamp ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward org-ts-regexp-both nil)
      (org-timestamp-change 0))))

(setq org-google-weather-format "[ %i %c, %L [%l,%h] %s ]")

(defun org-clock-in-out-later (start end)
  "…"
  (interactive "nEnter start:
nEnd:")
  (message "Name is: %d, Age is: %d" start end)
  (org-clock-in nil start)
  (org-clock-out nil end))


;; "String to return to describe the weather.
;; Valid %-sequences are:
;; - %i the icon
;; - %c means the weather condition
;; - %L the supplied location
;; - %C the city the weather is for
;; - %l the lower temperature
;; - %h the higher temperature
;; - %s the temperature unit symbol"

(setq org-agenda-sorting-strategy
      '((agenda habit-up time-up alpha-up tag-up user-defined-up priority-down)
        (todo user-defined-up todo-state-up priority-up effort-down)
        (tags user-defined-up)
        (search category-keep)))

(setq org-timer-default-timer 25)

(add-hook 'org-clock-in-hook '(lambda ()
                                (if (not org-timer-current-timer)
                                    (org-timer-set-timer '(16)))))

(setq org-agenda-custom-commands
      '(("W" tags "work")
        ("w" tags-todo "work")
        ("g" tags-todo "trans")
        ("j" todo "WAIT"
         (tags-todo "work"))
        ("J" todo-tree "WAIT")
        ("h" agenda ""
         ((org-agenda-show-all-dates nil)))
        ("o" "Agenda and Office-related tasks"
         ((agenda)
          (tags-todo "work")))
        ("U" tags "work"
         ((org-show-following-heading nil)
          (org-show-hierarchy-above nil)))
        ("f" "flagged" tags ""
         ((org-agenda-files
           '("~/org/flagged.org"))))
        ("z" "Agenda and Office-related tasks"
         ((agenda)
          (org-agenda-files
           '("~/org/flagged.org"))))
        ("c" agenda "work"
         ((org-agenda-ndays 1)
          (org-scheduled-past-days 900)
          (org-deadline-warning-days 0)
          (org-agenda-filter-preset
           '("+work"))))))

(setq org-icalendar-use-scheduled '(todo-start event-if-todo))

(setq system-time-locale "C")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook 'turn-on-font-lock) ; Org buffers only
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map "C" 'cfw:open-org-calendar)))
;;(add-hook 'org-mode-hook 'smart-tab-mode-off)


(defun org-mobile-pullpush ()
  (interactive)
  (save-excursion
    (progn
      (org-mobile-pull)
      (org-mobile-push-unobtrusive)
      (message "all org mobile files pushed"))))

(defun org-sync-mobile-after-save (&optional force)
  (interactive)
  (when (and (eq major-mode 'org-mode)
             (member buffer-file-name org-agenda-files))
    (save-excursion
      (org-mobile-pullpush))))

(defadvice org-save-all-org-buffers (after sync-all-mobile-org-after-saving-in-agenda last)
  (org-sync-mobile-after-save))

(defadvice org-agenda-exit (after sync-all-mobile-org-after-saving-in-agenda-exit activate)
  (org-sync-mobile-after-save))

;; (ad-deactivate 'org-save-all-org-buffers)
;; (ad-activate 'org-save-all-org-buffers)
;; (ad-deactivate 'org-agenda-exit)
;; (ad-activate 'org-agenda-exit)

;; (require 'deferred)
;; (run-at-time t 3600 (lambda () (deferred:call(org-mobile-pullpush))))

(defun org-read-date-and-adjust-timezone ()
  (date-to-time (format "%s %s" (org-read-date t) (car (cdr (current-time-zone))))))

(defun org-clock-in-and-out ()
  (interactive)
  (progn
    (org-clock-in nil (org-read-date-and-adjust-timezone))
    (org-clock-out nil (org-read-date-and-adjust-timezone))))

(define-key org-mode-map (kbd "\C-c i") 'org-clock-in-and-out)
(define-key org-mode-map (kbd "C-'") 'smex)


(message "LOADING: org-mode stuff")
