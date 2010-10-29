;; reftex-extbib.el --- citations from external databases

;; Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
;;   2006, 2007, 2008 Free Software Foundation, Inc.

;; Author: Piotr Milkowski <pioterowy@gmail.com>

;; This file is part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;; Code:
(eval-when-compile (require 'cl))
(provide 'reftex-extbib)
(require 'reftex-base)
(require 'reftex-cite)

;;----------------------------------------------------------------
;; GOTO GIVEN ENTRY
;;----------------------------------------------------------------
(defun reftex-pop-to-external-entry(db-list key highlight return buffer-conf &optional force-revisit)
  (let (name  buf type)
    (dolist (name db-list)
      ;; First try to find entry in temporary buffers
      (setq buf (get-buffer (concat "*reftex-" name "-output*")))
      (when buf
      	(dolist (def reftex-ext-bibliography-databases)
      	  (when (and (string= name (car def)) (nth 2 def)) ;; active database definition
	    
      	    (reftex-pop-to-bibtex-entry-in-buffer 
      	      (if (eq (nth 1 def) 'refdb) "ris" "epr")
      	      key buf highlight nil return buffer-conf)
      	    )))
      ;; Else try to get from external databases
	(when (or force-revisit reftex-revisit-to-echo (not return))
	  (dolist (def reftex-ext-bibliography-databases)
	    (when (and (string= name (car def)) (nth 2 def)) ;; active database definition
	      (let* ((output (concat "*reftex-" name "-output*"))
		      (messages (concat "*reftex-" name "-messages*"))
		      url skey re)
		(setq type (nth 1 def))
		(cond 
		  ((eq type 'refdb)
		    ;; RefDB entry
		    (shell-command 
		      (format "%s \":CK:=\'%s\'\" -d %s -t ris" 
		          reftex-refdbc-command key name) output messages)
		    (reftex-pop-to-bibtex-entry-in-buffer "ris" 
		      key (get-buffer-create output) highlight nil return buffer-conf)
		    )
		  ((eq type 'eprints-http)
		    ;; Eprints entry
		    (setq url (nth 3 def))
		    (setq re (concat 
		       "^\\(http://\\)?" (regexp-quote url) ".*/\\([0-9]+\\)$"))
		    (when (string-match re key)
		      (setq skey (match-string-no-properties 2 key))
		      (shell-command
			(format 
			  "%s -i%s %s" reftex-epfind-command skey url)
			output messages)
		      (reftex-pop-to-bibtex-entry-in-buffer "epr" 
			key (get-buffer-create output) highlight nil return buffer-conf)
		      ))
		  (( eq type 'eprints-soap)
		    ;; TODO
		    )
      )))))
      )))

;;----------------------------------------------------------------
;; EXTRACT RIS ENTRIES
;;----------------------------------------------------------------

(defun reftex-extract-external-entries (re-list dbname)
  ;; Extract bib entries which match RE-LIST from external database
  ;; DBNAME.
  ;; Return list with entries
  (let* ((dbname (symbol-name dbname))
	  type alist)
    (when reftex-use-external-databases
      (dolist (def reftex-ext-bibliography-databases)
	(when (and (string= dbname (car def)) (nth 2 def)) ;; active definition
	  (setq type (nth 1 def))
	  (setq alist
	    (append alist
	      (cond
		((eq type 'refdb)
		  (reftex-extract-refdb-entries re-list dbname))
		((eq type 'eprints-http)
		  (reftex-extract-eprints-entries re-list dbname (nth 3 def)))
		((eq type 'eprints-soap)
		  (reftex-extract-epsoap-entries re-list dbname (nth 3 def)))))))))
      alist))

(defun reftex-extract-refdb-entries (re-list dbname)
  (message "Scanning refdb database: %s. Please wait" dbname)
  (let* ((output (concat "*reftex-" dbname "-output*"))
	 (messages (concat "*reftex-" dbname "-messages*"))
	  start-point end-point entry alist found-list )
    
    ;; Get data from refdb database
    (message "Scanning refdb database %s. Please wait" dbname)
    (shell-command
     (format "%s \"%s\" -d %s -t ris"
       reftex-refdbc-command
       (mapconcat (lambda(x) (format ":%s:~'%s'" x (car re-list)))
	 reftex-refdb-search-fields " OR ")
       dbname)
      output messages)

    (save-excursion
      (save-window-excursion
	(set-buffer (get-buffer-create output))
    
	;; Parse ris entries
	(goto-char (point-min))
	(while (re-search-forward "TY  - \\(\\w+\\)[ \t\n\r]*" nil t)
	  (catch 'search-again
	    (setq start-point (match-beginning 0))
	    (re-search-forward "[\n\r]ER  - ")

	    (push 
	      (reftex-get-entry "ris" start-point (point) (cdr re-list)) 
	      found-list)))))
      found-list))

(defun reftex-extract-ris-entries (re-list buffer)
  (let* (
	(first-re (car re-list))    ; We'll use the first re to find things,
	(rest-re (cdr re-list))     ; the others to narrow down.
	 found-list entry alist
	 key-point start-point end-point)
    (set-buffer buffer)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward first-re nil t)
	(catch 'search-again
	  (setq key-point (point))
	  (unless (re-search-backward "\\(\\`\\|[\n\r]\\)TY  - " nil t)
	    (throw 'search-again nil))

	  (setq start-point (match-end 1))
	  (re-search-forward "\\(\\`\\|[\n\r]\\)ER  - " nil t)
	  (when (< (point) key-point) ; this means match is not in TY - ER
	    (goto-char key-point)
	    (throw 'search-again nil))
	  (push 
	    (reftex-get-entry "ris" start-point (point) rest-re)
	    found-list))))
    found-list))

(defun reftex-parse-ris-entry (entry &optional from to)

  (let (alist key field)
    (save-excursion
      (save-restriction
        (reftex-create-scratch-for entry from to)
        (goto-char (point-min))
	;; Invalid entry - skip if no ID found
	(unless (re-search-forward "[\n\r]ID  - \\(\\w+\\)[ \t\n\r]*" nil t)
	  (throw 'search-again nil))

	(setq alist (list 
	    (cons "&entry-type" "ris")
	    (cons "&key" (reftex-match-string 1))))
	(goto-char (point-min))
	(re-search-forward "\\(\\`\\|[\n\r]\\)TY  - \\(\\w+\\)[ \t\n\r]+")
	(push (cons "&type" (reftex-match-string 2)) alist)
	(goto-char (match-end 0))
	(while (re-search-forward 
		 ;; "line beginning or \n"(key)  - (value) "spaces\n""next key"
		 ;; next line key must be matched, because value can contain \ns
		 "\\(\\`\\|[\n\r]+\\)\\([A-Z][A-Z,1-5]\\)  - \\(.*\\)[ \t]*[\n\r]+[A-Z][A-Z,1-5]  - "
		 nil t)
	  (setq key (reftex-match-string 2))
	  (when (not (string= key "ID"))
	    (push (cons key (reftex-match-string 3)) alist))

	  ;; go back to end of matched value
	  (goto-char (match-end 3)))
	))
	(nreverse alist)))

(defun reftex-format-ris-entry (entry)
  ;; Format a RIS ENTRY
  (let* (
      (key (reftex-get-bib-field "&key" entry))
      (authors (mapconcat  'identity
	       (reftex-get-authors entry "ris") ", "))
      (year (or (reftex-get-year entry "ris") ""))
      (title (car 
          (reftex-get-bib-values '("TI" "T1" "CT" "BT") entry)))
      (type (reftex-get-bib-field "&type" entry))
      
      (extra
	(cond
	  ((equal type "JOUR")
	   (concat (car (reftex-get-bib-values '("JO" "JF") entry)) " "
	           (reftex-get-bib-field "VL" entry) ", "
	           (reftex-get-ris-pages entry)))
	  ((equal type "BOOK")
	    (concat "book (" (reftex-get-bib-field "PB" entry) ")"))
	  ((equal type "CHAP")
	    (concat "in: " (car (reftex-get-bib-values '("T2" "T3" "BT") entry))
	      ", pp." (reftex-get-ris-pages entry)))
	  ((equal type "CONF")
	     (concat "in: " (car (reftex-get-bib-values '("T2" "T3") entry)))
	  (t (concat "[" type "]"))
	  ))))
    (setq authors (reftex-truncate authors 30 t t))
    (when (reftex-use-fonts)
      (put-text-property 0 (length key)     'face
                         (reftex-verified-face reftex-label-face
                                               'font-lock-constant-face
                                               'font-lock-reference-face)
                         key)
      (put-text-property 0 (length authors) 'face reftex-bib-author-face
                         authors)
      (put-text-property 0 (length year)    'face reftex-bib-year-face
                         year)
      (put-text-property 0 (length title)   'face reftex-bib-title-face
                         title)
      (put-text-property 0 (length extra)   'face reftex-bib-extra-face
                         extra)
      )
    (if reftex-show-extra-after-title
      (concat key "\n     " authors " " year"\n     " title
	(unless (equal extra "") (concat "\n         " extra)) "\n\n")
      (concat key "\n     " authors " " year " " extra "\n     " title "\n\n"))))

;;----------------------------------------------------------------
;; EXTRACT EPRINTS ENTRIES
;;----------------------------------------------------------------
(defun reftex-extract-eprints-entries (re-list dbname url)
  (message "Scanning eprints database: %s. Please wait" dbname)
  (let* ((output (concat "*reftex-" dbname "-output*"))
	 (messages (concat "*reftex-" dbname "-messages*"))
	  start-point end-point entry alist found-list )
    
    ;; Get data from refdb database
    (message "Scanning eprints database %s. Please wait" dbname)
    (shell-command
     (format 
      "%s %s %s" reftex-epfind-command url (car re-list))
      output messages)

    (save-excursion
      (save-window-excursion
	(set-buffer (get-buffer-create output))
	
	;; Parse ris entries
	(goto-char (point-min))
	(while (re-search-forward "<eprint " nil t)
	  (catch 'search-again
	    (setq start-point (match-beginning 0))
	    (re-search-forward "</eprint>")
	    
	    (push 
	      (reftex-get-entry "epr" start-point (point) (cdr re-list)) 
	      found-list)))))
    found-list))

(defun reftex-extract-epsoap-entries (re-list dbname url)
  (error "Sorry. Getting entries using SOAP protocol not yet supported")
)

(defun reftex-extract-epr-entries (re-list buffer)
   (let* (
	   (first-re (car re-list))    ; We'll use the first re to find things,
	   (rest-re (cdr re-list))     ; the others to narrow down.
	   found-list entry alist
	   key-point start-point end-point)
     (set-buffer buffer)
     (save-excursion
       (goto-char (point-min))
       (while (re-search-forward first-re nil t)
	 (catch 'search-again
	   (setq key-point (point))
	   (unless (re-search-backward "<eprint " nil t)
	     (throw 'search-again nil))

	   (setq start-point (match-beginning 0))
	   (re-search-forward "</eprint>" nil t)
	   (when (< (point) key-point) ; this means match is not in <eprint> tag
	     (goto-char key-point)
	     (throw 'search-again nil))
	    
	   (push 
	     (reftex-get-entry "epr" start-point (point) rest-re)
	     found-list))))
  found-list))

(defun reftex-parse-epr-entry (entry  &optional from to)
  (let* (alist key value)
    (save-excursion
      (save-restriction
        (reftex-create-scratch-for entry from to)
        (goto-char (point-min))
	;; skip if no ID found
	(unless (re-search-forward "<eprint[ \t]+id[ \t]*=[ \t]*\"\\([^ \t]+\\)\"" nil t)
	  (throw 'search-again nil))

	(setq alist (list
	    (cons "&entry-type" "epr") 
	    (cons "&key" (reftex-match-string 1))))
	
	(while (re-search-forward "<\\([^ >]+\\).*?>" nil t) ;; not space or >
	  (unless (string= (setq key (reftex-match-string 1)) "/eprint")
	    (when (member key reftex-eprints-entry-fields)
	      ;; <creators> and <editors> must be parsed
	      (if (or (string= key "creators") (string= key "editors"))
		(setq value (reftex-parse-epr-creators-editors key))
	      ;; store field
		(setq value (reftex-get-tag key)))
	      (when value
		(push (cons key value) alist))
	      )))
      ))
  (nreverse alist)))

(defun reftex-parse-epr-creators-editors (name)
  (let* (item persons person
	  (from (point)))
    (save-excursion
      (save-restriction
	(if (re-search-forward (concat "[ \t]*\\(.*?\\)[ \t]*</" name ">") nil t)
	  (when (match-end 1);; Non empty tag
	    (reftex-create-scratch-for nil from (match-end 1))
	    (goto-char (point-min))
	    (while (re-search-forward "<\\([^ >]+\\)" nil t) 
	      (setq item (reftex-match-string 1))
	      (if (or (string= item "family") (string= item "given"))
		(progn
		  (goto-char (+ (point) 1))
		  (re-search-forward (concat "[ \t]*\\(.*\\)[ \t]*</" item ">"))
		  (push (cons item (reftex-match-string 1)) person))
		(when (string= item "/item")
		  (setq persons (cons person persons))
		  (setq person nil)))))
	  (error "Missing end of tag: %s" name))))
    persons))

(defun reftex-format-epr-entry (entry)
  (let* (
      (key (reftex-get-bib-field "&key" entry))
      (authors (mapconcat 'identity 
	 (reftex-get-authors entry "epr") ", "))
      (year (or (reftex-get-year entry "epr") ""))
      (title (reftex-get-bib-field "title" entry))
      (type (reftex-get-bib-field "type" entry))
      (pubstatus (reftex-get-bib-field "ispublished" entry))

      (extra
	(cond
	  ((equal type "article")
  	    ; some number fields contains "vol (num)"
	    (let ((t1 (if (equal "" (reftex-get-bib-field "volume" entry))
			"%s" "(%s)")))
	      (reftex-join-values
		(list ". "
		  (list ", " 
		    (reftex-get-bib-field "publication" entry)
		    (list " "
		      (reftex-get-bib-field "volume" entry)
		      (reftex-get-bib-field "number" entry t1)))
		  (reftex-get-bib-field "pagerange" entry "pp. %s")
		  (reftex-get-bib-field "issn" entry "ISSN %s")
		  ))))

	  ((equal type "book_section")
	    (reftex-join-values
	      (list ". "
		(reftex-get-bib-field "book_title" entry "In: %s")
		(list ", "
		  (reftex-get-bib-field "publisher" entry)
		  (reftex-get-bib-field "place_of_pub" entry)
		  (reftex-get-bib-field "pagerange" entry "pp. %s"))
		(reftex-get-bib-field "isbn" entry "ISBN %s")
		)))

	  ((equal type "monograph")
	    (reftex-join-values
	      (list ". "
		(mapconcat 'capitalize
		  (split-string  
		    (reftex-get-bib-field "monograph_type" entry) "_") " ")
		(reftex-get-bib-field "publisher" entry "%s."))))

	  ((equal type "conference_item")
	    (reftex-join-values
	      (list ", "
		(reftex-get-bib-field "event_title" entry "In: %s")
		(reftex-get-bib-field "event_dates" entry)
		(reftex-get-bib-field "event_location" entry "%s."))))

	  ((equal type "book")
	    (reftex-join-values
	      (list ". "
		(list ", "
		  (reftex-get-bib-field "publisher" entry)
		  (reftex-get-bib-field "place_of_pub" entry))
		(reftex-get-bib-field "isbn" entry "ISBN %s"))))

	  ((equal type "thesis")
	    (reftex-join-values
	      (list ", "
		(capitalize 
		  (reftex-get-bib-field "thesis_type" entry "%s thesis"))
		(reftex-get-bib-field "institution" entry) 
		(reftex-get-bib-field "department" entry))))

	  ((equal type "patent")
	    (reftex-get-bib-field "id_number" entry))

	  ((equal type "other")
	    (reftex-get-bib-field "publisher" entry))

	  (t (capitalize (concat "[" type "]")))
	  )))

    (setq authors (reftex-truncate authors 30 t t))
    ;; Add publication status
    (setq extra (concat extra (cond
		((equal pubstatus "unpub") " (Unpublished)")
		((equal pubstatus "submitted") " (Submitted)")
		((equal pubstatus "inpress") " (In Press)")
		(t ""))))
    (when (reftex-use-fonts)
      (put-text-property 0 (length key)     'face
                         (reftex-verified-face reftex-label-face
                                               'font-lock-constant-face
                                               'font-lock-reference-face)
                         key)
      (put-text-property 0 (length authors) 'face reftex-bib-author-face
                         authors)
      (put-text-property 0 (length year)    'face reftex-bib-year-face
                         year)
      (put-text-property 0 (length title)   'face reftex-bib-title-face
                         title)
      (put-text-property 0 (length extra)   'face reftex-bib-extra-face
	extra)
      )
    (if reftex-show-extra-after-title
      (concat key "\n     " authors " " year"\n     " title
	(unless (equal extra "") (concat "\n         " extra)) "\n\n")
      (concat key "\n     " authors " " year " " extra "\n     " title "\n\n"))))

;;----------------------------------------------------------------
;; EXTRACT METS ENTRIES
;;----------------------------------------------------------------
(defun reftex-extract-mets-entries (re-list buffer)
  (let* (
	  (first-re (car re-list))    ; We'll use the first re to find things,
	  (rest-re (cdr re-list))     ; the others to narrow down.
	  found-list entry
	  key-point start-point)

    (set-buffer buffer)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward first-re nil t)
	(catch 'search-again
	  (setq key-point (point))	  
	  (unless (re-search-backward "<mets:dmdSec" nil t)
	    (throw 'search-again nil))

	  (re-search-backward "<mets:mets ")
	  (setq start-point (match-beginning 0))

	  (re-search-forward "</mets:dmdSec>" nil t)
	  (when (< (point) key-point) ; this means match is not in <dmdSec> tag
	    (goto-char key-point)
	    (throw 'search-again nil))

	  ;; parse the entry and add to the list
	  (re-search-forward "</mets:mets>")
	  (push 
	    (reftex-get-entry "mets" start-point (point) rest-re)
	    found-list))))
    found-list)
  )

(defun reftex-parse-mets-entry (entry  &optional from to)
  (let* (alist key start end val)
    (save-excursion
      (save-restriction
	(reftex-create-scratch-for entry from to)
	(goto-char (point-min))
	;; skip if no ID found
	(unless (re-search-forward 
		  "<mets:dmdSec[ \t]+ID[ \t]*=[ \t]*\"\\(DMD_oai:\\)*\\([^ \t]+\\)\"" nil t)
	  (throw 'search-again nil))
	
	(setq alist (list
	      (cons "&entry-type" "mets")
	      (cons "&key" (reftex-match-string 2))))

	(while (re-search-forward "<mods:\\([^ >]+\\).*?>" nil t)	  
	  (setq key (reftex-match-string 1))
	  (when (member key reftex-mods-entry-fields)
	    ;; try to match type attribute
	    (setq start (reftex-match-string 0))
	    (string-match "type[ \t]*=[ \t]*\"\\(\\w+\\)\"" start)	     
	    (cond
	      ((equal key "name")
		(when (equal "personal" (match-string-no-properties 1 start))
		  (setq start (point))
		  (re-search-forward "</mods:name>")
		  (when (setq val 
			  (reftex-parse-mods-name-entry 
			    start (match-beginning 0)))
		    (push (cons (car val) (cdr val)) alist))
		  ))
	      ((or 
		 (and (equal key "placeTerm")
		   (equal "text" (match-string-no-properties 1 start)))
		 (not (equal key "placeTerm")))
		(push (cons key 
			(reftex-get-tag (concat "mods:" key))) alist))
	      )))))
    (nreverse alist)))

(defun reftex-parse-mods-name-entry (from to)
  (let* (alist role type start)
    (save-excursion
      (save-restriction
	(reftex-create-scratch-for nil from to)
	;; Get name parts
	(goto-char (point-min))

	(while (re-search-forward  "<mods:namePart.*?>" nil t)
	  (setq start (reftex-match-string 0))
	  (string-match "type[ \t]*=[ \t]*\"\\(\\w+\\)\"" start)
	  (setq type (match-string-no-properties 1 start))

	  (unless (equal "date" type)
	    (unless type (setq type "full"))
	    (push  (cons type (reftex-get-tag "mods:namePart")) alist)))

	;; Get display form
	(goto-char (point-min))
	(when (re-search-forward "<mods:displayForm.*?>" nil t)
	  (push (reftex-get-tag "mods:displayForm") alist))

	;; Finally get the role
	(when alist
	  (setq alist (nreverse alist))
	  (goto-char (point-min))
	  
	  (setq role
	    (when (re-search-forward  "<mods:roleTerm.*?>" nil t)
	      (setq start (reftex-match-string 0))
	      (string-match "type[ \t]*=[ \t]*\"\\(\\w+\\)\"" start)

	      (when (equal "text" (match-string-no-properties 1 start))
		(reftex-get-tag "mods:roleTerm"))))

	  (if (or (equal role "author") (equal role "editor"))
	    (cons role alist)
	    (cons "person" alist)))
	))))

(defun reftex-format-mets-entry (entry)
  (let* (
      (key (reftex-get-bib-field "&key" entry))
      (authors (mapconcat 'identity 
	 (reftex-get-authors entry "mets") ", "))
      (year (or (reftex-get-year entry "mets") ""))
      (title (reftex-get-bib-field "title" entry))
      (extra (concat "[" (reftex-get-bib-field "genre" entry) "] "
	       (reftex-get-bib-field "publisher" entry))))

    (setq authors (reftex-truncate authors 30 t t))
    (when (reftex-use-fonts)
      (put-text-property 0 (length key)     'face
                         (reftex-verified-face reftex-label-face
                                               'font-lock-constant-face
                                               'font-lock-reference-face)
                         key)
      (put-text-property 0 (length authors) 'face reftex-bib-author-face
                         authors)
      (put-text-property 0 (length year)    'face reftex-bib-year-face
                         year)
      (put-text-property 0 (length title)   'face reftex-bib-title-face
                         title)
      (put-text-property 0 (length extra)   'face reftex-bib-extra-face
	extra)
      )
    (if reftex-show-extra-after-title
      (concat key "\n     " authors " " year"\n     " title
	(unless (equal extra "") (concat "\n         " extra)) "\n\n")
      (concat key "\n     " authors " " year " " extra "\n     " title "\n\n"))))


(defun reftex-extract-mods-entries (re-list buffer)
)

;;----------------------------------------------------------------
;; CITATION FORMATTING
;;----------------------------------------------------------------
(defun reftex-format-ris-citation (entry n l)
  ;;todo - add other format fields
  (save-match-data
    (cond
      ((= l ?l) (concat
		  (reftex-get-bib-field "&key" entry)
		  (if reftex-comment-citations
		    reftex-cite-comment-format
		    "")))
       ((= l ?a) (reftex-format-names
		   (reftex-get-ris-names '("AU" "A1") entry)
		   (or n 2)))
      ((= l ?t) (car 
		  (reftex-get-bib-values '("TI" "T1" "CT" "BT")
		    entry)))
      ((= l ?T) (reftex-abbreviate-title  (car 
		  (reftex-get-bib-values '("TI" "T1" "CT" "BT")
		    entry))))
      ((= l ?y) (car (split-string
	    (car (reftex-get-bib-values '("PY" "Y1") entry))
	    "/")))
      )))

(defun reftex-format-epr-citation (entry n l)
  ;;todo - add other format fields
   (save-match-data
     (cond
       ((= l ?l) (concat
		   (reftex-get-bib-field "&key" entry)
		   (if reftex-comment-citations
		     reftex-cite-comment-format
		     "")))
       ((= l ?a) (reftex-format-names
		   (reftex-get-eprint-names "creators" entry)
		   (or n 2)))
       ((= l ?t) (reftex-get-bib-field "title" entry))
       ((= l ?T) (reftex-abbreviate-title
		  (reftex-get-bib-field "title" entry)))
       ((= l ?y) (car (split-string
		(reftex-get-bib-field "date" entry) "[-/]")))
       )))

(defun reftex-format-mets-citation (entry n l)
  ;;todo - add other format fields
   (save-match-data
     (cond
       ((= l ?l) (concat
		   (reftex-get-bib-field "&key" entry)
		   (if reftex-comment-citations
		     reftex-cite-comment-format
		     "")))
       ((= l ?a) (reftex-format-names
		   (reftex-get-mets-names "author" entry)
		   (or n 2)))
       ((= l ?t) (reftex-get-bib-field "title" entry))
       ((= l ?T) (reftex-abbreviate-title
		  (reftex-get-bib-field "title" entry)))
       ((= l ?y) (car (split-string
		(reftex-get-bib-field "dateIssued" entry) "[-/]")))
       )))
  
;;----------------------------------------------------------------
;; HELPERS
;;----------------------------------------------------------------
(defun reftex-get-eprint-names (field entry)
  (let ((names (reftex-get-bib-field field entry)))
    (when (and (equal "" names) (not (equal field "editors"))
	    (setq names (reftex-get-bib-field "editors" entry))))
    (mapcar  
      (lambda (x) (reftex-get-bib-field "family" x))
      names)))
  
(defun reftex-get-ris-names (fields entry)
  (let ((names (reftex-get-bib-values fields entry)))
    (unless names
      (setq names (reftex-get-bib-values '("A2" "ED") entry)))

    (mapcar (lambda (x)
      ;; Replace given names with empty string
      ;; all after ',' or before '.'
      (while (string-match "[\\.a-zA-Z\\-]+\\.[ \t]*\\|,.*" x)
	(setq x (replace-match "" nil t x)))
      ;; trim end spaces
      (while (string-match "^[ \t]+\\|[ \t]+$" x)
	(setq x (replace-match "" nil t x)))
      x) names)))

(defun reftex-get-mets-names (field entry)
  (let ((names (reftex-get-bib-values (list field) entry)))
    (unless names
      (setq names (reftex-get-bib-values '("creator" "editor" "person") entry)))
    (mapcar  
      (lambda (x) 
	(let ((name (reftex-get-bib-field "family" x)))
	  (when (equal "" name)
	    (setq name (reftex-get-bib-field "full" x))
	    (if name
	      (while (string-match "[\\.a-zA-Z\\-]+\\.[ \t]*\\|,.*" name) ;; shrink to family name
		(setq name (replace-match "" nil t name)))
	      (setq name (reftex-get-bib-field "displayForm" x))))
	  name))
      names)))

(defun reftex-get-bib-values(fields entry)
  ;; Extract values of FIELDS from the ENTRY
  (let (values)
    (mapc
      (lambda (fieldname) 
	(mapc
	  (lambda (x)
	    ;; entry contains key as first element 
	    ;; without field name - do listp check
	    (when (and (listp x) (string= fieldname (car x))
		    (push (cdr x) values))))
	  entry))
      fields)
    (nreverse values)))

(defun reftex-get-ris-pages (entry)
  ;; concat number of start page and end page
  (let ((sp (reftex-get-bib-field "SP" entry))
	 (ep (reftex-get-bib-field "EP" entry)))
    (if sp
      (if (and ep (not (string= sp ep)))
	(concat sp "-" ep)
	sp)
      "")))

(defun reftex-join-values (alist)
  ;;Concat cdr elements of alist with its car, unless element is ""
  (let* ((map))
    (setq map (lambda (x)
		(if (listp x)
		  (let* ((non-nils (delq nil (mapcar map (cdr x)))))
		    (mapconcat 'identity non-nils (car x)))
		  (unless (equal "" x) x))))
    (funcall map alist)))

(defun reftex-get-tag(name)
  (let* ((start (point)))
    (unless (string-match ".*/" name) ;; empty tag
      (if (re-search-forward (concat "[ \t]*\\(.*?\\)[ \t]*</" name ">") nil t)
	(buffer-substring-no-properties (- (point) (length name) 3) start)
	(error "Missing end of tag: %s" name)))))

;;----------------------------------------------------------------
;; CREATE NEW FILES
;;----------------------------------------------------------------
(defun reftex-create-local-extdb-files ()
  "Create a new bibliography database files with all appropriate entries,
one for each external database definition from a document.
The name of each file is the same as name of definition, followed by '.local'.
"
  (interactive)
  (let 
    ((keys (reftex-all-used-citation-keys))
      (files (reftex-get-bibfile-list))
      (buffer-conf (current-buffer))
      (size 0)
      file)
    
    ;; for all external databases
    (save-excursion
      (dolist (file files)
	(when (symbolp file)
	  (let* ((name (symbol-name file))
		  (bibfile (concat name ".local"))
		  entries entry key type)
	
	    ;; for all used keys
	    (dolist (key keys)
	      (setq entry 
		(condition-case nil
		  (catch 'exit
		    (reftex-pop-to-external-entry (list name) key nil t buffer-conf t))
		  (error "" nil)))
	      (when entry 
		(delete key keys)
		(push entry entries)))

	    ;; store entries	    
	    (when entries
	      (setq type (reftex-get-entry-type (car entries))) 
	      (setq size (+ size (length entries)))
	      (reftex-create-save-entries entries 
		(concat bibfile "." type) type
		))))))
    (message "%d entries extracted and copied to new database" size)
    ))

(defun reftex-create-epr-file (bibfile)
  "Create a new Eprints database file with all entries referenced in document.
The command prompts for a filename and writes the collected
entries to that file.  Only entries referenced in the current
document with any \\cite-like macros are used.  The sequence in
the new file is the same as it was in the old database."
  (interactive "FNew Eprints file: ")
  (let ((keys (reftex-all-used-citation-keys))
	 (files (reftex-get-bibfile-list))
	 file key entries beg end entry)
    (save-excursion
      (dolist (file files)
	(unless (or (symbolp file) (not (string= "epr" (reftex-get-buffer-type file))))
	  (set-buffer (reftex-get-file-buffer-force file 'mark))
	  (reftex-with-special-syntax-for-bib
	    (save-excursion
	      (save-restriction
		(widen)
		(goto-char (point-min))
		(while (re-search-forward
			 "<eprint[ \t]+id[ \t]*=[ \t]*\"\\([^ ]+\\)\"" nil t)
		  (goto-char (match-end 0))
		  (setq key (reftex-match-string 1)
		    beg (match-beginning 0)
		    end (when (re-search-forward "</eprint>" nil t)
			  (match-end 0)))
		       
		  (when (and end (member key keys))
		    (setq entry (buffer-substring-no-properties beg end)
		      entries (cons entry entries)
		      keys (delete key keys)))
		  )))))))
    ;; store entries
    (if entries
      (reftex-create-save-entries entries bibfile "epr"))
    (message "%d entries extracted and copied to new database" (length entries))
  ))

(defun reftex-create-ris-file (bibfile)
  "Create a new RIS database file with all entries referenced in document.
The command prompts for a filename and writes the collected
entries to that file.  Only entries referenced in the current
document with any \\cite-like macros are used.  The sequence in
the new file is the same as it was in the old database."
  (interactive "FNew RIS file: ")
  (let ((keys (reftex-all-used-citation-keys))
	 (files (reftex-get-bibfile-list))
	 file key entries beg end entry)
    (save-excursion
      (dolist (file files)
	(unless (or (symbolp file) (not (string= "ris" (reftex-get-buffer-type file))))
	  (set-buffer (reftex-get-file-buffer-force file 'mark))
	  (reftex-with-special-syntax-for-bib
	    (save-excursion
	      (save-restriction
		(widen)
		(goto-char (point-min))
		(while (re-search-forward "^TY  - .+" nil t)
		  (goto-char (match-end 0))
		  (setq beg (match-beginning 0)
		    end (when (re-search-forward "^ER  - " nil t)
			  (match-end 0)))
		  (when end
		    (setq key (when (re-search-backward  "ID  - \\([^ \t\r\n]+\\)" beg t)
				(reftex-match-string 1)))
		    (when (member key keys)
		      (setq entry (buffer-substring-no-properties beg end)
			entries (cons entry entries)
			keys (delete key keys)))
		    ))))))))
    ;; store entries
    (if entries
      (reftex-create-save-entries entries bibfile "ris"))
    (message "%d entries extracted and copied to new database" (length entries))
    ))

(defun reftex-create-mets-file (bibfile)
  "Create a new METS database file with all entries referenced in document.
The command prompts for a filename and writes the collected
entries to that file.  Only entries referenced in the current
document with any \\cite-like macros are used.  The sequence in
the new file is the same as it was in the old database."
  (interactive "FNew METS file: ")
  (let ((keys (reftex-all-used-citation-keys))
	 (files (reftex-get-bibfile-list))
	 file key entries beg end entry string-keys string-entries)
    (save-excursion
      (dolist (file files)
	(unless (or (symbolp file) (not (string= "mets" (reftex-get-buffer-type file))))
	  (set-buffer (reftex-get-file-buffer-force file 'mark))
	  (reftex-with-special-syntax-for-bib
	    (save-excursion
	      (save-restriction
		(widen)
		(goto-char (point-min))
		(while (re-search-forward "<mets:mets " nil t)
		  (goto-char (match-end 0))
		  (setq beg (match-beginning 0)
		    end (when (re-search-forward "</mets:mets>" nil t)
			  (match-end 0)))
		  (when end
		    (setq key (when (re-search-backward  
			  "<mets:dmdSec[ \t]+ID[ \t]*=[ \t]*\"DMD_oai:\\([^ \t]+\\)\"" 
				      beg t)
				(reftex-match-string 1)))
		    (when (member key keys)
		      (setq entry (buffer-substring-no-properties beg end)
			entries (cons entry entries)
			keys (delete key keys)))
		    ))))))))
  ;; store entries
    (if entries
      (reftex-create-save-entries entries bibfile "mets"))
    (message "%d entries extracted and copied to new database" (length entries))
  ))

(defun reftex-create-save-entries (entries file type)
  "Save entries to file of given type"
  (let (hf)
    (find-file-other-window file)
    (if (> (buffer-size) 0)
      (unless (yes-or-no-p
		(format "Overwrite non-empty file %s? " file))
	(error "Abort")))
    
    ;; Save data to a file
    (erase-buffer)
    (setq hf (symbol-value (intern (concat "reftex-create-" type "-header"))))
    (if hf (insert hf "\n\n"))
  
    (insert (mapconcat 'identity (reverse entries) "\n\n"))
    (insert "\n")

    (setq hf (symbol-value (intern (concat "reftex-create-" type "-footer"))))
    (if hf (insert hf "\n\n"))
    
    (goto-char (point-min))
    (save-buffer)))