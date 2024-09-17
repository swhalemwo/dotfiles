(setq history-delete-duplicates t)

(defvar outline-minor-mode-prefix "\M-#")

(setq comp-deferred-compilation t)
(setq server-mode t)
(setq debug-on-error t)

(setq case-fold-search t) ;; searches ignore case
(setq-default case-fold-search t) ;; searches ignore case

(setq column-number-mode t)
(setq csv-separators '(","))


(setq custom-theme-directory "~/Dropbox/technical_stuff_general/dotfiles/.emacs.d/config/my-themes/")
(load-theme 'my-light-blue t)


(setq show-paren-delay 0.1)
(show-paren-mode t)

(setq split-height-threshold 80)
(setq split-width-threshold1 60)

(setq display-battery-mode t)
(setq display-time-mail-face 'org-mode-line-clock-overrun)
(setq display-time-use-mail-icon t)
(setq echo-keystrokes 0.01)

(savehist-mode 1)
(put 'upcase-region 'disabled nil)

(setq inhibit-startup-screen t)
(setq latex-run-command "pdflatex %b")
(setq linum-format 'dynamic)
(setq lisp-body-indent 2)
(setq indent-tabs-mode nil)

(menu-bar-mode -1)

(global-visual-line-mode 1)

(tool-bar-mode -1)
(setq frame-resize-pixelwise t)
(setq window-resize-pixelwise t)
(setq frame-inhibit-implied-resize t)

;; (setq window-adjust-process-window-size-function 'ignore)

(fringe-mode 0) ;; gets rid of pesky white bars on the sides

(defalias 'yes-or-no-p 'y-or-n-p)

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "/usr/bin/brave")

(setq ns-use-srgb-colorspace nil) ;; ????

(setq hs-hide-comments-when-hiding-all nil) ;; don't fold comments in hs-minor-mode (if t, eats up outshine headers)


(setq lisp-indent-offset 2) ;; e/lisp offset to 2 (less horizontal space wasted)


(add-hook 'after-init-hook 'global-company-mode)

(setq frame-title-format
      '("emacs " emacs-version " @ "
	    (buffer-file-name
            "%f"
            (dired-directory dired-directory "%b"))))


;; * elisp stuff
(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 10000)

(setq enable-recursive-minibuffers t)



;; (setq ansi-color-map [default bold default italic underline success warning error nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil
;;     (foreground-color . "black")
;;     (foreground-color . "red3")
;;     (foreground-color . "sienna")
;;     (foreground-color . "ForestGreen")
;;     (foreground-color . "blue3")
;;     (foreground-color . "magenta3")
;;     (foreground-color . "Magenta4")
;;     (foreground-color . "gray90")
;;     nil nil
;;     (background-color . "black")
;;     (background-color . "red3")
;;     (background-color . "green3")
;;     (background-color . "yellow3")
;;     (background-color . "blue2")
;;     (background-color . "magenta3")
;;     (background-color . "cyan3")
;;     (background-color . "gray90")
;;     nil nil])

;; * async shell
(setq async-shell-command-buffer 'rename-buffer)
(setq async-shell-command-display-buffer nil)

;; ** nicer checkboxes

(defun nice-orgmode-checkboxes ()
  "Beautify Org Checkbox Symbol"
  (push '("[ ]" .  "囗") prettify-symbols-alist)
  (push '("[X]" . "井" ) prettify-symbols-alist) ;; 囗田
  (push '("[-]" . "龙" ) prettify-symbols-alist) ;; 井
  (prettify-symbols-mode))

;; (remove-hook 'org-mode-hook 'nice-orgmode-checkboxes)
(add-hook 'org-mode-hook 'nice-orgmode-checkboxes)

;; don't make stupid backup files
(setq make-backup-files nil)


(put 'list-timers 'disabled nil) ;; don't give list-timers warning
