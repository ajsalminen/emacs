;;; saaxy-commands.el --- saaxy

;; Author: Konrad Scorciapino <konr@konr.mobi>
;; Keywords: Bot, productivity, personal assistant, SaaS

;;;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;;;                    Version 2, December 2004
;;;
;;; Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
;;;
;;; Everyone is permitted to copy and distribute verbatim or modified
;;; copies of this license document, and changing it is allowed as long
;;; as the name is changed.
;;;
;;;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;;;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;;;
;;;  0. You just DO WHAT THE FUCK YOU WANT TO.


;;; Commentary

;; In this file, I define some commands and well as auxiliary
;; functions.
;;
;; The command must be a function that takes two arguments: (1) a
;; string containing the command's argument, eg, "foo bar" in
;; "!command foo bar", and (2) a list of the commands, ie, '("foo"
;; "bar")
;;
;; The auxiliary functions for the services usually take some HTML and
;; shape it. The first argument, status, is required by async GET
;; function.


;;; Code

(require 'json)

;;;;;;;;;;;
;; Utils ;;
;;;;;;;;;;;

(defun parse-html (string)
  (when string
    (let* ((reg1 "<\\([^>]\\)>.*</\\1>")
           (try1 (replace-regexp-in-string reg1 #'parse-html string)))
      (or try1 string))))

(defun get-url (url)
  (let* ((buffer (url-retrieve-synchronously url))
         (data (with-current-buffer buffer
                 (goto-char (point-min))
                 (loop until (> 2 (- (line-end-position) (line-beginning-position))) doing (next-line))
                 (delete-region (point-min) (point))
                 (buffer-string))))
    (kill-buffer buffer)
    data))

(defun buffer-sans-headers (buffer)
  (let ((data (with-current-buffer buffer
                (goto-char (point-min))
                (loop until (> 2 (- (line-end-position) (line-beginning-position))) doing (next-line))
                (delete-region (point-min) (point))
                (buffer-string))))
    (kill-buffer buffer)
    data))

(defun post-url (url arglist)
  "Send arglist to URL as a POST request."
  (let ((url-request-method "POST")
        (url-request-extra-headers
         '(("Content-Type" . "application/x-www-form-urlencoded")))
        (url-request-data
         (mapconcat (lambda (arg)
                      (concat (url-hexify-string (car arg))
                              "="
                              (url-hexify-string (cdr arg))))
                    arglist
                    "&")))
    ;; if you want, replace `my-switch-to-url-buffer' with `my-kill-url-buffer'
    (get-url url)))

(defun html-entities-to-unicode (string)
  (let* ((plist '(aacute "叩" aacute "叩" acirc "但" acirc "但" acute "卒" aelig "脱" aelig "脱" agrave "à" agrave "à" alefsym "ℵ" alpha "留" alpha "留" amp "&" and "∧" ang "∠" apos "'" aring "奪" aring "奪" asymp "≈" atilde "達" atilde "達" auml "辰" auml "辰" bdquo "„" beta "硫" beta "硫" brvbar "側" bull "•" cap "∩" ccedil "巽" ccedil "巽" cedil "存" cent "蔵" chi "χ" chi "χ" circ "ˆ" clubs "♣" cong "≅" copy "息" crarr "↵" cup "∪" curren "造" dagger "‡" dagger "†" darr "↓" darr "⇓" deg "属" delta "隆" delta "隆" diams "♦" divide "歎" eacute "辿" eacute "辿" ecirc "棚" ecirc "棚" egrave "竪" egrave "竪" saaxy "∅" emsp " " ensp " " epsilon "竜" epsilon "竜" equiv "≡" eta "侶" eta "侶" eth "丹" eth "丹" euml "谷" euml "谷" euro "€" exist "∃" fnof "ƒ" forall "∀" frac12 "遜" frac14 "村" frac34 "他" frasl "⁄" gamma "粒" gamma "粒" ge "≥" gt ">" harr "↔" harr "⇔" hearts "♥" hellip "…" iacute "鱈" iacute "鱈" icirc "樽" icirc "樽" iexcl "臓" igrave "狸" igrave "狸" image "ℑ" infin "∞" int "∫" iota "旅" iota "旅" iquest "多" isin "∈" iuml "誰" iuml "誰" kappa "虜" kappa "虜" lambda "了" lambda "了" lang "〈" laquo "束" larr "←" larr "⇐" lceil "⌈" ldquo "“" le "≤" lfloor "⌊" lowast "∗" loz "◊" lrm "" lsaquo "‹" lsquo "‘" lt "<" macr "俗" mdash "—" micro "袖" middot "揃" minus "−" mu "亮" mu "亮" nabla "∇" nbsp "" ndash "–" ne "≠" ni "∋" not "測" notin "∉" nsub "⊄" ntilde "単" ntilde "単" nu "僚" nu "僚" oacute "坦" oacute "坦" ocirc "担" ocirc "担" oelig "œ" oelig "œ" ograve "嘆" ograve "嘆" oline "‾" omega "ω" omega "ω" omicron "凌" omicron "凌" oplus "⊕" or "∨" ordf "捉" ordm "尊" oslash "淡" oslash "淡" otilde "探" otilde "探" otimes "⊗" ouml "旦" ouml "旦" para "其" part "∂" permil "‰" perp "⊥" phi "φ" phi "φ" pi "π" pi "π" piv "ϖ" plusmn "賊" pound "贈" prime "″" prime "′" prod "∏" prop "∝" psi "ψ" psi "ψ" quot "\"" radic "√" rang "〉" raquo "損" rarr "→" rarr "⇒" rceil "⌉" rdquo "”" real "ℜ" reg "速" rfloor "⌋" rho "ρ" rho "ρ" rlm "" rsaquo "›" rsquo "’" sbquo "‚" scaron "邸" scaron "邸" sdot "⋅" sect "則" shy "" sigma "σ" sigma "σ" sigmaf "ς" sim "∼" spades "♠" sub "⊂" sube "⊆" sum "∑" sup "⊃" sup1 "孫" sup2 "族" sup3 "続" supe "⊇" szlig "ß" tau "τ" tau "τ" there4 "∴" theta "慮" theta "慮" thetasym "ϑ" thinsp " " thorn "綻" thorn "綻" tilde "˜" times "×" trade "™" uacute "炭" uacute "炭" uarr "↑" uarr "⇑" ucirc "短" ucirc "短" ugrave "湛" ugrave "湛" uml "即" upsih "ϒ" upsilon "υ" upsilon "υ" uuml "端" uuml "端" weierp "℘" xi "両" xi "両" yacute "箪" yacute "箪" yen "促" yuml "耽" yuml "展" zeta "龍" zeta "龍" zwj "" zwnj ""))
         (get-function (lambda (s) (or (plist-get plist (intern (substring s 1 -1))) s))))
    (replace-regexp-in-string "&[^; ]*;" get-function string)))

(defun saaxy-async-command (url function)
  (let* ((id (intern (md5 url)))
         (new `(lambda (status id)
                 (let ((result (or (ignore-errors (,function status (buffer-sans-headers (plist-get saaxy-buffers id)))) saaxy-error)))
                   (with-current-buffer (get-buffer saaxy-buffer-name)
                     (saaxy-insert-text result)
                     (saaxy-add-line))))))
    (setq saaxy-buffers (plist-put saaxy-buffers id (url-retrieve url new (list id))))
    (propertize "Running..." 'id id)))

;;;;;;;;;;;
;; Adult ;;
;;;;;;;;;;;

(defun saaxy-aux-monica (status html)
  (let* ((max 20) (try (with-temp-buffer
                         (insert html)
                         (goto-char (point-min)) (keep-lines "out.cgi")
                         (goto-char (point-min)) (flush-lines "trade=")
                         (setq saaxy-goodies nil)
                         (goto-char (point-min)) (replace-regexp ".*http" "http")
                         (goto-char (point-min)) (replace-regexp "\" title=\"" "\n")
                         (goto-char (point-min)) (replace-regexp "\".*" "")
                         (goto-char (point-min)) (replace-regexp "" "")
                         (goto-char (point-min)) (loop doing (kill-line 2) until (= (forward-line 2) 2))
                         (html-entities-to-unicode
                          (decode-coding-string (url-unhex-string (buffer-string)) 'utf-8)))))
    (loop for x = (butlast (split-string try "\n")) then (cddr x) and i = 0 then (1+ i) while (and x (> max i))
          collecting (format "%d. %s\n" i (propertize (cadr x) 'font-lock-face
                                                      `(:foreground ,(color-for (car x)))))
          into collected
          doing (let ((url (car x)))
                  (setq saaxy-goodies (plist-put saaxy-goodies i
                                                 `(name ,(car x) call (progn (browse-url ,url) "Opening page.")))))
          and finally return (apply #'concat collected))))
;;;;;;;;;;;;;;;;;;
;; Productivity ;;
;;;;;;;;;;;;;;;;;;

(defun saaxy-aux-now (args arglist)
  (let* ((cal (shell-command-to-string "cal"))
         (today (format-time-string "%d"))
         (red (lambda (x) (propertize x 'font-lock-face '(:foreground "#ffffff" :background "#ff0000"))))
         (title (lambda (x) (propertize x 'font-lock-face '(:foreground "#ffffff" :background "#000000"))))
         (cal (replace-regexp-in-string "^[^\n]\+$" title cal))
         (cal (replace-regexp-in-string today red cal))
         (hour (format-time-string "%Hh%M"))
         (hour (propertize hour 'font-lock-face `(:foreground ,(color-for hour)))))
    (format "%sIt's %s now.\n\n" cal hour)))

(defun saaxy-aux-tomatinho (mode)
  (with-temp-buffer
    (case mode
      (history (tomatinho-display-history))
      (tubes (tomatinho-display-tubes))
      (t "Nope"))
    (buffer-string)))

;;;;;;;;;;;;
;; System ;;
;;;;;;;;;;;;

(defun saaxy-aux-help (args arglist)
  (loop for x in (append saaxy-commands saaxy-custom-commands)
        and y = nil then (plist-put y (plist-get x 'class) (cons (plist-get x 'name) (plist-get y (plist-get x 'class))))
        finally return
        (loop for h = y then (cddr h) while h
              unless (and saaxy-hide-adult (equal (car h) 'adult))
              collect (cons (propertize (format "%s:\n" (car h)) 'font-lock-face '(:weight bold))
                            (mapcar (lambda (el) (format "%s, " (propertize (format "%s" el) 'font-lock-face `(:foreground ,(color-for (format "%s" (car h))))))) (cadr h)))
              into lists and finally return (apply #'concat (mapcar (lambda (el) (concat (substring (apply #'concat el) 0 -2) "\n")) lists)))))

(defun saaxy-aux-say (args arglist)
  "Says something with the festival process."
  (festival-say args)
  args)

;;;;;;;;;
;; Web ;;
;;;;;;;;;

(defun saaxy-aux-trans (args arglist)
  (let* ((command "transmission-remote -l")
         (res (shell-command-to-string command))
         (lines (mapcar #'split-string (butlast (split-string res "\n"))))
         (header (car lines)) (lines (cdr (butlast lines)))
         (header (butlast header))
         (alist (mapcar (lambda (k) (loop for h = header then (cdr h) and x = k then (cdr x)
                                     while h collect (list (intern (car h)) (car x)) into alist and finally return
                                     (cons (list 'data (substring (apply #'concat (mapcar (lambda (y) (concat " " y)) x)) 1)) alist))) lines)))
    (propertize res 'font-lock-face `(:foreground ,(color-for "k+t = ♥")))))


(defun saaxy-aux-freebase (status raw)
  (let* ((max 10)
         (json (json-read-from-string (html-entities-to-unicode (decode-coding-string (url-unhex-string raw) 'utf-8))))
         (children (map 'list 'identity (cdr (assoc 'result json)))))
    (loop for x in children and i upto max
          collecting (format "%d. (+%d) %s%s\n" i (floor (cdr (assoc 'score x)))
                             (propertize (cdr (assoc 'name x)) 'font-lock-face `(:foreground ,(color-for (cdr (assoc 'name x)))))
                             (let ((data (cdr (assoc 'notable x))))
                               (if (not data) "" (format " (%s)" (cdr (assoc 'name data))))))
          into collected doing (let* ((mid (cdr (assoc 'mid x))) (name (cdr (assoc 'name x)))
                                      (url (format "http://www.freebase.com/view%s" mid)))
                                 (setq saaxy-goodies (plist-put saaxy-goodies i `(name ,name mid ,mid call (progn (browse-url ,url) "Opening page.")))))
          finally return (apply #'concat collected))))

(defun saaxy-aux-reddit (status raw)
  (let* ((max 10)
         (json (json-read-from-string (html-entities-to-unicode (decode-coding-string (url-unhex-string raw) 'utf-8))))
         (children (map 'list (lambda (x) (cdr (assoc 'data x))) (cdr (assoc 'children (assoc 'data json)))))
         (sorted (sort children (lambda (a b) (> (cdr (assoc 'score a))  (cdr (assoc 'score b)))))))
    (loop for x in children and i upto max
          collecting (format "%d. (+%d) %s%s\n" i (cdr (assoc 'score x))
                             (propertize (cdr (assoc 'title x)) 'font-lock-face `(:foreground ,(color-for (cdr (assoc 'title x)))))
                             (let ((data (cdr (assoc 'selftext x))))
                               (if (string=  "" data) "" (format "\n\t%s" (substring (replace-regexp-in-string "\n" " / " data) 0 (min (length data) 140))))))
          into collected doing (let ((url (cdr (assoc 'url x))) (title (cdr (assoc 'title x))))
                                 (setq saaxy-goodies (plist-put saaxy-goodies i `(name ,title call (progn (browse-url ,url) "Opening page.")))))
          finally return (apply #'concat collected))))

(defun saaxy-aux-ddg (status html)
  (with-temp-buffer
    (insert html)
    (goto-char (point-min)) (keep-lines "a.*result-link") (flush-lines "/y.js")
    (setq saaxy-goodies nil)
    (goto-char (point-min)) (replace-regexp ".*href=\"" "")
    (goto-char (point-min)) (replace-regexp "\" class[^<]*>" "\n")
    (goto-char (point-min)) (replace-regexp "<[^>]*>" "")
    (goto-char (point-min)) (replace-regexp "" "")
    (loop for x = (butlast (split-string (html-entities-to-unicode (decode-coding-string (url-unhex-string (buffer-string)) 'utf-8)) "\n"))
          then (cddr x) and i = 0 then (1+ i) while (and x (> 10 i))
          collecting (format "%d. %s\n\t%s\n" i (propertize (car x) 'font-lock-face `(:foreground ,(color-for (car x)))) (cadr x))
          into collected doing (let ((url (car x))) (setq saaxy-goodies (plist-put saaxy-goodies i `(name ,(car x) call (progn (browse-url ,url) "Opening page.")))))
          and finally return (apply #'concat collected))))

(defun saaxy-aux-wa (status html)
  (with-temp-buffer
    (insert html)
    (goto-char (point-min)) (replace-regexp "<" "\n<")
    (goto-char (point-min)) (replace-regexp "<img.*alt=\"" "♥")
    (goto-char (point-min)) (replace-regexp "<h2>" "♥")
    (goto-char (point-min)) (keep-lines "♥")
    (goto-char (point-min)) (replace-regexp "\".*" "")
    (goto-char (point-min)) (replace-regexp "♥" "")
    (goto-char (point-min)) (flush-lines "loading")
    (goto-char (point-min)) (flush-lines "Computing")
    (goto-char (point-min)) (replace-regexp "\\\\n" "\n")
    (goto-char (point-min))
    (loop for case-fold-search = nil while (ignore-errors (search-forward-regexp ":$"))
          doing (put-text-property (line-beginning-position) (line-end-position) 'font-lock-face '(:weight bold)))
    (html-entities-to-unicode (buffer-string))))

;;;;;;;;;;;;;;;
;; Languages ;;
;;;;;;;;;;;;;;;

(defun saaxy-aux-au (status html)
  (with-temp-buffer
    (insert html)
    (goto-char (point-min))
    (keep-lines "meta name=\"description")
    (replace-regexp ".*content=\"" "")
    (replace-regexp "\".*" "")
    (goto-char (point-min))
    (replace-regexp "/" "\n")
    (html-entities-to-unicode (buffer-string))))

(defun saaxy-aux-mic (status html)
  (with-temp-buffer
    (insert html)
    (goto-char (point-min))
    (keep-lines "palavraCom")
    (htmlr-render)
    (goto-char (point-min))
    (loop for x = 1 then (1+ x)
          while (ignore-errors (search-forward (format "%d" x)))
          doing (progn (backward-char (1+ (/ x 10))) (insert "\n")))
    (html-entities-to-unicode (buffer-string))))

(defun saaxy-aux-por (status html)
  (with-temp-buffer
    (insert html)
    (goto-char (point-min))
    (keep-lines "dolEntra")
    (htmlr-render)
    (goto-char (point-min))
    (loop for x = 1 then (1+ x)
          while (ignore-errors (search-forward (format "%d" x)))
          doing (progn (backward-char (1+ (/ x 10))) (insert "\n")))
    (html-entities-to-unicode
     (decode-coding-string (url-unhex-string (buffer-string)) 'utf-8))))

(defun saaxy-aux-vadio (status html)
  (with-temp-buffer
    (insert html)
    (goto-char (point-min)) (search-forward-regexp "Palavra.*Termina")
    (delete-region (point-min) (line-end-position))
    (search-forward-regexp "<hr>")
    (delete-region (line-beginning-position) (point-max))
    (goto-char (point-min)) (replace-regexp "<br>\n" ", ")
    (delete-region (- (point-max) 2) (point-max))
    (insert "\n")
    (decode-coding-string (url-unhex-string (buffer-string)) 'utf-8)))

(defun saaxy-aux-latin (status html)
  (with-temp-buffer
    (insert html)
    (goto-char (point-min)) (search-forward-regexp "<pre>")
    (delete-region (point-min) (line-end-position))
    (search-forward-regexp "</pre>")
    (delete-region (line-beginning-position) (point-max))
    (decode-coding-string (url-unhex-string (buffer-string)) 'utf-8)))

(defun saaxy-aux-wordnet-call (a al)
  (saaxy-async-command (format "http://wordnetweb.princeton.edu/perl/webwn?s=%s" (url-hexify-string a)) #'saaxy-aux-wordnet))

(defun saaxy-aux-wordnet (status html)
  (with-temp-buffer
    (insert html)
    (setq saaxy-goodies nil)
    (goto-char (point-min))
    (search-forward "<h3>") (delete-region (point-min) (- (point) 4))
    (search-forward "</div>") (delete-region (point) (point-max))
    (goto-char (point-min)) (replace-regexp "<a[^>]*>S:</a>" "")
    (goto-char (point-min)) (replace-regexp "<li>\\(.*\\)</li>" "* \\1")
    (goto-char (point-min)) (replace-regexp "</?ul>\n?" "\n")
    (goto-char (point-min))
    (loop while (re-search-forward "<b>\\(.*\\)</b>" nil t) doing (replace-match "\\1" nil nil nil 0)
          (put-text-property (match-beginning 0) (match-end 0) 'font-lock-face '(:weight bold)))
    (goto-char (point-min))
    (loop while (re-search-forward "<h3>\\(.*\\)</h3>" nil t) doing (replace-match "\\1" nil nil nil 0)
          do (put-text-property (match-beginning 0) (match-end 0) 'font-lock-face '(:family "DejaVu Sans" :height 150 :width semi-condensed)))
    (goto-char (point-min))
    (loop while (re-search-forward "<i>\\(.*\\)</i>" nil t) doing (replace-match "\\1" nil nil nil 0)
          do (put-text-property (match-beginning 0) (match-end 0) 'face 'italic))
    (goto-char (point-min))
    (loop for i = 0 then (1+ i) while (re-search-forward "<a href=\".*&amp;s=\\(.*\\)\">\\(.*\\)</a>" nil t)
          do (replace-match "\\2" nil nil nil 0)
          do (put-text-property (match-beginning 0) (match-end 0) 'font-lock-face `(:foreground ,(color-for (match-string 0)) :weight bold))
          do (progn (goto-char (match-end 0)) (insert (format "[%d]" i)))
          do (setq saaxy-goodies (plist-put saaxy-goodies i `(name ,(match-string 0) call (saaxy-aux-wordnet-call ,(match-string 0) nil)))))
    (goto-char (point-min)) (replace-regexp "<[^>]*>" "")
    (buffer-string)))

;;;;;;;;;;;;;;;;;;;;
;; URL shortening ;;
;;;;;;;;;;;;;;;;;;;;

(defun saaxy-aux-tinycc (args arglist)
  (let* ((formatted (substring (apply #'concat (mapcar (lambda (x) (format "%s " x)) arglist)) 0 -1))
         (url "http://tiny.cc//ajax/create")
         (base "http://tiny.cc/%s")
         (magic-string-1 "NmNe42") (magic-string-2 "Tm1OZTQy")
         (params `((,(format "url_%s" magic-string-1) . ,formatted)
                   (,(format "custom_%s" magic-string-1) . "customurl")
                   ("referrer" . ,magic-string-2)))
         (raw (post-url url params))
         (tiny (cdr (assoc 'tiny (json-read-from-string raw))))
         (final (format base tiny)))
    (with-temp-buffer (insert final) (kill-ring-save (point-min) (point-max)))
    (format "Yanked to the clipboard: %s"
            (propertize final 'font-lock-face '(:foreground "#00FF00")))))

(defun saaxy-aux-tinyurl (status html)
  (with-temp-buffer
    (insert html)
    (delete-region (point-min) 2)
    (kill-ring-save (point-min) (point-max))
    (format "Yanked to the clipboard: %s" (propertize (buffer-string) 'font-lock-face '(:foreground "#00FF00")))))

(provide 'saaxy-commands)

;;; saaxy-commands.el ends here
