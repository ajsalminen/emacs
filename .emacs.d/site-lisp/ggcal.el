(require 'ggauth)
(require 'json)

(setq ggauth-client-login-url "https://www.google.com:443/accounts/ClientLogin")

(setq ggauth-authentication-header-format "accountType=HOSTED_OR_GOOGLE&Email=%s&Passwd=%s&service=cl")

;; (defvar ggcal-all-calendars-url "https://www.google.com/calendar/feeds/default/allcalendars/full&alt=jsonc"
;;   "url to retrieve all calendars")

(defvar ggcal-all-calendars-url "https://www.google.com/calendar/feeds/default/allcalendars/full"
  "url to retrieve all calendars")

(defvar ggcal-own-calendars-url "https://www.google.com/calendar/feeds/default/owncalendars/full"
  "url to retrieve owned calendars")

(defun ggcal-retrieve-all-calendars ()
  (interactive)
  (ggauth-get-url ggcal-own-calendars-url))



(ggauth-setup-auth)
(message ggauth-auth-token-string)
(message (format ggauth-auth-token-header-format ggauth-auth-token-string))
(ggcal-retrieve-all-calendars)

(provide 'ggcal)