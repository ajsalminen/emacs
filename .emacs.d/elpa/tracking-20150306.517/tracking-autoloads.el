;;; tracking-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "tracking" "tracking.el" (21772 64791 0 0))
;;; Generated autoloads from tracking.el

(defvar tracking-mode nil "\
Non-nil if Tracking mode is enabled.
See the command `tracking-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `tracking-mode'.")

(custom-autoload 'tracking-mode "tracking" nil)

(autoload 'tracking-mode "tracking" "\
Allow cycling through modified buffers.
This mode in itself does not track buffer modification, but
provides an API for programs to add buffers as modified (using
`tracking-add-buffer').

Once this mode is active, modified buffers are shown in the mode
line. The user can cycle through them using
\\[tracking-next-buffer].

\(fn &optional ARG)" t nil)

(autoload 'tracking-add-buffer "tracking" "\
Add BUFFER as being modified with FACES.
This does check whether BUFFER is currently visible.

If FACES is given, it lists the faces that might be appropriate
for BUFFER in the mode line. The highest-priority face of these
and the current face of the buffer, if any, is used. Priority is
decided according to `tracking-faces-priorities'.

\(fn BUFFER &optional FACES)" nil nil)

(autoload 'tracking-remove-buffer "tracking" "\
Remove BUFFER from being tracked.

\(fn BUFFER)" nil nil)

(autoload 'tracking-next-buffer "tracking" "\
Switch to the next active buffer.

\(fn)" t nil)

(autoload 'tracking-previous-buffer "tracking" "\
Switch to the last active buffer.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; tracking-autoloads.el ends here
