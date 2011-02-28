;;; -*- Mode: Emacs-Lisp -*-

;;; transpose-frame.el --- Transpose windows arrangement in a frame

;; Copyright (c) 2011  S. Irie

;; Author: S. Irie
;; Maintainer: S. Irie
;; Keywords: window

(defconst transpose-frame-version "0.0.1")

;; This program is free software.

;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:

;; 1. Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.
;; 2. Redistributions in binary form must reproduce the above copyright
;;    notice, this list of conditions and the following disclaimer in the
;;    documentation and/or other materials provided with the distribution.

;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;; A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;; OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;; SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
;; TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
;; PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
;; LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;;; Commentary:

;; This program provides some interactive functions which allows users
;; to transpose windows arrangement in currently selected frame:
;;
;; `transpose-frame'  ...  Swap x-direction and y-direction
;;
;;        +------------+------------+      +----------------+--------+
;;        |            |     B      |      |        A       |        |
;;        |     A      +------------+      |                |        |
;;        |            |     C      |  =>  +--------+-------+   D    |
;;        +------------+------------+      |   B    |   C   |        |
;;        |            D            |      |        |       |        |
;;        +-------------------------+      +--------+-------+--------+
;;
;; `flip-frame'  ...  Flip vertically
;;
;;        +------------+------------+      +------------+------------+
;;        |            |     B      |      |            D            |
;;        |     A      +------------+      +------------+------------+
;;        |            |     C      |  =>  |            |     C      |
;;        +------------+------------+      |     A      +------------+
;;        |            D            |      |            |     B      |
;;        +-------------------------+      +------------+------------+
;;
;; `flop-frame'  ...  Flop horizontally
;;
;;        +------------+------------+      +------------+------------+
;;        |            |     B      |      |     B      |            |
;;        |     A      +------------+      +------------+     A      |
;;        |            |     C      |  =>  |     C      |            |
;;        +------------+------------+      +------------+------------+
;;        |            D            |      |            D            |
;;        +-------------------------+      +-------------------------+
;;
;; `rotate-frame'  ...  Rotate 180 degrees
;;
;;        +------------+------------+      +-------------------------+
;;        |            |     B      |      |            D            |
;;        |     A      +------------+      +------------+------------+
;;        |            |     C      |  =>  |     C      |            |
;;        +------------+------------+      +------------+     A      |
;;        |            D            |      |     B      |            |
;;        +-------------------------+      +------------+------------+
;;
;; `rotate-frame-clockwise'  ...  Rotate 90 degrees clockwise
;;
;;        +------------+------------+      +-------+-----------------+
;;        |            |     B      |      |       |        A        |
;;        |     A      +------------+      |       |                 |
;;        |            |     C      |  =>  |   D   +--------+--------+
;;        +------------+------------+      |       |   B    |   C    |
;;        |            D            |      |       |        |        |
;;        +-------------------------+      +-------+--------+--------+
;;
;; `rotate-frame-anti-clockwise'  ...  Rotate 90 degrees anti-clockwise
;;
;;        +------------+------------+      +--------+--------+-------+
;;        |            |     B      |      |   B    |   C    |       |
;;        |     A      +------------+      |        |        |       |
;;        |            |     C      |  =>  +--------+--------+   D   |
;;        +------------+------------+      |        A        |       |
;;        |            D            |      |                 |       |
;;        +-------------------------+      +-----------------+-------+
;;
;; This program is tested on GNU Emacs 22, 23.

;;
;; Installation:
;;
;; First, save this file as transpose-frame.el and byte-compile in a directory
;; that is listed in load-path.
;;
;; Put the following in your .emacs file:
;;
;;   (require 'transpose-frame)
;;
;; To swap x-direction and y-direction of windows arrangement, for example,
;; just type as:
;;
;;   M-x transpose-frame
;;
;; Have fun!
;;

;;; ChangeLog:

;; 2011-02-28  S. Irie
;;        * Version 0.0.1
;;        * Initial version

;;; ToDo:

;;; Code:

;; Internal functions

(defun transpose-frame-get-arrangement (&optional tree-or-frame)
  (let ((tree (if (or (null tree-or-frame)
		      (framep tree-or-frame))
		  (car (window-tree tree-or-frame))
		tree-or-frame)))
    (if (windowp tree)
	(list (window-buffer tree)
	      (window-start tree)
	      (window-point tree)
	      (eq tree (frame-selected-window (and (framep tree-or-frame)
						   tree-or-frame))))
      (let* ((vertical (car tree))
	     (edges (cadr tree))
	     (length (float (if vertical
				(- (nth 3 edges) (cadr edges))
			      (- (nth 2 edges) (car edges))))))
	(cons vertical
	      (mapcar (lambda (subtree)
			(cons (transpose-frame-get-arrangement subtree)
			      (/ (let ((edges (if (windowp subtree)
						  (window-edges subtree)
						(cadr subtree))))
				   (if vertical
				       (- (nth 3 edges) (cadr edges))
				     (- (nth 2 edges) (car edges))))
				 length)))
		      (cddr tree)))))))

(defun transpose-frame-set-arrangement (config &optional window-or-frame &rest how)
  (let ((window  (if (windowp window-or-frame)
		     window-or-frame
		   (frame-selected-window window-or-frame))))
    (unless (windowp window-or-frame)
      (delete-other-windows window))
    (if (bufferp (car config))
	(progn
	  (set-window-buffer window (pop config))
	  (set-window-start window (pop config))
	  (set-window-point window (pop config))
	  (if (pop config) (select-window window)))
      (let* ((horizontal (if (memq 'transpose how)
			     (pop config)
			   (not (pop config))))
	     (edges (window-edges window))
	     (length (float (if horizontal
				(- (nth 2 edges) (car edges))
			      (- (nth 3 edges) (cadr edges))))))
	(if (memq (if horizontal 'flop 'flip) how)
	    (setq config (reverse config)))
	(while (cdr config)
	  (setq window (prog1
			   (split-window window (round (* length (cdar config)))
					 horizontal)
			 (apply 'transpose-frame-set-arrangement
				(caar config) window how))
		config (cdr config)))
	(apply 'transpose-frame-set-arrangement
	       (caar config) window how)))))

;; User commands

(defun transpose-frame (&optional frame)
  "Transpose windows arrangement at FRAME.
Omitting FRAME means currently selected frame."
  (interactive)
  (transpose-frame-set-arrangement (transpose-frame-get-arrangement frame) frame
				   'transpose)
  (if (interactive-p) (recenter)))

(defun flip-frame (&optional frame)
  "Flip windows arrangement vertically at FRAME.
Omitting FRAME means currently selected frame."
  (interactive)
  (transpose-frame-set-arrangement (transpose-frame-get-arrangement frame) frame
				   'flip))

(defun flop-frame (&optional frame)
  "Flop windows arrangement horizontally at FRAME.
Omitting FRAME means currently selected frame."
  (interactive)
  (transpose-frame-set-arrangement (transpose-frame-get-arrangement frame) frame
				   'flop))

(defun rotate-frame (&optional frame)
  "Rotate windows arrangement 180 degrees at FRAME.
Omitting FRAME means currently selected frame."
  (interactive)
  (transpose-frame-set-arrangement (transpose-frame-get-arrangement frame) frame
				   'flip 'flop))

(defun rotate-frame-clockwise (&optional frame)
  "Rotate windows arrangement 90 degrees clockwise at FRAME.
Omitting FRAME means currently selected frame."
  (interactive)
  (transpose-frame-set-arrangement (transpose-frame-get-arrangement frame) frame
				   'transpose 'flop)
  (if (interactive-p) (recenter)))

(defun rotate-frame-anticlockwise (&optional frame)
  "Rotate windows arrangement 90 degrees anti-clockwise at FRAME.
Omitting FRAME means currently selected frame."
  (interactive)
  (transpose-frame-set-arrangement (transpose-frame-get-arrangement frame) frame
				   'transpose 'flip)
  (if (interactive-p) (recenter)))

(provide 'transpose-frame)

;;;
;;; transpose-frame.el ends here
