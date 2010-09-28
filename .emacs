;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(defun ib ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(add-to-list 'load-path "~/.emacs.d/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))

(let ((path "~/.emacs.d/scala"))
  (setq load-path (cons path load-path))
  (load "scala-mode-auto.el"))
(require 'scala-mode-auto)

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(let ((path "~/.emacs.d"))
  (setq load-path (cons path load-path))
  (load "elisp-cache.el"))

(let ((nfsdir "~/.emacs.d")
      (cachedir "~/.elispcache"))
  (setq load-path (append load-path (list cachedir nfsdir)))
  (require 'elisp-cache)
  (setq elisp-cache-byte-compile-files t)

  (elisp-cache nfsdir cachedir)
  )

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
      (progn
        ;; use 120 char wide window for largeish displays
        ;; and smaller 80 column windows for smaller displays
        ;; pick whatever numbers make sense for you
        (if (> (x-display-pixel-width) 1280)
            (add-to-list 'default-frame-alist (cons 'width 120))
          (add-to-list 'default-frame-alist (cons 'width 80)))
        ;; for the height, subtract a couple hundred pixels
        ;; from the screen height (for panels, menubars and
        ;; whatnot), then divide by the height of a char to
        ;; get the height we want
        (add-to-list 'default-frame-alist
                     (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))

(set-frame-size-according-to-resolution)

(load-file "~/.emacs.d/cedet-1.0/common/cedet.el")
(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
(global-srecode-minor-mode 1)            ; Enable template insertion menu

(add-to-list 'load-path "~/.emacs.d/ecb-2.40")
(require 'ecb)
(semantic-load-enable-minimum-features)
(setq ecb-layout-name "left8")
(setq ecb-auto-activate t)
(setq ecb-tip-of-the-day nil)
(setq ecb-maximize-ecb-window-after-selection t)


(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)


;; Reload .emacs file by typing: Mx reload.
(defun reload () "Reloads .emacs interactively."
  (interactive)
  (load "~/.emacs"))

(setq default-directory "~/projects/ghub")

(require 'smart-tab)
(global-smart-tab-mode t)

(require 'yasnippet) ;; not yasnippet-bundle


;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 85 50))

(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(85 50))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;(byte-recompile-directory "~/.emacs.d" 0 t)

