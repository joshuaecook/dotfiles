(add-to-list 'load-path (locate-user-emacs-file "share/emacs/site-lisp"))
(add-to-list 'load-path (locate-user-emacs-file "share/emacs/site-lisp/simatra"))


(add-to-list 'load-path (locate-user-emacs-file "share/emacs/site-lisp/cedet/common"))
(load "cedet")

;; GDB mode
(setq gdb-many-windows t)

;; MATLAB mode
(add-to-list 'load-path (locate-user-emacs-file "share/emacs/site-lisp/matlab-emacs"))
(require 'matlab-load)

;; Muse mode
(add-to-list 'load-path (locate-user-emacs-file "share/emacs/site-lisp/muse/lisp"))
(require 'muse)
(require 'muse-mode)
(require 'muse-project)
(require 'muse-html)
(require 'muse-latex)
(require 'muse-latex2png)
(require 'muse-mfigure)
(require 'muse-subsup)

;; SML mode
(add-to-list 'load-path (locate-user-emacs-file "share/emacs/site-lisp/sml-mode"))
(load "sml-mode-startup")

;; C++ mode for CUDA
(add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))

;; UI tweaks
(add-to-list 'load-path (locate-user-emacs-file "share/emacs/site-lisp/color-theme"))
(require 'color-theme)
(color-theme-initialize)
(color-theme-billw)

(setq inhibit-startup-message t)
(show-paren-mode t)
(setq truncate-lines t)
;; Don't require "yes" to be spelled out in prompts
(fset 'yes-or-no-p 'y-or-n-p)
(scroll-bar-mode 'right)
(menu-bar-mode -1)
(tool-bar-mode -1)
(mouse-avoidance-mode 'cat-and-mouse)
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))
(setq-default intent-tabs-mode nil)

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
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
