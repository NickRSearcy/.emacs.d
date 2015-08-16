(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; Simple package names
(el-get-bundle ess)
(el-get-bundle auctex)
(el-get-bundle dired+)
(el-get-bundle magit)
(el-get-bundle markdown-mode)
(el-get-bundle pandoc-mode)
(el-get-bundle exec-path-from-shell)
(el-get-bundle solarized-emacs)

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

; first thing is to fix our fucking path
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; reuse buffer in dired+
(diredp-toggle-find-file-reuse-dir 0)

;; turn on winner mode to let use save and undo window operations
(winner-mode 1)

;; set up slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/local/bin/sbcl")

;; set up org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(org-babel-load-languages (quote ((emacs-lisp . t) (R . t))))
 '(org-confirm-babel-evaluate nil))

(define-skeleton org-skeleton
  "Header info for a emacs-org file."
  "Title: "
  "#+TITLE:" str " \n"
  "#+AUTHOR: Your Name\n"
  "#+email: your-email@server.com\n"
  "#+INFOJS_OPT: \n"
  "#+BABEL: :session *R* :cache yes :results output graphics :exports both :tangle yes \n"
  "-----"
 )
(global-set-key [C-S-f4] 'org-skeleton)

; Must have org-mode loaded before we can configure org-babel
(require 'org-install)

; Some initial langauges we want org-babel to support
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   (lisp . t)
   ))

(setq org-babel-python-command "python3")

(setq org-babel-lisp-command "sbcl")

(setq org-src-fontify-natively t)


;;;;;; Make emacs more like a normal text editor ;;;;;;
;; http://ergoemacs.org/emacs/emacs_make_modern.html

(global-visual-line-mode 1) ;; Turn on visual line mode (word wrap)
(electric-pair-mode 1) ;; auto-match brackets and such
(show-paren-mode 1) ; turn on paren match highlighting

(load-theme 'solarized-dark t)

;; set up pandoc as default for markdown
(add-hook 'markdown-mode-hook 'pandoc-mode)
(put 'dired-find-alternate-file 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
