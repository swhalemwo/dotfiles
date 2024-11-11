

;; ** sql
(use-package sql-clickhouse

    :config
    (sql-del-product 'clickhouse)
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

(use-package elpy
  ;; :defer t
  :init
  (elpy-enable) ;; maybe can be run as init? 
  
  :config
  (setq python-shell-interpreter "python3")
  (setq elpy-rpc-python-command "python3")
  (add-hook 'elpy-mode-hook 'outshine-mode)
  (add-hook 'elpy-mode-hook (lambda ()(setq outline-heading-end-regexp "\n")))


  :bind (
	  ;; ("C-c C-j" . 'elpy-shell-send-statement)
	  ;; ("<C-return>" . 'elpy-shell-send-group) 
	  ;; ("C-c C-o" . 'elpy-goto-definition)     
	  ;; ("C-c C-j" . 'elpy-shell-send-statement)
	  ;; ("C-c C-k" . 'elpy-summary-at-point)
	  ("C-a" . 'back-to-indentation)

	  )
  ;; :hook outshine-mode
  )




(define-key elpy-mode-map (kbd "<C-return>") 'elpy-shell-send-group)
(define-key elpy-mode-map (kbd "C-c C-o") 'elpy-goto-definition)
;; (define-key elpy-mode-map (kbd "C-c C-j") 'elpy-shell-send-statement)
(define-key elpy-mode-map (kbd "C-c C-j") 'elpy-send-line)
(define-key elpy-mode-map (kbd "C-c o") 'helm-imenu)
(define-key elpy-mode-map (kbd "C-c C-k") 'elpy-summary-at-point)
(define-key elpy-mode-map (kbd "C-M-'") 'elpy-pretty-summary-at-point)
(define-key elpy-mode-map (kbd "C-c n") 'elpy-len-at-point)
(define-key elpy-mode-map (kbd "C-c i") 'elpy-names-at-point)

(define-key elpy-mode-map (kbd "C-c g") 'jpdb-send-group)
;; (define-key elpy-mode-map (kbd "C-c j") 'jpdb-send-line)
;; (define-key elpy-mode-map (kbd "C-c k") 'jpdb-summary-at-point)
(define-key elpy-mode-map (kbd "C-c r") 'jpdb-send-selection)
(define-key inferior-python-mode-map (kbd "M-r") 'consult-history)



(use-package explain-pause-mode
  :straight (explain-pause-mode :type git :host github :repo "lastquestion/explain-pause-mode")
  :config
  (explain-pause-mode))





;; ** graphviz
(use-package graphviz-dot-mode
    :config
    (setq graphviz-dot-indent-width 2)
    (setq graphviz-dot-preview-extension "pdf")
    (setq graphviz-dot-view-command "dot %s")
    )

;; ** ess
(use-package ess
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

  :bind (("C-<" . 'ess-insert-assign)
	  ("C-c C-u" . ess-eval-paragraph)
	  ("C->" . 'then_R_operator)
	  )
  :hook (ess-mode . outshine-mode)
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

(defun R_assign_pipe ()
  "R - %<>% operator"
  (interactive)
  (just-one-space 1)
  (insert "%<>% ")
  ;; (reindent-then-newline-and-indent)
  )



(require 'ess-r-mode)
(require 'ess-stata-mode)

(define-key ess-mode-map (kbd "C->") 'then_R_operator)
(define-key inferior-ess-mode-map (kbd "C->") 'then_R_operator)
(define-key ess-mode-map (kbd "C-&") 'R_assign_pipe)
(define-key inferior-ess-mode-map (kbd "C-&") 'R_assign_pipe)

(define-key ess-mode-map (kbd "C-c o") 'helm-imenu)
;; (define-key ess-r-mode-map (kbd "C-c i") 'ess-insert-debug-snippet)
;; (define-key ess-r-mode-map (kbd "C-c I") 'ess-insert-debug-numbers)
(define-key ess-r-mode-map (kbd "C-c i") 'ess-insert-aux-snippet)

(define-key ess-roxy-mode-map (kbd "C-a") 'back-to-indentation)
;; (define-key visual-line-mode-map (kbd "C-a") 'back-to-indentation)

(define-key ess-r-mode-map (kbd "C-c C-k") 'r-print-at-point)
(define-key ess-r-mode-map (kbd "C-c C-u") 'ess-eval-paragraph)
(define-key ess-r-mode-map (kbd "C-x C-e") 'ess-eval-paragraph)
(define-key ess-r-mode-map (kbd "C-c j") 'r-add-symbol-to-fstd)
(define-key ess-r-mode-map (kbd "C-c k") 'r-clear-fstd)
(define-key ess-r-mode-map (kbd "C-c h") 'r-list-fstd)
(define-key ess-doc-map (kbd "s") 'ess-print-docstring)

;; overwrite "C-c C-k" in source code blocks (previously org-edit-src-abort)
(define-key org-src-mode-map (kbd "C-c C-k") 'r-print-at-point)

(define-key ess-r-mode-map (kbd "C-c C-i") 'ess-interrupt)
(define-key ess-r-mode-map (kbd "C-c M") 'ess-match-call)


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
  "<c"
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
  '("#+begin_src R :exports :exports results :results output\n" p "\n#+end_src")
  "<st"
  "Insert a source block for a table generation (returns table, R-formatted)")




;; ** flyspell
;; (use-package flyspell
;;     :hook
;;     (flyspell-mode . text-mode-hook)
;;     (flyspell-prog-mode . prog-mode-hook)
    
;;     )
;; (add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; ** org-brain
(use-package org-brain

    ;; :bind (("H" . 'helm-brain))
    :config
    (define-key org-brain-visualize-mode-map "I" 'org-brain-index-tags)
    (define-key org-brain-visualize-mode-map "B" 'org-brain--toggle-visualize-peers)
    )

(setq org-brain-visualize-peers nil)

(defun org-brain--toggle-visualize-peers ()
    (interactive)
    """peers: children of same parents"""
    (if org-brain-visualize-peers
	    (setq org-brain-visualize-peers nil)
	(setq org-brain-visualize-peers t))
    (org-brain--revert-if-visualizing)
    )

(defun org-brain-mind-map (entry parent-max-level children-max-level)
  "Insert a tree of buttons for the parents and children of ENTRY.
Insert friends to ENTRY in a row above the tree.
Will also insert grand-parents up to PARENT-MAX-LEVEL, and
children up to CHILDREN-MAX-LEVEL.
Return the position of ENTRY in the buffer."
  (insert "FRIENDS:")
  (dolist (friend (sort (org-brain-friends entry) org-brain-visualize-sort-function))
    (insert "  ")
    (org-brain-insert-visualize-button friend 'org-brain-friend 'friend))
  (setq-local org-brain--visualize-header-end-pos (point))
  (insert "\n\n")
  (let ((indent (1- (org-brain-tree-depth (org-brain-recursive-parents entry parent-max-level))))
        (entry-pos))
      ;; (measure-time "org-brain-mind-map entry-stuff"
    (dolist (parent (sort (org-brain-siblings entry) (lambda (x y)
                                                       (funcall org-brain-visualize-sort-function
                                                                (car x) (car y)))))
	(org-brain-insert-recursive-parent-buttons (car parent) (1- parent-max-level) (1- indent))
	(if org-brain-visualize-peers
      (let* ((parent-tags (org-brain-get-tags (car parent)))
             (children-links (unless (member org-brain-exclude-siblings-tag parent-tags)
                               (cdr parent))))
        (dolist (sibling (sort children-links org-brain-visualize-sort-function))
          (insert (org-brain-map-create-indentation indent))
          (org-brain-insert-visualize-button sibling 'org-brain-sibling 'sibling)
          (insert "\n")))
      )      )
    ;; )
    (insert (org-brain-map-create-indentation indent))
    (setq entry-pos (point))
    (insert (propertize (org-brain-title entry)
                        'face 'org-brain-title
              'aa2u-text t)
      "\n")
    (dolist (child (sort (org-brain-children entry) org-brain-visualize-sort-function))
      (org-brain-insert-recursive-child-buttons child (1- children-max-level) (1+ indent)))
    entry-pos))



(defun org-brain-choose-entries (prompt entries &optional predicate require-match initial-input hist def inherit-input-method)
  "PROMPT for one or more ENTRIES, separated by `org-brain-entry-separator'.
ENTRIES can be a list, or 'all which lists all headline and file entries.
Return the prompted entries in a list.
Very similar to `org-brain-choose-entry', but can return several entries.

For PREDICATE, REQUIRE-MATCH, INITIAL-INPUT, HIST, DEF and
INHERIT-INPUT-METHOD see `completing-read'."
  (let* (
	  (targets (if (eq entries 'all)
                     (org-brain--all-targets)
		     ;; (-uniq org-brain-keywords-cache-keys) ;; use cache to get candidates faster
                    (mapcar (lambda (x)
                              (cons (org-brain-entry-name x)
                                    (if (org-brain-filep x)
                                        x
                                      (nth 2 x))))
                      entries)))

	  
         (choices (org-brain-completing-read prompt targets
                                             predicate require-match initial-input hist def inherit-input-method)))
    (mapcar (lambda (title) (org-brain-get-entry-from-title title targets))
            (if org-brain-entry-separator
                (split-string choices org-brain-entry-separator)
              (list choices)))))	


(defun org-brain-select (entry)
  "Toggle selection of ENTRY.
If run interactively, get ENTRY from context."
  
  (interactive (list (org-brain-entry-at-pt)))

  (measure-time "selecting"

  (when (null entry) (error "Cannot select null entry"))
  (if (member entry org-brain-selected)
	  (progn
          (setq org-brain-selected (delete entry org-brain-selected))
	  (message "Entry unselected.")
	  )
      (progn
          (push entry org-brain-selected)
	  (message "Entry selected."))
   
      )
  )
  (measure-time "saving"
		(org-brain-save-data))
		
  (measure-time "visualizing"
		(org-brain--revert-if-visualizing)
		)
  )

(defun helm-brain--select (_c)
    (dolist (candidate (helm-marked-candidates))
	(org-brain-select (or (org-brain-entry-from-id candidate) candidate))))


(defun org-brain-build-keyword-cache (entry)
    (message "lol")
    (push `(entry . ,(org-brain-keywords entry)) org-brain-keywords-cache)
    ;; (send-org-brain-keywords-to-python entry)
    )

(load-file "/home/johannes/Dropbox/personal_stuff/obr-viz/database_backend/constant_update.el")

;; (setf (alist-get "Hsu_2015_granted" org-brain-keywords-cache) (org-brain-keywords-get "Hsu_2015_granted"))



(defun alist-keys (alist)
  ;; gets the first entry of alist, which I guess is a list of lists
    (mapcar 'car alist))





(defun org-brain-keywords-update-entry (entry)
    "update the keyword cache for entry"
    (setf (alist-get entry org-brain-keywords-cache) (org-brain-keywords-get entry)))


(defun org-brain-keywords-cache-update ()
    "function to add to after-save-hook to update cache"
    (when (equal default-directory org-brain-path)
	
	(let* ((buf-name (buffer-name))
	       (org-brain-name (substring buf-name 0 (- (length buf-name) 4))))
	    
	    (org-brain-keywords-update-entry org-brain-name)
	    ;; (send-org-brain-keywords-to-python org-brain-name)
	    )))
	


(defun org-brain-keywords-get (entry)
    "Get alist of `org-mode' keywords and their values in file ENTRY."
  (if (org-brain-filep entry)
      (with-temp-buffer
        (insert
         (with-temp-buffer
           (ignore-errors (insert-file-contents (org-brain-entry-path entry)))
           (buffer-substring-no-properties (point-min) (org-brain-first-headline-position))))
        (org-element-map (org-element-parse-buffer) 'keyword
          (lambda (kw)
            (cons (org-element-property :key kw)
                  (org-element-property :value kw)))))
    (error "Only file entries have keywords")))

(defun org-brain-keywords (entry)
    ;; (message "entry: %s" entry)
    "get keywords: use cache is available, else look up in file"
    (if (member entry org-brain-keywords-cache-keys)
	    (assoc-default entry org-brain-keywords-cache)

	(let ((kwds (org-brain-keywords-get entry)))

	    (push `(,entry . ,kwds) org-brain-keywords-cache)
	    (push entry org-brain-keywords-cache-keys)
	    (message "entry: %s" entry)
	    ;; (send-org-brain-keywords-to-python entry)
	    kwds)
      ))




(defun org-brain-index-tags ()
    """add all parents to tags: saves a lot of manual work"""
    (interactive)
    (let ((entry-tags-all (org-brain-parents (org-brain-entry-at-pt)))
	  (to-avoid (list "cls_tags" "cls_media" "cls_toread" "sbcls_A" "sbcls_B" "sbcls_C" "sbcls_D" "sbcls_E" "cls_techreports" "cls_reviews" "cls_org_pop" "cls_org_idt"))
	  )
	(dolist (i entry-tags-all)
	    
	    (when (not (member i to-avoid))
		(progn
		    (when (not (member "cls_tags" (org-brain-parents i)))
			(message "%s: add me" i)
			(org-brain-add-child "cls_tags" (list i))
			)
		    )
		))))





;; saving org-brain cache 
;; get generic functions from https://stackoverflow.com/questions/2321904/elisp-how-to-save-data-in-a-file

(defun print-to-file (filename data)
  (with-temp-file filename
    (prin1 data (current-buffer))))

(defun read-from-file (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (cl-assert (eq (point) (point-min)))
    (read (current-buffer))))




;; (print-to-file org-brain-cache-file org-brain-keywords-cache) ;; should not be uncommented, only run once
;; (setq org-brain-keywords-cache org-brain-keywords-cache2)



(defun org-brain-save-cache ()
    (interactive)
    (print-to-file org-brain-cache-file org-brain-keywords-cache)
    )

;; add hook for regularly saving org-brain-keywords-cache



(add-hook 'after-save-hook 'org-brain-keywords-cache-update)
;; (remove-hook 'after-save-hook 'org-brain-keywords-cache-update)

;; (setq savehist-additional-variables '(org-brain-keywords-cache))

;; (when (not (> (length (emacs-uptime)) 10))
(setq org-brain-keywords-cache ())
(setq org-brain-keywords-cache-keys ())
    ;; )



(setq org-brain-cache-file "/home/johannes/Dropbox/technical_stuff_general/org-brain/org-brain-cache.el")


(setq org-brain-keywords-cache (read-from-file org-brain-cache-file))
;; (setq org-brain-keywords-cache nil)
(setq org-brain-keywords-cache-keys (alist-keys org-brain-keywords-cache))

;; (setq org-brain-keywords-cache-keys (alist-keys org-brain-keywords-cache))


(add-hook 'kill-emacs-hook 'org-brain-save-cache)
;; (run-with-timer 0 7200 'org-brain-save-cache)




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
       ("account" "%(binary) -f %(ledger-file) reg %(account)"))))


;; ** qrencode
(use-package qrencode)
