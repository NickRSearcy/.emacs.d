((auctex status "installed" recipe
	 (:name auctex :after nil :website "http://www.gnu.org/software/auctex/" :description "AUCTeX is an extensible package for writing and formatting TeX files in GNU Emacs and XEmacs. It supports many different TeX macro packages, including AMS-TeX, LaTeX, Texinfo, ConTeXt, and docTeX (dtx files)." :type git :module "auctex" :url "git://git.savannah.gnu.org/auctex.git" :build
		`(("./autogen.sh")
		  ("./configure" "--without-texmf-dir" "--with-packagelispdir=$(pwd)" "--with-packagedatadir=$(pwd)" ,(cond
														       ((eq system-type 'darwin)
															"--with-lispdir=`pwd`")
														       (t ""))
		   ,(concat "--with-emacs=" el-get-emacs))
		  "make")
		:load-path
		(".")
		:load
		("tex-site.el" "preview-latex.el")
		:info "doc"))
 (cl-lib status "installed" recipe
	 (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :url "http://elpa.gnu.org/packages/cl-lib.html"))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (dired+ status "installed" recipe
	 (:name dired+ :after nil :features
		(dired+)
		:description "Extensions to Dired" :type emacswiki))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
		("el-get.*\\.el$" "methods/")
		:features el-get :post-init
		(when
		    (memq 'el-get
			  (bound-and-true-p package-activated-list))
		  (message "Deleting melpa bootstrap el-get")
		  (unless package--initialized
		    (package-initialize t))
		  (when
		      (package-installed-p 'el-get)
		    (let
			((feats
			  (delete-dups
			   (el-get-package-features
			    (el-get-elpa-package-directory 'el-get)))))
		      (el-get-elpa-delete-package 'el-get)
		      (dolist
			  (feat feats)
			(unload-feature feat t))))
		  (require 'el-get))))
 (ess status "installed" recipe
      (:name ess :after nil :description "Emacs Speaks Statistics: statistical programming within Emacs" :type github :pkgname "emacs-ess/ESS" :website "http://ess.r-project.org/" :info "doc/info/" :build
	     `(("make" "clean" "all" ,(concat "EMACS="
					      (shell-quote-argument el-get-emacs))))
	     :load "ess-autoloads.el" :prepare
	     (progn
	       (autoload 'R-mode "ess-site" nil t)
	       (autoload 'Rd-mode "ess-site" nil t)
	       (autoload 'Rnw-mode "ess-site" nil t))))
 (exec-path-from-shell status "installed" recipe
		       (:name exec-path-from-shell :after nil :website "https://github.com/purcell/exec-path-from-shell" :description "Emacs plugin for dynamic PATH loading" :type github :pkgname "purcell/exec-path-from-shell"))
 (git-modes status "installed" recipe
	    (:name git-modes :description "GNU Emacs modes for various Git-related files" :type github :branch "master" :pkgname "magit/git-modes"))
 (hydra status "installed" recipe
	(:name hydra :description "make Emacs bindings that stick around" :type github :depends
	       (cl-lib)
	       :pkgname "abo-abo/hydra"))
 (magit status "installed" recipe
	(:name magit :after nil :website "https://github.com/magit/magit#readme" :description "It's Magit! An Emacs mode for Git." :type github :pkgname "magit/magit" :branch "master" :minimum-emacs-version "24.4" :depends
	       (dash)
	       :info "Documentation" :load-path "lisp/" :compile "lisp/" :build
	       `(("make" ,(format "EMACSBIN=%s" el-get-emacs)
		  "docs"))
	       :build/berkeley-unix
	       `(("gmake" ,(format "EMACSBIN=%s" el-get-emacs)
		  "docs"))
	       :build/windows-nt
	       (progn nil)))
 (markdown-mode status "installed" recipe
		(:name markdown-mode :description "Major mode to edit Markdown files in Emacs" :website "http://jblevins.org/projects/markdown-mode/" :type git :url "git://jblevins.org/git/markdown-mode.git" :prepare
		       (add-to-list 'auto-mode-alist
				    '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))))
 (multiple-cursors status "installed" recipe
		   (:name multiple-cursors :description "An experiment in adding multiple cursors to emacs" :type github :pkgname "magnars/multiple-cursors.el"))
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/ba08b24186711eaeb3748f3d1f23e2c2d9ed0d09:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
		 (progn
		   (let
		       ((old-package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))))
		     (when
			 (file-directory-p old-package-user-dir)
		       (add-to-list 'package-directory-list old-package-user-dir)))
		   (setq package-archives
			 (bound-and-true-p package-archives))
		   (mapc
		    (lambda
		      (pa)
		      (add-to-list 'package-archives pa 'append))
		    '(("ELPA" . "http://tromey.com/elpa/")
		      ("melpa" . "http://melpa.org/packages/")
		      ("gnu" . "http://elpa.gnu.org/packages/")
		      ("marmalade" . "http://marmalade-repo.org/packages/")
		      ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (pandoc-mode status "installed" recipe
	      (:name pandoc-mode :after nil :type github :description "Emacs mode for interacting with Pandoc." :pkgname "joostkremers/pandoc-mode" :depends
		     (dash hydra)))
 (solarized-emacs status "installed" recipe
		  (:name solarized-emacs :after nil :description "Solarized for Emacs is an Emacs port of the Solarized theme for vim, developed by Ethan Schoonover." :website "https://github.com/bbatsov/solarized-emacs" :minimum-emacs-version "24" :type github :pkgname "bbatsov/solarized-emacs" :depends dash :prepare
			 (add-to-list 'custom-theme-load-path default-directory))))
