;;; navi2ch-articles.el --- Article List Module for Navi2ch

;; Copyright (C) 2001 by 2$B$A$c$s$M$k(B

;; Author: (not 1)
;; Keywords: 2ch, network

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; 

;;; Code:

(eval-when-compile (require 'cl))
(require 'navi2ch-board-misc)

(defvar navi2ch-articles-mode-map nil)
(unless navi2ch-articles-mode-map
  (let ((map (copy-keymap navi2ch-bm-mode-map)))
    ;; (define-key navi2ch-articles-mode-map "q" 'navi2ch-articles-exit)
    (define-key map "d" 'navi2ch-articles-delete)
    (setq navi2ch-articles-mode-map map)))

(defvar navi2ch-articles-mode-menu-spec
  (navi2ch-bm-make-menu-spec
   "Articles"
   nil))

(defvar navi2ch-articles-board
  '((name . "$BI=<(%9%l0lMw(B")
     (type . articles)
     (id . "articles")))
  
;;; navi2ch-bm callbacks
(defun navi2ch-articles-set-property (begin end item)
  (put-text-property begin end 'buffer item))

(defun navi2ch-articles-get-property (point)
  (get-text-property point 'buffer))

(defun navi2ch-articles-get-article (item)
  (when item
    (save-excursion
      (set-buffer item)
      navi2ch-article-current-article)))

(defun navi2ch-articles-get-board (item)
  (when item
    (save-excursion
      (set-buffer item)
      navi2ch-article-current-board)))

(defun navi2ch-articles-exit ())

;;; navi2ch-articles functions
(defun navi2ch-articles-insert-subjects ()
  (let ((i 1))
    (dolist (x (navi2ch-article-buffer-list))
      (let ((article (navi2ch-articles-get-article x))
            (board (navi2ch-articles-get-board x)))
        (navi2ch-bm-insert-subject
         x i
         (cdr (assq 'subject article))
         (format "[%s]" (cdr (assq 'name board))))
        (setq i (1+ i))))))

(defun navi2ch-articles-delete ()
  "$B$=$N9T$r(B articles $B$+$i:o=|$7$F!"$=$N(B article buffer $B$b>C$9(B"
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let ((buf (navi2ch-articles-get-property (point))))
      (if buf
          (let ((buffer-read-only nil))
            (save-excursion
              (set-buffer buf)
              (navi2ch-article-kill-buffer))
            (delete-region (point)
                           (save-excursion (forward-line) (point))))
        (message "Can't select this line!")))))
  

(defun navi2ch-articles ()
  "articles $B$rI=<($9$k(B"
  (navi2ch-articles-mode)
  (navi2ch-bm-setup 'navi2ch-articles)
  (let ((buffer-read-only nil))
    (erase-buffer)
    (save-excursion
      (navi2ch-articles-insert-subjects))))

(defun navi2ch-articles-setup-menu ()
  (easy-menu-define navi2ch-articles-mode-menu
		    navi2ch-articles-mode-map
		    "Menu used in navi2ch-articles"
		    navi2ch-articles-mode-menu-spec)
  (easy-menu-add navi2ch-articles-mode-menu))

(defun navi2ch-articles-mode ()
  "\\{navi2ch-articles-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'navi2ch-articles-mode)
  (setq mode-name "Navi2ch Articles")
  (setq buffer-read-only t)
  (use-local-map navi2ch-articles-mode-map)
  (navi2ch-articles-setup-menu)
  (run-hooks 'navi2ch-articles-mode-hook))

(provide 'navi2ch-articles)
        
;;; navi2ch-articles.el ends here
