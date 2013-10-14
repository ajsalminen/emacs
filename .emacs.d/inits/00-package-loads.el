;; these are loads that should run after packages are initialized

;; require this early for byte compiling
(require 'auto-compile)
(auto-compile-on-load-mode 1)
(auto-compile-on-save-mode 1)

;; grab PATH variables from shell on osx
(when (memq window-system '(mac ns))
  (progn
    (require 'exec-path-from-shell)
    (exec-path-from-shell-initialize)))
