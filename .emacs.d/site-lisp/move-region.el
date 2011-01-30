;;
;;	$Date: 2004-10-13 09:02:05 +0900 (Wed, 13 Oct 2004) $
;;	$Revision$
;;
;;	矢印キーでregionを移動する。regionが設定されてないとき
;;	(mark-active が nil のとき)は普通にカーソル移動する。
;;	(transient-mark-mode t) としてregionを常に反転させておけば
;;	間違えることはないと思う。
;;
;;	(setq deactivate-mark nil) というのが重要である。
;;	これをやらないと (mark) が無効になってしまう。
;;	小松氏のElisp文書に載っている。
;;	http://lc.linux.or.jp/lc2002/papers/komatsu0920h.pdf
;;
;;	矩形領域を選択できると絵を書くとき楽かもしれない
;;

(global-set-key [C-left]  'select-region-left)
(global-set-key [C-right] 'select-region-right)
(global-set-key [C-up]    'select-region-up)
(global-set-key [C-down]  'select-region-down)

;; (global-set-key "\M-f" 'select-region-right)
;; (global-set-key "\M-b" 'select-region-left)
;; (global-set-key "\M-p" 'select-region-up)
;; (global-set-key "\M-n" 'select-region-down)

(global-set-key [right] 'move-region-right)
(global-set-key [left]  'move-region-left)
(global-set-key [up]    'move-region-up)
(global-set-key [down]  'move-region-down)

;; (global-set-key "\C-f" 'move-region-right)
;; (global-set-key "\C-b" 'move-region-left)
;; (global-set-key "\C-p" 'move-region-up)
;; (global-set-key "\C-n" 'move-region-down)

(defun select-region-right ()
  (interactive)
  (if (not mark-active) (set-mark (point)))
  (forward-word)
  )

(defun select-region-left ()
  (interactive)
  (if (not mark-active) (set-mark (point)))
  (backward-word)
  )

(defun select-region-up ()
  (interactive)
  (if (not mark-active) (set-mark (point)))
  (forward-line -1)
  )

(defun select-region-down ()
  (interactive)
  (if (not mark-active) (set-mark (point)))
  (forward-line 1)
  )

(defun move-region-right ()
  (interactive)
  (if mark-active
      (let (m)
	(kill-region (mark) (point))
	(forward-char 1)
	(setq m (point))
	(yank)
	(set-mark m)
	(setq deactivate-mark nil)
	)
    (forward-char 1))
  )

(defun move-region-left ()
  (interactive)
  (if mark-active
      (if (> (mark) 1)
	  (let (m)
	    (kill-region (mark) (point))
	    (backward-char 1)
	    (setq m (point))
	    (yank)
	    (set-mark m)
	    (setq deactivate-mark nil)
	    ))
    (backward-char 1)
    ))

(defun move-region-up ()
  (interactive)
  (if mark-active
      (let (m)
	(kill-region (mark) (point))
	(forward-line -1)
	(setq m (point))
	(yank)
	(set-mark m)
	(setq deactivate-mark nil)
	)
    (forward-line -1)
    ))

(defun move-region-down ()
  (interactive)
  (if mark-active
      (let (m)
	(kill-region (mark) (point))
	(forward-line 1)
	(setq m (point))
	(yank)
	(set-mark m)
	(setq deactivate-mark nil)
	)
    (forward-line 1)
    ))

(defun dup-region ()
  (interactive)
  (if mark-active
      (let (m)
	(kill-region (mark) (point))
	(yank)
	(setq m (point))
	(yank)
	(set-mark m)
	(setq deactivate-mark nil)
	)
    (forward-char 1))
  )

(provide 'move-region)