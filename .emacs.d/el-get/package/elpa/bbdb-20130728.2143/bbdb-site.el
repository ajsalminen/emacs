;;; bbdb-site.el --- site-specific variables for BBDB

;; Copyright (C) 2013 Roland Winkler <winkler@gnu.org>

;; This file is part of the Insidious Big Brother Database (aka BBDB),

;; BBDB is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; BBDB is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with BBDB.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(if (< emacs-major-version 23)
  (error "BBDB requires GNU Emacs 23 or later"))

(defconst bbdb-version "@PACKAGE_VERSION@" "Version of BBDB.")

(defconst bbdb-version-date "@PACKAGE_DATE@"
  "Version date of BBDB.")

(defcustom bbdb-print-tex-path '("/usr/local/share")
  "List of directories with the BBDB tex files."
  :group 'bbdb-utilities-print
  :type '(repeat (directory :tag "Directory")))

(provide 'bbdb-site)
