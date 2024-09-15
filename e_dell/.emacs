

(setq use-package-verbose t)


(setq auto-window-vscroll nil) ;; better scrolling,
;; based on https://emacs.stackexchange.com/questions/28736/emacs-pointcursor-movement-lag

(defconst toc:xemacs-config-dir "/home/johannes/.emacs.d/config/" "")

(setq custom-file (concat toc:xemacs-config-dir "custom-file.el"))
(load custom-file)


;; (defun contains-elpa (x) (not (string-match "elpa" x)))
;; (setq package-load-list '())
;; (setq load-path (remove-if-not #'contains-elpa load-path))

;; (setq load-path nil)

(defun toc:load-config-file (filelist)
  (dolist (file filelist)
    (load (expand-file-name 
            (concat toc:xemacs-config-dir file)))
    (message "Loaded config file:%s" file)
    ))

(lossage-size 10000)

(toc:load-config-file '(
			 "look-feel.el"
			 "paths.el"
			 "packages.el"
			 "excorporate-extra.el"
			 "packages-secondary.el"
			 "packages-optional.el"
			 ;; "packages-retired.el"
			 "custom_funcs.el"
			 "language-learning.el"
			 "eval-in-repl.el" ;; needs both to not switch windows
			 "eval-in-repl-ielm.el"
			 "tex.el"
			 "org-wc.el"
			 "org-agenda.el"
			 "keybindings.el"
			 "mail.el"
			 "lilypond.el"
			 "org-recoll.el"
			 "org-clocktable-by-tag.el"
			 ))















(put 'list-timers 'disabled nil)
;; hello
