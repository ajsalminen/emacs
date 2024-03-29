;;; muse-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "muse" "muse.el" (21470 1432 0 0))
;;; Generated autoloads from muse.el
 (add-to-list 'auto-mode-alist '("\\.muse\\'" . muse-mode-choose-mode))

;;;***

;;;### (autoloads nil "muse-blosxom" "muse-blosxom.el" (21470 1432
;;;;;;  0 0))
;;; Generated autoloads from muse-blosxom.el

(autoload 'muse-blosxom-new-entry "muse-blosxom" "\
Start a new blog entry with given CATEGORY.
The filename of the blog entry is derived from TITLE.
The page will be initialized with the current date and TITLE.

\(fn CATEGORY TITLE)" t nil)

;;;***

;;;### (autoloads nil "muse-colors" "muse-colors.el" (21470 1432
;;;;;;  0 0))
;;; Generated autoloads from muse-colors.el

(autoload 'muse-colors-toggle-inline-images "muse-colors" "\
Toggle display of inlined images on/off.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "muse-import-docbook" "muse-import-docbook.el"
;;;;;;  (21470 1433 0 0))
;;; Generated autoloads from muse-import-docbook.el

(autoload 'muse-import-docbook "muse-import-docbook" "\
Convert the Docbook buffer SRC to Muse, writing output in the DEST buffer.

\(fn SRC DEST)" t nil)

(autoload 'muse-import-docbook-files "muse-import-docbook" "\
Convert the Docbook file SRC to Muse, writing output to the DEST file.

\(fn SRC DEST)" t nil)

;;;***

;;;### (autoloads nil "muse-import-latex" "muse-import-latex.el"
;;;;;;  (21470 1432 0 0))
;;; Generated autoloads from muse-import-latex.el

(autoload 'muse-import-latex "muse-import-latex" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "muse-mode" "muse-mode.el" (21470 1433 0 0))
;;; Generated autoloads from muse-mode.el

(autoload 'muse-mode "muse-mode" "\
Muse is an Emacs mode for authoring and publishing documents.
\\{muse-mode-map}

\(fn)" t nil)

(autoload 'muse-mode-choose-mode "muse-mode" "\
Turn the proper Emacs Muse related mode on for this file.

\(fn)" nil nil)

(autoload 'muse-insert-list-item "muse-mode" "\
Insert a list item at the current point, taking into account
your current list type and indentation level.

\(fn)" t nil)

(autoload 'muse-increase-list-item-indentation "muse-mode" "\
Increase the indentation of the current list item.

\(fn)" t nil)

(autoload 'muse-decrease-list-item-indentation "muse-mode" "\
Decrease the indentation of the current list item.

\(fn)" t nil)

(autoload 'muse-insert-relative-link-to-file "muse-mode" "\
Insert a relative link to a file, with optional description, at point.

\(fn)" t nil)

(autoload 'muse-edit-link-at-point "muse-mode" "\
Edit the current link.
Do not rename the page originally referred to.

\(fn)" t nil)

(autoload 'muse-browse-result "muse-mode" "\
Visit the current page's published result.

\(fn STYLE &optional OTHER-WINDOW)" t nil)

(autoload 'muse-follow-name-at-point "muse-mode" "\
Visit the link at point.

\(fn &optional OTHER-WINDOW)" t nil)

(autoload 'muse-follow-name-at-point-other-window "muse-mode" "\
Visit the link at point in other window.

\(fn)" t nil)

(autoload 'muse-next-reference "muse-mode" "\
Move forward to next Muse link or URL, cycling if necessary.

\(fn)" t nil)

(autoload 'muse-previous-reference "muse-mode" "\
Move backward to the next Muse link or URL, cycling if necessary.
In case of Emacs x <= 21 and ignoring of intangible properties (see
`muse-mode-intangible-links').

This function is not entirely accurate, but it's close enough.

\(fn)" t nil)

(autoload 'muse-what-changed "muse-mode" "\
Show the unsaved changes that have been made to the current file.

\(fn)" t nil)

(autoload 'muse-search-with-command "muse-mode" "\
Search for the given TEXT string in the project directories
using the specified command.

\(fn TEXT)" t nil)

(autoload 'muse-search "muse-mode" "\
Search for the given TEXT using the default grep command.

\(fn)" t nil)

(autoload 'muse-find-backlinks "muse-mode" "\
Grep for the current pagename in all the project directories.

\(fn)" t nil)

(autoload 'muse-index "muse-mode" "\
Display an index of all known Muse pages.

\(fn)" t nil)

(autoload 'muse-insert-tag "muse-mode" "\
Insert a tag interactively with a blank line after it.

\(fn TAG)" t nil)

(autoload 'muse-list-edit-minor-mode "muse-mode" "\
This is a global minor mode for editing files with lists.
It is meant to be used with other major modes, and not with Muse mode.

Interactively, with no prefix argument, toggle the mode.
With universal prefix ARG turn mode on.
With zero or negative ARG turn mode off.

This minor mode provides the Muse keybindings for editing lists,
and support for filling lists properly.

It recognizes not only Muse-style lists, which use the \"-\"
character or numbers, but also lists that use asterisks or plus
signs.  This should make the minor mode generally useful.

Definition lists and footnotes are also recognized.

Note that list items may omit leading spaces, for compatibility
with modes that set `left-margin', such as
`debian-changelog-mode'.

\\{muse-list-edit-minor-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "muse-project" "muse-project.el" (21470 1433
;;;;;;  0 0))
;;; Generated autoloads from muse-project.el

(autoload 'muse-project-find-file "muse-project" "\
Open the Muse page given by NAME in PROJECT.
If COMMAND is non-nil, it is the function used to visit the file.
If DIRECTORY is non-nil, it is the directory in which the page
will be created if it does not already exist.  Otherwise, the
first directory within the project's fileset is used.

\(fn NAME PROJECT &optional COMMAND DIRECTORY)" t nil)

(autoload 'muse-project-publish-this-file "muse-project" "\
Publish the currently-visited file according to `muse-project-alist',
prompting if more than one style applies.

If FORCE is given, publish the file even if it is up-to-date.

If STYLE is given, use that publishing style rather than
prompting for one.

\(fn &optional FORCE STYLE)" t nil)

(autoload 'muse-project-publish "muse-project" "\
Publish the pages of PROJECT that need publishing.

\(fn PROJECT &optional FORCE)" t nil)

;;;***

;;;### (autoloads nil "muse-protocols" "muse-protocols.el" (21470
;;;;;;  1433 0 0))
;;; Generated autoloads from muse-protocols.el

(autoload 'muse-browse-url "muse-protocols" "\
Handle URL with the function specified in `muse-url-protocols'.
If OTHER-WINDOW is non-nil, open in a different window.

\(fn URL &optional OTHER-WINDOW)" t nil)

;;;***

;;;### (autoloads nil "muse-publish" "muse-publish.el" (21470 1433
;;;;;;  0 0))
;;; Generated autoloads from muse-publish.el

(autoload 'muse-publish-region "muse-publish" "\
Apply the given STYLE's markup rules to the given region.
The result is placed in a new buffer that includes TITLE in its name.

\(fn BEG END &optional TITLE STYLE)" t nil)

(autoload 'muse-publish-file "muse-publish" "\
Publish the given FILE in a particular STYLE to OUTPUT-DIR.
If the argument FORCE is nil, each file is only published if it is
newer than the published version.  If the argument FORCE is non-nil,
the file is published no matter what.

\(fn FILE STYLE &optional OUTPUT-DIR FORCE)" t nil)

(autoload 'muse-publish-this-file "muse-publish" "\
Publish the currently-visited file.
Prompt for both the STYLE and OUTPUT-DIR if they are not
supplied.

\(fn STYLE OUTPUT-DIR &optional FORCE)" t nil)

;;;***

;;;### (autoloads nil nil ("cgi.el" "htmlize-hack.el" "httpd.el"
;;;;;;  "muse-backlink.el" "muse-book.el" "muse-context.el" "muse-docbook.el"
;;;;;;  "muse-groff.el" "muse-html.el" "muse-http.el" "muse-ikiwiki.el"
;;;;;;  "muse-import-xml.el" "muse-ipc.el" "muse-journal.el" "muse-latex.el"
;;;;;;  "muse-latex2png.el" "muse-pkg.el" "muse-poem.el" "muse-regexps.el"
;;;;;;  "muse-texinfo.el" "muse-wiki.el" "muse-xml-common.el" "muse-xml.el")
;;;;;;  (21470 1433 579523 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; muse-autoloads.el ends here
