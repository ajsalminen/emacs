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

(defun view-mode-set-vi-keybindings ()
  (define-many-keys view-mode-map pager-keybind)
  (hl-line-mode 1)
  (view-mode-set-window-controls "s")
  )

(add-hook 'view-mode-hook 'view-mode-set-vi-keybindings)
