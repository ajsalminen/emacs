;; Frame fiddling
(defun set-frame-size-according-to-resolution ()
    (interactive)
    (if window-system
    (progn
      (if (> (x-display-pixel-width) 1500) ;; 1500 is the delimiter marging in px to consider the screen big
             (set-frame-width (selected-frame) 185) ;; on the big screen make the fram 237 columns big
             (set-frame-width (selected-frame) 100)) ;; on the small screen we use 177 columns
      (setq my-height (/ (- (x-display-pixel-height) 90) ;; cut 150 px of the screen height and use the rest as height for the frame
                               (frame-char-height)))
      (set-frame-height (selected-frame) my-height)
      (set-frame-position (selected-frame) 3 3) ;; position the frame 3 pixels left and 90 px down
  )))

(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)))


;; Hard Code the window dimensions, that's how we roll
;; (set-frame-position (selected-frame) 45 0)
;; (add-to-list 'default-frame-alist (cons 'width 150))
;; (add-to-list 'default-frame-alist (cons 'height 47))
;; (message "windows dimensions")
