

;; ** sql
(use-package sql-clickhouse

    :config
    ;; (sql-del-product 'clickhouse)
    (add-to-list 'sql-product-alist 
		 '(clickhouse :name "ClickHouse"
			      :font-lock sql-clickhouse-font-lock-keywords
			      :sqli-program sql-clickhouse-program
			      :prompt-regexp "^:) "
			      :prompt-length 3
			      :prompt-cont-regexp "^:-] "
			      :sqli-login sql-clickhouse-login-params
			      :sqli-options sql-clickhouse-options
			      :sqli-comint-func sql-clickhouse-comint))

    ;; (defun sql-send-string (str)
    ;; 	"Send the string STR to the SQL process."
    ;; 	(interactive "sSQL Text: ")

    ;; 	(let ((comint-input-sender-no-newline nil)
    ;;           (s (replace-regexp-in-string "[[:space:]\n\r]+\\'" "" str)))
    ;; 	    (if (sql-buffer-live-p sql-buffer)
    ;; 		    (progn
    ;; 			;; Ignore the hoping around...
    ;; 			(save-excursion
    ;; 			    ;; Set product context
    ;; 			    (with-current-buffer sql-buffer
    ;; 				(when sql-debug-send
    ;; 				    (message ">>SQL> %S" s))

    ;; 				;; Send the string (trim the trailing whitespace)
    ;; 				;; (message "buffer-process: %s" (get-buffer-process (get-buffer sql-buffer)))
    ;; 				;; (message "kappa")
				
    ;; 				(sql-input-sender (get-buffer-process (current-buffer)) s)

    ;; 				;; Send a command terminator if we must
    ;; 				(sql-send-magic-terminator sql-buffer s sql-send-terminator)

    ;; 				(when sql-pop-to-buffer-after-send-region
    ;; 				    (message "Sent string to buffer %s" sql-buffer))))

    ;; 			;; Display the sql buffer
    ;; 			;; (sql-display-buffer sql-buffer)
    ;; 			)

    ;; 		;; We don't have no stinkin' sql
    ;; 		(user-error "No SQL process started"))))
  
    (add-hook 'sql-mode-hook 'sqlup-mode)
    (add-hook 'sql-mode-hook 'sqlind-minor-mode)
  ;; (load "/home/johannes/Dropbox/technical_stuff_general/sql/ch_debug.el")
    )

;; ** org-drill

(require 'org-drill)


;; ** python

;; (use-package pyenv)

;; (use-package elpy
;;   ;; :defer t
;;   :init
;;   (elpy-enable) ;; maybe can be run as init? 
  
;;   :config
;;   (setq python-shell-interpreter "python3")
;;   (setq elpy-rpc-python-command "python3")
;;   (setq elpy-shell-echo-output nil)
;;   (add-hook 'elpy-mode-hook 'outshine-mode)
;;   (add-hook 'elpy-mode-hook (lambda ()(setq outline-heading-end-regexp "\n")))


;;   :bind (
;; 	  ;; ("C-c C-j" . 'elpy-shell-send-statement)
;; 	  ;; ("<C-return>" . 'elpy-shell-send-group) 
;; 	  ;; ("C-c C-o" . 'elpy-goto-definition)     
;; 	  ;; ("C-c C-j" . 'elpy-shell-send-statement)
;; 	  ;; ("C-c C-k" . 'elpy-summary-at-point)
;; 	  ("C-a" . 'back-to-indentation)

;; 	  )
;;   ;; :hook outshine-mode
;;   )




;; (define-key elpy-mode-map (kbd "<C-return>") 'elpy-shell-send-group)
;; (define-key elpy-mode-map (kbd "C-c C-o") 'elpy-goto-definition)
;; ;; (define-key elpy-mode-map (kbd "C-c C-j") 'elpy-shell-send-statement)
;; (define-key elpy-mode-map (kbd "C-c C-j") 'elpy-send-line)
;; (define-key elpy-mode-map (kbd "C-c o") 'helm-imenu)
;; (define-key elpy-mode-map (kbd "C-c C-k") 'elpy-summary-at-point)
;; (define-key elpy-mode-map (kbd "C-M-'") 'elpy-pretty-summary-at-point)
;; (define-key elpy-mode-map (kbd "C-c n") 'elpy-len-at-point)
;; (define-key elpy-mode-map (kbd "C-c i") 'elpy-names-at-point)

;; (define-key elpy-mode-map (kbd "C-c g") 'jpdb-send-group)
;; ;; (define-key elpy-mode-map (kbd "C-c j") 'jpdb-send-line)
;; ;; (define-key elpy-mode-map (kbd "C-c k") 'jpdb-summary-at-point)
;; (define-key elpy-mode-map (kbd "C-c r") 'jpdb-send-selection)
(define-key inferior-python-mode-map (kbd "M-r") 'consult-history)




;; (use-package explain-pause-mode
;;   :straight (explain-pause-mode :type git :host github :repo "lastquestion/explain-pause-mode")
;;   :config
;;   (explain-pause-mode))



;; ;; ** sqlite extras
;; (use-package sqlite-mode-extras
;;   :ensure t
;;   :hook ((sqlite-mode . sqlite-extras-minor-mode)))



;; ** graphviz
(use-package graphviz-dot-mode
    :config
    (setq graphviz-dot-indent-width 2)
    (setq graphviz-dot-preview-extension "pdf")
    (setq graphviz-dot-view-command "dot %s")
    )

;; ** ess
(use-package ess
  :ensure t
  :init (require 'ess-site)
  :config
  (setq ess-R-font-lock-keywords
    '((ess-R-fl-keyword:modifiers . t)
       (ess-R-fl-keyword:fun-defs . t)
       (ess-R-fl-keyword:keywords . t)
       (ess-R-fl-keyword:assign-ops . t)
       (ess-R-fl-keyword:constants . t)
       (ess-fl-keyword:fun-calls . t)
       (ess-fl-keyword:numbers . t)
       (ess-fl-keyword:operators . t)
       (ess-fl-keyword:delimiters . t)
       (ess-fl-keyword:= . t)
       (ess-R-fl-keyword:F&T . t)
       (ess-R-fl-keyword:%op%)))

  (setq ess-own-style-list
    '((ess-indent-offset . 8)
       (ess-offset-arguments . open-delim)
       (ess-offset-arguments-newline . prev-call)
       (ess-offset-block . prev-line)
       (ess-offset-continued . straight)
       (ess-align-nested-calls "ifelse")
       (ess-align-arguments-in-calls "function[ 	]*(")
       (ess-align-continuations-in-calls . t)
       (ess-align-blocks control-flow)
       (ess-indent-from-lhs arguments fun-decl-opening)
       (ess-indent-from-chain-start . t)
       (ess-indent-with-fancy-comments . t)))
  
  (setq ess-use-flymake nil)
  (setq ess-switch-to-end-of-proc-buffer t)
  (setq ess-use-auto-complete t)
  (setq ess-use-company t)

  :bind (:map ess-r-mode-map

	  ("C-<" . 'ess-insert-assign)
	  ("C-c C-u" . ess-eval-paragraph)
	  ("C->" . 'then_R_operator)
	  ("C-c o" . 'helm-imenu)
	  ("C-c i" . 'ess-insert-aux-snippet)
	  ("C-c C-k" . 'r-print-at-point)
	  ("C-c f" . 'r-filter-dt)
	  ("C-c j" . 'r-add-symbol-to-fstd)
	  ("C-c k" . 'r-clear-fstd)        
	  ( "C-c h" . 'r-list-fstd)
	  ("C-c C-i" . 'ess-interrupt)
	  ("C-c M" . 'ess-match-call)
	  :map ess-roxy-mode-map
	  ("C-a" . 'back-to-indentation)
	  :map inferior-ess-mode-map
	  ("C->" . 'then_R_operator)
	  ("C-<" . 'ess-insert-assign)
	  )
	  
  :hook
  (ess-mode . outshine-mode)
  
  
  )



(setq ess-indent-offset 2)


;; (use-package ess)


(setq inferior-STA-start-args "")
(setq inferior-STA-program "/usr/local/stata14/stata")

(defun then_R_operator ()
  "R - %>% operator or 'then' pipe operator"
  (interactive)
  (just-one-space 1)
  (insert "%>% ")
  ;; (reindent-then-newline-and-indent)
  )


(require 'ess-stata-mode)


(define-key ess-doc-map (kbd "s") 'ess-print-docstring)

;; overwrite "C-c C-k" in source code blocks (previously org-edit-src-abort)
(define-key org-src-mode-map (kbd "C-c C-k") 'r-print-at-point)


;; don't use M-F to finish debugging
(use-package ess-tracebug
  :after (ess)

  :config
  (unbind-key (kbd "M-F") ess-debug-minor-mode-map))


(defun my-inferior-ess-init ()
    (setq-local ansi-color-for-comint-mode 'filter))
    ;; (smartparens-mode 1))
(add-hook 'inferior-ess-mode-hook 'my-inferior-ess-init)

;; *** different terminal for ESS (i think)

(use-package xterm-color
  :load-path "/home/johannes/xterm-color/"

  :init
  (setq comint-output-filter-functions
        (remove 'ansi-color-process-output comint-output-filter-functions))

  (add-hook 'inferior-ess-mode-hook
            (lambda () (add-hook 'comint-preoutput-filter-functions #'xterm-color-filter nil t)))

  :config
  (setq xterm-color-use-bold t))

(setq scroll-conservatively 99)




;; ** eir

(use-package eval-in-repl
    :config
    (setq eir-jump-after-eval nil)
    )


(setq eir-always-split-script-window nil)
(setq eir-delete-other-windows nil)

(require 'eval-in-repl-ielm)
;; for .el files
(define-key emacs-lisp-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)
(define-key emacs-lisp-mode-map (kbd "C-c o") 'helm-imenu)
  ;; for *scratch*
(define-key lisp-interaction-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)


;; ** ansi: idk if needed
;; (setq ansi-color-names-vector
;;       ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "white" "#56b4e9"])
(setq ansi-color-names-vector
      ;; ["black" "black" "black" "black" "black" "black" "black" "black"])

      ["black" "red3" "sienna" "ForestGreen" "blue3" "magenta3" "Magenta4" "gray90"]
      )

(setq ansi-color-map (ansi-color-make-color-map))

;; ** outshine


;; (defvar outline-minor-mode-prefix "\M-#")
;; (defvar outline-minor-mode-prefix "\M-#" "prefix")
;; (setq outline-minor-mode-prefix "\M-#")



(use-package outshine
    :ensure t
    :init
    ;; (defvar outline-minor-mode-prefix "\M-#") ;; has to be set BEFORE loading outshine, hence using init
    :config
    (define-key outshine-mode-map (kbd "M-# M-RET") 'outshine-insert-heading)

    ;; :hook
    ;; (emacs-lisp-mode . outshine-mode)
    ;; (elpy-mode . outshine-mode)
    )

;; ** org-tempo

(require 'org-tempo)


(tempo-define-template "star-equation"
  '("\\begin{equation*}\n" p "\n\\end{equation*}" >)
  "<e"
  "Insert a property tempate")

(tempo-define-template "my-property"
  '(":PROPERTIES:\n" p "\n:END:" >)
  "<p"
  "Insert a property tempate")

(tempo-define-template "clock-report"
  '("#+BEGIN: clocktable :scope agenda :maxlevel 5 :tstart \"<-12h>\" :fileskip0 t :match \"-nowork-tec\"" p "\n#+END" >)
  "<ct"
  "Insert a daily clocktable report")

(tempo-define-template "src-block-data"
  '("#+begin_src R :exports none :results none\n" p "\n#+end_src")
  "<sd"
  "Insert a source block for a data generation (returns nothing)")

(tempo-define-template "src-block-plot"
  '((concat "#+name: p_xx\n" "#+begin_src R :exports results :results output "
      "graphics file :file p_xx.pdf :width 6 :height 5.5\n")
     p
     "\n#+end_src")
  "<sp"
  "Insert a source block for a plot generation (returns plot)")

(tempo-define-template "src-block-table"
  '("#+begin_src R :exports results :results output\n" p "\n#+end_src")
  "<st"
  "Insert a source block for a table generation (returns table, R-formatted)")

(tempo-define-template "src-block-apl"
  '("#+begin_src jupyter-apl :session apl\n" p "\n#+end_src")
  "<sl"
  "insert block for apl")

;; (tempo-define-template "inline-latex-brackets"
;;   '("\\( " p " \\)")
;;   "<lll"
;;   "insert in-line latex brackets")




;; ** flyspell
;; (use-package flyspell
;;     :hook
;;     (flyspell-mode . text-mode-hook)
;;     (flyspell-prog-mode . prog-mode-hook)
    
;;     )
;; (add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; ** org-brain


;; ** ledger

(use-package ledger-mode
  :defer t
  :config
  (setq ledger-report-resize-window nil)

  (setq ledger-reports
    '(("bal" "%(binary) -f %(ledger-file) bal")
       ("bal2" "%(binary) -f %(ledger-file) --price-db /home/johannes/Dropbox/sync/dabate/prices.db -V bal")
       ("reg" "%(binary) -f %(ledger-file) reg")
       ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
       ("account" "%(binary) -f %(ledger-file) reg %(account)")))

  :bind
  (( "C-M-;" . 'iedit-mode))
  )


;; ** qrencode
(use-package qrencode)


;; ** midnight mode

;; https://www.youtube.com/watch?v=YS66xerSWeA

;; clean inactive buffer, just use default config for now
(use-package midnight
  :ensure nil
  :hook (after-init . midnight-mode)
  :custom
  (clean-buffer-list-delay-general 5) ;; default is 3
  (clean-buffer-list-delay-special 3600) ;; default is 3600
  ;; (clean-buffer-list-kill-regexps '("\\`\\*Man " "\\`\\*helpful"))
  )


;; ** yasnippet

;; (use-package yasnippet)
  ;; :config
  ;; (setq yas-snippet


;; (use-package yasnippet-snippets)


;; ** tempel

;; Configure Tempel
(use-package tempel
  ;; Require trigger prefix before template name when completing.
  :custom
  (tempel-trigger-prefix "<")

  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
         ("M-*" . tempel-insert))

  :init

  ;; Setup completion at point
  (defun tempel-setup-capf ()
    ;; Add the Tempel Capf to `completion-at-point-functions'.
    ;; `tempel-expand' only triggers on exact matches. Alternatively use
    ;; `tempel-complete' if you want to see all matches, but then you
    ;; should also configure `tempel-trigger-prefix', such that Tempel
    ;; does not trigger too often when you don't expect it. NOTE: We add
    ;; `tempel-expand' *before* the main programming mode Capf, such
    ;; that it will be tried first.
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))

  (add-hook 'conf-mode-hook 'tempel-setup-capf)
  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf)
  (add-hook 'org-mode-hook 'tempel-setup-capf)

  ;; Optionally make the Tempel templates available to Abbrev,
  ;; either locally or globally. `expand-abbrev' is bound to C-x '.
  ;; (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
  ;; (global-tempel-abbrev-mode)
)

;; Optional: Add tempel-collection.
;; The package is young and doesn't have comprehensive coverage.
(use-package tempel-collection)

;; ;; Optional: Use the Corfu completion UI
;; (use-package corfu
;;   :init
;;   (global-corfu-mode))

