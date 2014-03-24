;;; ggtags-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "ggtags" "ggtags.el" (21221 62870 0 0))
;;; Generated autoloads from ggtags.el

(autoload 'ggtags-find-project "ggtags" "\


\(fn)" nil nil)

(autoload 'ggtags-find-tag-dwim "ggtags" "\
Find definitions or references of tag NAME by context.
If point is at a definition tag, find references, and vice versa.
With a prefix arg (non-nil DEFINITION) always find definitions.

\(fn NAME &optional DEFINITION)" t nil)

(autoload 'ggtags-mode "ggtags" "\
Toggle Ggtags mode on or off.
With a prefix argument ARG, enable Ggtags mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil, and toggle it if ARG is `toggle'.
\\{ggtags-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'ggtags-build-imenu-index "ggtags" "\
A function suitable for `imenu-create-index-function'.

\(fn)" nil nil)

(autoload 'try-complete-ggtags-tag "ggtags" "\
A function suitable for `hippie-expand-try-functions-list'.

\(fn OLD)" nil nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ggtags-autoloads.el ends here
