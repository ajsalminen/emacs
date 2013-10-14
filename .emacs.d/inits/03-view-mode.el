(require 'color-moccur)
(require 'moccur-edit)
(setq moccur-split-word t)
(global-set-key (kbd "C-c o") 'occur-by-moccur)

(require 'anything-c-moccur)

(defvar view-mode-original-keybind nil)
(defun view-mode-set-window-controls (prefix-key)
  (unless view-mode-original-keybind
    (dolist (l (cdr view-mode-map))
      (if (equal ?s (car l))
          (setq view-mode-original-keybind (list prefix-key (cdr l))))))
  (define-key view-mode-map prefix-key view-mode-window-control-map))

(defun view-mode-unset-window-controls()
  (when view-mode-original-keybind
    (define-key view-mode-map (car view-mode-original-keybind)
      (cadr view-mode-original-keybind))
    (setq view-mode-original-keybind nil)))



;; view-mode時に、手軽にウィンドウ移動、切替を行えるようにする。
(defvar view-mode-window-control-map nil)
(unless view-mode-window-control-map
  (setq view-mode-window-control-map (make-sparse-keymap))

  (define-key view-mode-window-control-map (kbd "l") 'windmove-right)
  (define-key view-mode-window-control-map (kbd "h") 'windmove-left)
  (define-key view-mode-window-control-map (kbd "k") 'windmove-down)
  (define-key view-mode-window-control-map (kbd "j") 'windmove-up)

  (define-key view-mode-window-control-map (kbd "d") 'delete-window)
  (define-key view-mode-window-control-map (kbd "wh") 'split-window-horizontally)
  (define-key view-mode-window-control-map (kbd "wv") 'split-window-vertically)
  (define-key view-mode-window-control-map (kbd "o") 'delete-other-windows)
  )


(require 'viewer)
(viewer-stay-in-setup)
(setq viewer-modeline-color-unwritable "tomato"
      viewer-modeline-color-view "orange")
(viewer-change-modeline-color-setup)


(setq view-read-only t)
(defvar pager-keybind
  `( ;; vi-like
    ("a" . ,(lambda () (interactive)
              (let ((anything-c-moccur-enable-initial-pattern nil))
                (anything-c-moccur-occur-by-moccur))))
    (";" . anything)
    ("h" . backward-word)
    ("l" . forward-word)
    ("j" . next-line)
    ("k" . previous-line)
    ("b" . scroll-down)
    (" " . scroll-up)
    ;; w3m-like
    ;; ("m" . gene-word)
    ("i" . win-delete-current-window-and-squeeze)
    ("w" . forward-word)
    ("e" . backward-word)
    ("(" . point-undo)
    (")" . point-redo)
    ("J" . ,(lambda () (interactive) (scroll-up 1)))
    ("K" . ,(lambda () (interactive) (scroll-down 1)))
    ;; bm-easy
    ;; ("." . bm-toggle)
    ;; ("[" . bm-previous)
    ;; ("]" . bm-next)
    ;; langhelp-like
    ("c" . scroll-other-window-down)
    ("v" . scroll-other-window)
    ))

;; adapted from
;; http://d.hatena.ne.jp/derui/20100223/1266929390

(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
          (define-key keymap key cmd))))
  keymap)

(defun view-mode-set-vi-keybindings ()
  (define-many-keys view-mode-map pager-keybind)
  (hl-line-mode 1)
  (view-mode-set-window-controls "s")
  )

(add-hook 'view-mode-hook 'view-mode-set-vi-keybindings)
