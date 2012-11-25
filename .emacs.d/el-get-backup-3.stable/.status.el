((apel status "installed" recipe
       (:name apel :website "http://www.kanji.zinbun.kyoto-u.ac.jp/~tomo/elisp/APEL/" :description "APEL (A Portable Emacs Library) is a library to support to write portable Emacs Lisp programs." :type github :pkgname "wanderlust/apel" :build
	      (mapcar
	       (lambda
		 (target)
		 (list el-get-emacs
		       (split-string "-batch -q -no-site-file -l APEL-MK -f")
		       target "prefix" "site-lisp" "site-lisp"))
	       '("compile-apel" "install-apel"))
	      :load-path
	      ("site-lisp/apel" "site-lisp/emu")))
 (bbdb status "required" recipe nil)
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :features el-get :info "." :load "el-get.el"))
 (flim status "installed" recipe
       (:name flim :description "A library to provide basic features about message representation or encoding" :depends apel :type github :branch "flim-1_14-wl" :pkgname "wanderlust/flim" :build
	      (mapcar
	       (lambda
		 (target)
		 (list el-get-emacs
		       (mapcar
			(lambda
			  (pkg)
			  (mapcar
			   (lambda
			     (d)
			     `("-L" ,d))
			   (el-get-load-path pkg)))
			'("apel"))
		       (split-string "-batch -q -no-site-file -l FLIM-MK -f")
		       target "prefix" "site-lisp" "site-lisp"))
	       '("compile-flim" "install-flim"))
	      :load-path
	      ("site-lisp/flim")))
 (google-weather status "installed" recipe
		 (:name google-weather :description "Fetch Google Weather forecasts." :type git :url "git://git.naquadah.org/google-weather-el.git" :features
			(google-weather org-google-weather)))
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin 24 :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
		 (progn
		   (setq package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))
			 package-directory-list
			 (list
			  (file-name-as-directory package-user-dir)
			  "/usr/share/emacs/site-lisp/elpa/"))
		   (make-directory package-user-dir t)
		   (unless
		       (boundp 'package-subdirectory-regexp)
		     (defconst package-subdirectory-regexp "^\\([^.].*\\)-\\([0-9]+\\(?:[.][0-9]+\\)*\\)$" "Regular expression matching the name of\n a package subdirectory. The first subexpression is the package\n name. The second subexpression is the version string."))
		   (setq package-archives
			 '(("ELPA" . "http://tromey.com/elpa/")
			   ("gnu" . "http://elpa.gnu.org/packages/")
			   ("marmalade" . "http://marmalade-repo.org/packages/")
			   ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (semi status "installed" recipe
       (:name semi :description "SEMI is a library to provide MIME feature for GNU Emacs." :depends flim :type github :branch "semi-1_14-wl" :pkgname "wanderlust/semi" :build
	      (mapcar
	       (lambda
		 (target)
		 (list el-get-emacs
		       (mapcar
			(lambda
			  (pkg)
			  (mapcar
			   (lambda
			     (d)
			     `("-L" ,d))
			   (el-get-load-path pkg)))
			'("apel" "flim"))
		       (split-string "-batch -q -no-site-file -l SEMI-MK -f")
		       target "prefix" "site-lisp" "site-lisp"))
	       '("compile-semi" "install-semi"))
	      :load-path
	      ("site-lisp/semi/")))
 (tail status "installed" recipe
       (:name tail :description "Tail files within Emacs" :type http :url "http://www.drieu.org/code/sources/tail.el" :features tail :after
	      (lambda nil
		(autoload 'tail-file "tail.el" nil t))))
 (wanderlust status "installed" recipe
	     (:name wanderlust :description "Wanderlust bootstrap." :depends semi :type github :pkgname "wanderlust/wanderlust" :build
		    (mapcar
		     (lambda
		       (target-and-dirs)
		       (list el-get-emacs
			     (mapcar
			      (lambda
				(pkg)
				(mapcar
				 (lambda
				   (d)
				   `("-L" ,d))
				 (el-get-load-path pkg)))
			      (append
			       '("apel" "flim" "semi")
			       (when
				   (el-get-package-exists-p "bbdb")
				 (list "bbdb"))))
			     "--eval"
			     (el-get-print-to-string
			      '(progn
				 (setq wl-install-utils t)
				 (setq wl-info-lang "en")
				 (setq wl-news-lang "en")))
			     (split-string "-batch -q -no-site-file -l WL-MK -f")
			     target-and-dirs))
		     '(("wl-texinfo-format" "doc")
		       ("compile-wl-package" "site-lisp" "icons")
		       ("install-wl-package" "site-lisp" "icons")))
		    :info "doc/wl.info" :load-path
		    ("site-lisp/wl" "utils"))))
