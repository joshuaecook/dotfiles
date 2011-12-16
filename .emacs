(defun my-add-user-load-path (path)
  (if (fboundp 'locate-user-emacs-file)
      (add-to-list 'load-path (locate-user-emacs-file path))
    (add-to-list 'load-path (concat "~/.emacs.d/" path))))

(my-add-user-load-path "share/emacs/site-lisp")
(my-add-user-load-path "share/emacs/site-lisp/emcien")

(when (locate-library "package")
  (load-library "package"))

(require 'which-func)
(which-func-mode t)

;; CEDET mode
(if (locate-library "cedet") (load "cedet") '())

;; Autoinsert mode
(require 'autoinsert)
(auto-insert-mode)
(my-add-user-load-path "autoinsert")
(setq auto-insert-query nil)
(define-auto-insert "\\.sh\\'" "autoinsert.sh")

;; Fly make mode
(require 'flymake)

;; GDB mode
(setq gdb-many-windows t)

;; Egg mode for git
(my-add-user-load-path "share/emacs/site-lisp/egg")
(require 'egg)

;; MATLAB mode
;; (my-add-user-load-path "share/emacs/site-lisp/matlab-emacs")
;; (load "matlab-load")

;; Muse mode
;; (add-to-list 'load-path (locate-user-emacs-file "share/emacs/site-lisp/muse/lisp"))
;; (require 'muse)
;; (require 'muse-mode)
;; (require 'muse-project)
;; (require 'muse-html)
;; (require 'muse-latex)
;; (require 'muse-latex2png)
;; (require 'muse-mfigure)
;; (require 'muse-subsup)

;; SML mode
;; (add-to-list 'load-path (locate-user-emacs-file "share/emacs/site-lisp/sml-mode"))
;; (load "sml-mode-startup")

;; JavaScript mode
(setq js-indent-level 2)
(add-to-list 'load-path "/usr/local/lib/node_modules/jshint-mode")
(require 'flymake-jshint)
(add-hook 'javascript-mode-hook
    (lambda () (flymake-mode t)))

;; Ruby mode
(my-add-user-load-path "share/emacs/site-lisp/ruby-mode")
(autoload 'ruby-mode "ruby-mode")
(autoload 'rdoc-mode "rdoc-mode")
(autoload 'run-ruby "inf-ruby")
(autoload 'inf-ruby-keys "inf-ruby")
(add-to-list 'interpreter-mode-alist '(("ruby" . ruby-mode)))
(defun my-ruby-mode-hook ()
  (inf-ruby-keys))
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

;; Emacs Rails minor mode
;; (my-add-user-load-path "share/emacs/site-lisp/emacs-rails")
;; (require 'rails)

;; C++ mode for CUDA
(add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))
;; UI tweaks
(my-add-user-load-path "share/emacs/site-lisp/color-theme")
(cond ((and (>= emacs-major-version 24)
            (fboundp 'load-theme))
       (load-theme 'wheatgrass))
      ((locate-library "color-theme")
       (load-library "color-theme")
       (color-theme-initialize)
       (color-theme-billw)))

(setq-default tab-width 8)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 2)
(setq inhibit-startup-message t)
(show-paren-mode t)
(setq show-trailing-whitespace t)
(setq truncate-lines t)
(setq visible-bell t)
;; Don't require "yes" to be spelled out in prompts
(fset 'yes-or-no-p 'y-or-n-p)
;; Period followed by space ends sentence
(setq sentence-end-double-space nil)
;; Put one space after a colon when filling
(setq colon-double-space nil)
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode 'right))
(menu-bar-mode -1)
(when (fboundp 'scroll-bar-mode) (tool-bar-mode -1))
(mouse-avoidance-mode 'cat-and-mouse)
(mouse-wheel-mode -1)
(when (fboundp 'global-font-lock-mode) (global-font-lock-mode t))
(when (fboundp 'global-hi-lock-mode) (global-hi-lock-mode t))
;; defaults to unified diffs
(setq diff-switches "-u")

;; Enables saving minibuffer history
(setq savehist-additional-variables
      '(search-ring regexp-search-ring)
      savehist-file "~/.emacs.d/savehist")
(savehist-mode t)

;; Stores backups out of the way
(defun my-make-backup-file-name (file-name)
  (let* ((backup-root (concat temporary-file-directory (user-login-name) "/emacs/backup/"))
	 (backup-path (concat backup-root file-name "~")))
    (make-directory (file-name-directory backup-path) t)
    backup-path))

(setq make-backup-file-name-function 'my-make-backup-file-name)

;; Custom keys and behaviour
(defun my-move-beginning-of-line (arg)
  "Moves point to beginning of current line
or to the first non-space character in the line."
  (interactive "p")
  (if (and (or (not arg) (= 1 arg))
	   (looking-at "^"))
      (skip-chars-forward " \t")
    (move-beginning-of-line arg)))
(global-set-key "\C-a" 'my-move-beginning-of-line)
(global-set-key [home] 'my-move-beginning-of-line)

(defun my-next-line (arg)
  "Moves point to end of current line,
inserts a newline, and moves forward to indent."
  (interactive "^p")
  (or arg (setq arg 1))
  (move-end-of-line 1)
  (newline-and-indent))
(global-set-key "\M-\C-M" 'my-next-line)

(defun my-eval-and-replace-sexp ()
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))
(global-set-key "\C-ce" 'my-eval-and-replace-sexp)

(global-set-key "\C-cf" 'auto-fill-mode)
(global-set-key "\C-cM" 'matlab-shell)
(global-set-key "\C-cm" 'compile)
(global-set-key "\C-cg" 'gdb)

(global-set-key "\M-/" 'hippie-expand)


;; Starts the emacs server
(server-start)

;; Zone out
;; (require 'zone)
;; (zone-when-idle 59)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(egg-log-HEAD-max-len 100)
 '(egg-refresh-index-in-backround t)
 '(rails-enable-ruby-electric nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
