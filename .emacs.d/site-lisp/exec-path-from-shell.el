;;; exec-path-from-shell.el --- Get environment variables such as $PATH from the shell

;; Copyright (C) 2012 Steve Purcell

;; Author: Steve Purcell <steve@sanityinc.com>
;; Keywords: environment
;; URL: https://github.com/purcell/exec-path-from-shell
;; Version: DEV

;; This file is not part of GNU Emacs.

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; On OS X (and perhaps elsewhere) the $PATH environment variable and
;; `exec-path' used by a windowed Emacs instance will usually be the
;; system-wide default path, rather than that seen in a terminal
;; window.

;; This library allows the user to set Emacs' `exec-path' and $PATH
;; from the shell path, so that `shell-command', `compile' and the
;; like work as expected.

;; It also allows other environment variables to be retrieved from the
;; shell, so that Emacs will see the same values you get in a terminal.

;; Installation:

;; ELPA packages are available on Marmalade and Melpa. Alternatively, place
;; this file on a directory in your `load-path', and explicitly require it.

;; Usage:
;;
;;     (require 'exec-path-from-shell) ;; if not using the ELPA package
;;     (exec-path-from-shell-initialize)
;;
;; Customize `exec-path-from-shell-variables' to modify the list of
;; variables imported.
;;
;; If you use your Emacs config on other platforms, you can instead
;; make initialization conditional as follows:
;;
;;     (when (memq window-system '(mac ns))
;;       (exec-path-from-shell-initialize))
;;
;; Alternatively, you can use `exec-path-from-shell-copy-envs' or
;; `exec-path-from-shell-copy-env' directly, e.g.
;;
;;     (exec-path-from-shell-copy-env "PYTHONPATH")

;;; Code:

(defgroup exec-path-from-shell nil
  "Make Emacs use shell-defined values for $PATH etc."
  :prefix "exec-path-from-shell-"
  :group 'environment)

(defcustom exec-path-from-shell-variables
  '("PATH" "MANPATH")
  "List of environment variables which are copied from the shell."
  :group 'exec-path-from-shell)

(defun exec-path-from-shell--double-quote (s)
  "Double-quote S, escaping any double-quotes already contained in it."
  (concat "\"" (replace-regexp-in-string "\"" "\\\\\"" s) "\""))

(defun exec-path-from-shell--login-arg (shell)
  "Return the name of the --login arg for SHELL."
  (if (string-match "tcsh$" shell) "-d" "-l"))

(defun exec-path-from-shell-printf (str &optional args)
  "Return the result of printing STR in the user's shell.

Executes $SHELL as interactive login shell.

STR is inserted literally in a single-quoted argument to printf,
and may therefore contain backslashed escape sequences understood
by printf.

ARGS is an optional list of args which will be inserted by printf
in place of any % placeholders in STR.  ARGS are not automatically
shell-escaped, so they may contain $ etc."
  (let* ((printf-bin (or (executable-find "printf") "printf"))
         (printf-command
          (concat printf-bin
                  " '__RESULT\\000" str "' "
                  (mapconcat #'exec-path-from-shell--double-quote args " "))))
    (with-temp-buffer
      (let ((shell (getenv "SHELL")))
        (call-process shell nil (current-buffer) nil
                      (exec-path-from-shell--login-arg shell)
                      "-i" "-c" printf-command))
      (goto-char (point-min))
      (when (re-search-forward "__RESULT\0\\(.*\\)" nil t)
        (match-string 1)))))

(defun exec-path-from-shell-getenvs (names)
  "Get the environment variables with NAMES from the user's shell.

Execute $SHELL as interactive login shell.  The result is a list
of (NAME . VALUE) pairs."
  (let ((values
         (split-string
          (exec-path-from-shell-printf
           (mapconcat #'identity (make-list (length names) "%s") "\\000")
           (mapcar (lambda (n) (concat "$" n)) names))
          "\0"))
        result)
    (while names
      (prog1
          (push (cons (car names) (car values)) result)
        (setq values (cdr values)
              names (cdr names))))
   result))

(defun exec-path-from-shell-getenv (name)
  "Get the environment variable NAME from the user's shell.

Execute $SHELL as interactive login shell, have it output the
variable of NAME and return this output as string."
  (cdr (assoc name (exec-path-from-shell-getenvs (list name)))))

(defun exec-path-from-shell-setenv (name value)
  "Set the value of environment var NAME to VALUE.
Additionally, if NAME is \"PATH\" then also set corresponding
variables such as `exec-path'."
  (setenv name value)
  (when (string-equal "PATH" name)
    (setq eshell-path-env value
          exec-path (parse-colon-path value))))

;;;###autoload
(defun exec-path-from-shell-copy-envs (names)
  "Set the environment variables with NAMES from the user's shell.

As a special case, if the variable is $PATH, then `exec-path' and
`eshell-path-env' are also set appropriately.  The result is an alist,
as described by `exec-path-from-shell-getenvs'."
  (mapc (lambda (pair)
          (exec-path-from-shell-setenv (car pair) (cdr pair)))
        (exec-path-from-shell-getenvs names)))

;;;###autoload
(defun exec-path-from-shell-copy-env (name)
  "Set the environment variable $NAME from the user's shell.

As a special case, if the variable is $PATH, then `exec-path' and
`eshell-path-env' are also set appropriately.  Return the value
of the environment variable."
  (interactive "sCopy value of which environment variable from shell? ")
  (cdar (exec-path-from-shell-copy-envs (list name))))

;;;###autoload
(defun exec-path-from-shell-initialize ()
  "Initialize environment from the user's shell.

The values of all the environment variables named in
`exec-path-from-shell-variables' are set from the corresponding
values used in the user's shell."
  (interactive)
  (exec-path-from-shell-copy-envs exec-path-from-shell-variables))


(provide 'exec-path-from-shell)
