(require 'gauth)
(require 'json)

(setq gauth-client-login-url "https://www.google.com:443/accounts/ClientLogin")

(setq gauth-authentication-header-format "accountType=HOSTED_OR_GOOGLE&Email=%s&Passwd=%s&service=cl")

;; (defvar gcal-all-calendars-url "https://www.google.com/calendar/feeds/default/allcalendars/full&alt=jsonc"
;;   "url to retrieve all calendars")

(defvar gcal-all-calendars-url "https://www.google.com/calendar/feeds/default/allcalendars/full"
  "url to retrieve all calendars")

(defvar gcal-own-calendars-url "https://www.google.com/calendar/feeds/default/owncalendars/full"
  "url to retrieve owned calendars")

(defun gcal-retrieve-all-calendars ()
  (interactive)
  (gauth-get-url gcal-own-calendars-url))



(gauth-setup-auth)
(message gauth-auth-token-string)
(message (format gauth-auth-token-header-format gauth-auth-token-string))
(gcal-retrieve-all-calendars)
