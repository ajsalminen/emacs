;; htmlutil - Some useful tools for working with HTML text and HTTP URLs

; This module provides tools for escaping HTML text, with HTML
; entities for special characters; and for escaping strings to be
; safely included into URLS; and back.

;; Primary commands:
;  html-escape-str       - Escape (quote) a character for HTML
;  html-unescape-str     - Un-escape an HTML entity string
;  url-quote-str         - Quote special characters in a URL string
;  url-unquote-str       - Unquote special characters in a URL string

;  html-escape-region    - Apply html-escape-str on a region
;  html-unescape-region  - Apply html-unescape-str on a region
;  url-quote-region      - Apply url-quote-str on a region
;  url-unquote-region    - Apply url-unquote-str on a region

;; Examples:
;  (html-escape-str "<whoah> nelly")
;   "&lt;whoah&gt; nelly"
;  (html-unescape-str "&lt;whoah&gt; nelly")
;   "<whoah> nelly"
;  (url-quote-str "ab/c de/f")
;   "ab/c%20de/f"
;  (url-unquote-str "ab/c%20de/f")
;   "ab/c de/f"
;
; Copyright 2009-2010 Aaron Maxwell (amax@redsymbol.net).  Licensed under GPLv3.

(defun html-escape-region (min max)
  "Escape text for safe HTML display"
  (interactive "*r")
  (let ((s (copy-sequence (buffer-substring min max))))
    (delete-region min max)
    (insert (html-escape-str s))))

(defun html-unescape-region (min max)
  "Convert text escaped for HTML back into regular text"
  (interactive "*r")
  (let ((s (copy-sequence (buffer-substring min max))))
    (delete-region min max)
    (insert (html-unescape-str s))))

(defun url-quote-region (min max)
  "Quote text for inclusion in a HTTP URL"
  (interactive "*r")
  (let ((s (copy-sequence (buffer-substring min max))))
    (delete-region min max)
    (insert (url-quote-str s))))

(defun url-unquote-region (min max)
  "Unquote text that had been escapes for an HTTP URL"
  (interactive "*r")
  (let ((s (copy-sequence (buffer-substring min max))))
    (delete-region min max)
    (insert (url-unquote-str s))))

(defun switch (pair)
  (cons (cdr pair) (car pair)))

; HTML code escape table
(defconst html-escapes '(("&" . "&amp;")
                         ("<" . "&lt;")
                         (">" . "&gt;")
                         ("'" . "&39;")
                         ("\"" . "&quot;")))

(defconst html-unescapes
  (mapcar #'switch (copy-sequence html-escapes)))

(defun lookup-escape-from (c all-escapes)
  "look up an escape for a char or string from a table"
  (defun lookup-some (c some-escapes)
    (let ((current (car some-escapes)))
      (if (null current)
          c
        (if (equal (car current) c)
            (cdr current)
          (lookup-some c (cdr some-escapes))))))
  (lookup-some c all-escapes))

(defun html-lookup-escape (c)
  "return the escape for a char (length-1 string), xor the same char"
  (lookup-escape-from c html-escapes))

(defun html-lookup-unescape (e)
  "return the character for an entity, xor the same entity"
  (lookup-escape-from e html-unescapes))

(defun html-xform-str (s matchre lookup)
  (let ((encoded (copy-sequence s))
        (n 0))
  (while (setq n (string-match matchre encoded n))
    (setq encoded
          (replace-match (funcall lookup (match-string 1 encoded))
                         t t encoded)
          n (1+ n)))
  encoded))

(defun html-escape-str (s)
  "Escape (quote) a character for HTML"
  ; TODO: calculate following regexp from html-escapes table
  (html-xform-str s "\\\([&<>'\"]\\\)" #'html-lookup-escape))

(defun html-unescape-str (s)
  "Un-escape an HTML entity"
  ; TODO: calculate following regexp from html-escapes table
  (html-xform-str s "\\\(&amp;\\\|&lt;\\\|&gt;\\\|&39;\\\|&quot;\\\)" #'html-lookup-unescape))

(defun url-escape-point (c)
  "Escape (quote) a character for a URL"
  (format "%%%X" (string-to-char c)))

(defun url-unescape-point (s)
  "Un-escape a URL escape code"
  (assert (equal (substring s 0 1) "%"))
  (format "%c"  (string-to-number (substring s 1) 16)))

; TODO: url-quote-str and url-unquote-str have a lot of common code to consolidate
(defun url-quote-str (s)
  "Quote special characters in a URL string"
  (let ((unquoted-re "[^a-zA-Z0-9_./-]")
        (encoded (copy-sequence s))
        (n 0))
        (while (setq n (string-match unquoted-re encoded n))
          (setq encoded
                (replace-match (url-escape-point (match-string 0 encoded))
                               t t encoded)
                n (1+ n)))
        encoded))

(defun url-unquote-str (s)
  "Unquote special characters in a URL string"
  (let ((quote-re "%[0-9][0-9]")
        (encoded (copy-sequence s))
        (n 0))
        (while (setq n (string-match quote-re encoded n))
          (setq encoded
                (replace-match (url-unescape-point (match-string 0 encoded))
                               t t encoded)
                n (1+ n)))
        encoded))

(provide 'htmlutils)
;; unit tests

; This is a little homebrew testing harness. By default, tests are not
; run at all upon eval.  To run tests upon compile, but not on regular
; emacs startup, add the following to the END of your .emacs:

;   (setq run-tests-on-eval t)

; If run-tests-on-eval is set to t, you can just eval the when form to
; run tests.  Any error message indicates a failed test.  The "chk"
; functions all have the expected value first.  All tests passing
; means a silent "nil" response.  No news is good news!

(defvar run-tests-on-eval nil)
(defvar testing-now nil)
(eval-when-compile  (setq testing-now t))

(when (and run-tests-on-eval testing-now)
  (progn
    ; html-lookup-escape
    (defun chk (e arg)
      (assert (equal e (html-lookup-escape arg)) t))
    (chk "&amp;" "&")
    (chk "&lt;" "<")
    (chk "&gt;" ">")
    (chk "&39;" "'")
    (chk "&quot;" "\"")
    )
  (progn
    ; html-escape-str
    (defun chk (e arg)
      (assert (equal e (html-escape-str arg)) t))
    (chk "x" "x")
    (chk "" "")
    (chk "hello my friend" "hello my friend")
    (chk "&amp;" "&")
    (chk "&lt;" "<")
    (chk "&gt;" ">")
    (chk "&39;" "'")
    (chk "&quot;" "\"")
    (chk "&gt;&lt;&amp;&quot;&39;" "><&\"'")
    (chk "hello my &amp; friend" "hello my & friend")
    (chk "hello &lt;my&gt; &amp; friend" "hello <my> & friend")
    )
  (progn
    ; html-unescape-str
    (defun chk (e arg)
      (assert (equal e (html-unescape-str arg)) t))
    (chk "x" "x")
    (chk "" "")
    (chk "hello my friend" "hello my friend")
    (chk "&" "&amp;")
    (chk "<" "&lt;")
    (chk ">" "&gt;")
    (chk "'" "&39;")
    (chk "\"" "&quot;")
    (chk "><&\"'" "&gt;&lt;&amp;&quot;&39;")
    (chk "hello my & friend" "hello my &amp; friend")
    (chk "hello <my> & friend" "hello &lt;my&gt; &amp; friend")
    )
  (progn
    ; url-quote-str
    (defun chk (e arg)
      (assert (equal e (url-quote-str arg)) t))
    (chk "" "")
    (chk "x" "x")
    (chk "a%20b" "a b")
    )
  (progn
    ; url-unquote-str
    (defun chk (e arg)
      (assert (equal e (url-unquote-str arg)) t))
    (chk "" "")
    (chk "x" "x")
    (chk "a b" "a%20b")
    )
  (progn
    ; url-escape-point
    (defun chk (e arg)
      (assert (equal e (url-escape-point arg)) t))
    (chk "%20" " ")
    (chk "%40" "@")
    (chk "%23" "#")
    (chk "%3F" "?")
    )
  (progn
    ; url-unescape-point
    (defun chk (e arg)
      (assert (equal e (url-unescape-point arg)) t))
    (chk " " "%20")
    (chk "@" "%40")
    (chk "#" "%23")
    (chk "?" "%3F")
    )
  )
