(defun mrb/insert-created-timestamp()
  "Insert a CREATED property using org-expiry.el for TODO entries"
  (org-expiry-insert-created)
  (org-back-to-heading)
  (org-end-of-line)
  (insert " ")
  )
(defadvice org-insert-todo-heading (after mrb/created-timestamp-advice activate)
  "Insert a CREATED property using org-expiry.el for TODO entries"
  (mrb/insert-created-timestamp)
  )
;; Make it active
(ad-activate 'org-insert-todo-heading)

(defun open-ut ()
  (interactive)
  (call-process "urxvt" nil 0 nil "-cd" default-directory))


(defun cfw-open ()
  (interactive)
  (if (get-buffer "*cfw-calendar*")
    (switch-to-buffer "*cfw-calendar*")
    (cfw:open-org-calendar)))
  ;; (cfw:refresh-calendar-buffer nil)




(defun open-pdf-of-notes-or-buffer ()
  "open pdf of an org-file, if the org-file is in /nootes (i.e. is notes of a paper), open the corresponding reader, else (if the org-file is a paper I write) open the exported pdf of the file"
  (interactive)
  (let* ((buf-name (file-name-nondirectory (buffer-file-name)))
	  (pdf-name (concat (substring buf-name 0 (- (length buf-name) 4)) ".pdf"))
	  ;; if pdf-file exists in current directory, open that, else open file in readings
	  (file-dir (if (file-exists-p (concat (file-name-directory (buffer-file-name)) pdf-name))
		      (file-name-directory (buffer-file-name))
		      "/home/johannes/Dropbox/readings/"))
	  (cmd (concat "zathura " file-dir pdf-name " &")))
    (call-process-shell-command cmd)))

(defun open-org-brain-of-notes ()
  ;; open the correspondign org-brain buffer from a nootes file
  (interactive)
  (let* ((buf-name (buffer-name))
	  (org-brain-name (substring buf-name 0 (- (length buf-name) 4)))
	  ;; (cmd (concat "zathura /home/johannes/Dropbox/readings/" pdf-name " &"))
	  )
    ;; (call-process-shell-command cmd)
    (org-brain-visualize org-brain-name)

    ))


(defun insert-hat ()
  (interactive)
  (insert-char #x0302))

(defun insert-bar ()
  (interactive)
  (insert-char #x0305))




;; *** time macro for debugging
(defmacro measure-time (xname &rest body)
  "Measure the time it takes to evaluate BODY."
  `(let (
	  (xnamea ,xname)
	  (time (current-time)))
     ,@body
     (message "%s: %.06f" xnamea (float-time (time-since time)))))


;; ** all kinds of R-utils

(defun r-print-at-point ()
  ;; eval expression at point
  ;; if called with argument, pipe a print query with n=argument
  ;; (used to print more rows of data frames than default (10))
  
  (interactive)
  (let ((sym (ess-symbol-at-point))
	 (addgn (if current-prefix-arg
		  (concat " %>% print(n = " (number-to-string (prefix-numeric-value current-prefix-arg)) ")")
		  "")))
    (if sym
      (ess-send-string
	(get-process ess-current-process-name)
	;; (get-buffer-process "*R:2:org_pop*")

	;; (get-buffer-process "*R*")
	;; (get-buffer-process "*R:agenda*")

	;; i don't get how process names are chosen, this maybe an issue if R process is called differently if run elsewhere
        (concat (symbol-name sym) addgn "\n") t)
      ;; (concat sym "\n") t)
      (message "No valid R symbol at point"))))

(defun ess-print-docstring ()
  ;; show docstring (defined with docstring package) of function at point
  ;; docstring useful for functions that are being developed
  
  (interactive)
  (let ((sym (ess-symbol-at-point)))
    (if sym
      (ess-send-string
	(get-process ess-current-process-name)
	(concat "docstring(" (symbol-name sym) ")") t)
      (message "no valid R symbols at point"))))



(defun r-names-at-point ()
  ;; print names of object at point
  (interactive)
  (let ((sym (ess-symbol-at-point)))

    (if sym
      (ess-send-string
	(get-process ess-current-process-name)
	(concat "names(" (symbol-name sym) ")\n") t)
      (message "no valid r symbol at point"))))

(defun r-last-trace ()
  ;; print names of object at point
  (interactive)
  (let ((trace-cmd "rlang::last_trace()"))
    (ess-send-string
      (get-process ess-current-process-name)
      trace-cmd
      t)
    ))



(defun r-add-symbol-to-fstd ()
  ;; add current symbol to fstd (functions to debug)
  
  (interactive)
  (let* ((sym (ess-symbol-at-point))
	  (addgn (concat "fstd <- c(fstd,\"" (symbol-name sym) "\")"))
	  )

    (if sym
      (ess-send-string
	(get-process ess-current-process-name)
	addgn t)
      (message "No valid R symbol at point"))))

(defun r-clear-fstd ()
  ;; clear fstd 
  (interactive)
  (let ((clear-command "fstd = ''"))
    (ess-send-string
      (get-process ess-current-process-name)
      clear-command
      t)))


(defun r-list-fstd ()
  (interactive)
  (ess-send-string (get-process ess-current-process-name) "fstd" t))


(defun ess-insert-aux-snippet ()
  (interactive)

  (let* ((snippet (completing-read "snippet to insert"
		    (list
		      "if (as.character(match.call()[[1]]) %in% fstd){browser()}"
		      "1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;"
		      "gw_fargs(match.call())"
		      "attr(, \"gnrtdby\") <- as.character(match.call()[[1]])"
		      ))))
    
    (insert snippet)))



(defun ess-match-call ()
  (interactive)
  (ess-send-string
    (get-process ess-current-process-name)
    "match.call()" t))


(defun r-str-at-point ()
  ;; run str of object at point
  (interactive)
  
    (let ((sym (ess-symbol-at-point)))

    (if sym
      (ess-send-string
	(get-process ess-current-process-name)
	(concat "str(" (symbol-name sym) ")\n") t)
      (message "no valid r symbol at point"))))


(defun r-summary-at-point ()
  ;; print summary at pointn
  (interactive)
  (let ((sym (ess-symbol-at-point)))

    (if sym
      (ess-send-string
	(get-process ess-current-process-name)
	(concat "summary(" (symbol-name sym) ")\n") t)
      (message "no valid r symbol at point"))))






;; ** elpy utils



(defun elpy-summary-at-point ()
  (interactive)
  (let ((sym (symbol-at-point)))
    ;; (message "%s" sym)
    (if sym
      (python-shell-send-string

	(concat (symbol-name sym) "\n") )
      )))


;; ** all kinds of latex org export stuff 


(defun delete-org-comments (backend)
  ;; (cl-loop for comment in (reverse (org-element-map (org-element-parse-buffer)
  ;; 				     'comment 'identity))
  ;;   do
  ;;   (setf (buffer-substring (org-element-property :begin comment)
  ;; 	    (org-element-property :end comment))
  ;;     ""))


  (cl-loop for comment in (reverse (org-element-map (org-element-parse-buffer)
                                 'comment 'identity))
  do
  (let ((begin (org-element-property :begin comment))
        (end (org-element-property :end comment)))
    (delete-region begin end)))

  )


(defun ensure-word-compatibility (backend)
  ;; replace every mention of wcptblF (NOT word-compatible) with wcptblT (word-compatible)"
  ;; not-word-compatible tables look better in pdf, but don't work properly in word
  (while (re-search-forward "wcpF" nil t)
    (replace-match "wcpT"))

  )


(defun ensure-pngs (backend)

  (while (re-search-forward "\.pdf" nil t)
    (replace-match "\.png"))
  
  )


(defun org-babel-execute-region (beg end &optional arg)
  ;; execute babel in region 
  ;; https://emacs.stackexchange.com/questions/70274/execute-all-org-mode-code-blocks-in-a-region
  (let ((cur-point (point)))
    (interactive "r")
    (org-babel-remove-result-one-or-many t)
    (narrow-to-region beg end)
    (org-babel-execute-buffer arg)
    (widen)
    (goto-char cur-point)
    )
  )

(defun include-nbrs (backend) 
  ;; run the source code block (which is located at beginning of file)
  ;; which generates the macros that have the numbers
  (org-babel-execute-region 1 700)
  )

(defun org-export-comments-removed ()
  (interactive)
  (org-babel-tangle)

  (let ((org-export-before-processing-hook '(delete-org-comments)))

    ;; add to pre-processing hook the function that generates the number-macros
    ;; has to be run in pre-processing hook because by default source codes are be run only after macro-expansion
    (add-hook 'org-export-before-processing-hook 'include-nbrs)
    ;; (org-update-nbrs)

    ;; if called with C-u: replace all wcptblF.tex with wcptblT.tex
    ;; also only export to latex (not render to pdf)
    ;; also convert to html with pandoc, and then to docx again
    (if current-prefix-arg
      ;; (progn
      ;; 	(add-hook 'org-export-before-processing-hook 'ensure-word-compatibility)
      ;; 	(add-hook 'org-export-before-parsing-functions 'ensure-pngs)
      ;; 	(org-latex-export-to-latex)
      ;; 	(shell-command (concat "pandoc -F pandoc-crossref -C --bibliography=/home/johannes/Dropbox/references.bib "
      ;; 			 "--bibliography=/home/johannes/Dropbox/references2.bib -o "
      ;; 			 (replace-regexp-in-string "\.org$" "\.html" (buffer-file-name)) " "
      ;; 			 (replace-regexp-in-string "\.org$" "\.tex" (buffer-file-name))))
      ;; 	)

      (progn 

	(let ((html-file (replace-regexp-in-string "\.org$" "\.html" (buffer-file-name)))
	       (tex-file (replace-regexp-in-string "\.org$" "\.tex" (buffer-file-name)))
	       (docx-file (replace-regexp-in-string "\.org$" "\.docx" (buffer-file-name)))
	       (cmd-pandoc-html "")
	       )
	  (add-hook 'org-export-before-processing-hook 'ensure-word-compatibility)
	  (add-hook 'org-export-before-parsing-functions 'ensure-pngs)
	  (org-latex-export-to-latex)
	  (setq cmd-pandoc-html (concat "pandoc -F pandoc-crossref -C "
				  (mapconcat (lambda (x) (concat "--bibliography=" x)) helm-bibtex-bibliography " ")
				  " -o " html-file " " tex-file))
	  (message cmd-pandoc-html)
	  (shell-command cmd-pandoc-html)

	  (shell-command (concat "pandoc -o " docx-file " " html-file))
	  ))


      (org-latex-export-to-pdf t) ;; now exports async

      )
    )
  )




(defun latexify-org-comments (backend)
  ;; (cl-loop for comment in (reverse (org-element-map (org-element-parse-buffer)
  ;; 				     'comment 'identity))
  ;;   do
  ;;   (setq commentx comment)
  ;;   (setf (buffer-substring (org-element-property :begin comment)
  ;; 	    (org-element-property :end comment))
  ;;     (concat "#+latex: \\todo{"
  ;; 	(replace-regexp-in-string "\n" "\\\\\\\\ \n" (org-element-property :value comment))
  ;; 	"\n#+latex: }" "\n")
  ;;     )
  ;;   )

  ;; replace org comments with latex comment
  ;; this is written by chatgpt (to replace buffer-substring which has been obsoleted); it will probably not work
  ;; but org-export-comments-latexified is broken anyways and not really used,
  ;; so if I come here later I need to fix org-export-comments-latexified anyways

  (cl-loop for comment in (reverse (org-element-map (org-element-parse-buffer) 'comment 'identity))
    do
    (let* ((begin (org-element-property :begin comment))
            (end (org-element-property :end comment))
            (value (concat "#+latex: \\todo{" (replace-regexp-in-string "\n" "\\\\\\\\ \n"
						(org-element-property :value comment)) "\n#+latex: }" "\n")))
      (delete-region begin end)
      (goto-char begin)
      (insert value)))

  )

(defun org-export-comments-latexified ()
  (interactive)
  (org-babel-tangle)

  (let ((org-export-before-processing-hook '(latexify-org-comments)))
    ;; (switch-to-buffer (org-latex-export-to-pdf))
    (org-latex-export-to-pdf)
    ;; (org-latex-export-to-pdf t)
    ))

;; ** outshine something

(defun outshine-set-local-outline-regexp-and-level
  (start-regexp &optional level-fn end-regexp)
  "Set `outline-regexp' locally to START-REGEXP.
Optionally set `outline-level' to LEVEL-FN and
`outline-heading-end-regexp' to END-REGEXP."
  (setq-local outline-regexp start-regexp)
  (when level-fn
    (setq-local outline-level level-fn))
  (when end-regexp
    ;; (setq-local outline-heading-end-regexp end-regexp)
    (setq-local outline-heading-end-regexp "\n")

    ))

;; ** bibliography management 


(defun org-ref-open-notes-at-point-bandaid ()
  (interactive)
  (bibtex-completion-edit-notes-default (list (org-ref-get-bibtex-key-under-cursor)))
  )




(defun isbn-to-bibtex2 ()
  (interactive)
  (let ((bibkey (read-string "bibtex key: ")))
    (isbn-to-bibtex bibkey "references2.bib")))


;; ** qr code creator

(defun kisaragi/qr-encode (str &optional buf)
  "Encode STR as a QR code.

Return a new buffer or BUF with the code in it."
  (interactive "MString to encode: ")
  (let ((buffer (get-buffer-create (or buf "*QR Code*")))
         (format (if (display-graphic-p) "PNG" "UTF8"))
         (inhibit-read-only t))
    (with-current-buffer buffer
      (delete-region (point-min) (point-max)))
    (make-process
      :name "qrencode" :buffer buffer
      :command `("qrencode" ,str "-t" ,format "-o" "-")
      :coding 'no-conversion
      ;; seems only the filter function is able to move point to top
      :filter (lambda (process string)
		(with-current-buffer (process-buffer process)
                  (insert string)
                  (goto-char (point-min))
                  (set-marker (process-mark process) (point))))
      :sentinel (lambda (process change)
                  (when (string= change "finished\n")
                    (with-current-buffer (process-buffer process)
                      (cond ((string= format "PNG")
                              (image-mode)
                              (image-transform-fit-to-height))
                        (t ;(string= format "UTF8")
                          (text-mode)
                          (decode-coding-region (point-min) (point-max) 'utf-8)))))))
    (when (called-interactively-p 'interactive)
      (display-buffer buffer))
    buffer))

;; ** minor tweaks

(defun load-current-file ()
  (interactive)
  (load-file buffer-file-name))

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; ** beamer

;; https://tex.stackexchange.com/questions/637386/org-mode-export-bold-text-to-beamer
(setq org-export-allow-bind-keywords t)

(defun org-beamer-bold-as-textbf (s backend info)
  (replace-regexp-in-string "\\\\alert" "\\\\textbf" s))

(defun org-beamer-strikethrough-as-alert (s backend info)
  (replace-regexp-in-string "\\\\uline" "\\\\alert" s))


;; ** latex
;; *** export
;; dynamic numberic of section when exporting to latex:
;; https://bastibe.de/2014-12-03-org-numbering.html
(defun headline-numbering-filter (data backend info)
  "No numbering in headlines that have a property :numbers: no"
  (let* ((beg (next-property-change 0 data))
          (headline (if beg (get-text-property beg :parent data))))
    (if (and (eq backend 'latex)
          (string= (org-element-property :NUMBERS headline) "no"))
      (replace-regexp-in-string
	"\\(\\\\part\\|\\\\chapter\\|\\\\section\\|\\\\subsection\\|\\\\subsubsection\\|\\\\paragraph\\)"
        "\\1*" data nil nil 1)
      data)))    





(defun sa-ignore-headline (contents backend info)     ;; nicer org to latex conversion
  "Ignore headlines with tag `ignoreheading'."
  (when (and (org-export-derived-backend-p backend 'latex 'html 'ascii)
	  (string-match "\\`.*ignhead.*\n"
	    (downcase contents)))
    (replace-match "\n" nil nil contents)))



(defun jackjackk/org-latex-remove-section-labels (string backend info)
  "Remove section labels generated by org-mode"
  (when (org-export-derived-backend-p backend 'latex)
    (replace-regexp-in-string "\\\\label{sec:.*?}" "" string)))


;; atm all those hooks are added only in async export
;; (add-to-list 'org-export-filter-final-output-functions
;;   'jackjackk/org-latex-remove-section-labels)
;; (add-to-list 'org-export-filter-headline-functions 'headline-numbering-filter)
;; (add-to-list 'org-export-filter-headline-functions 'sa-ignore-headline)



;; *** nbrs integration (org-macros generated by R snippet)

(defun org-insert-macro ()
  ;; give nice menu of macros, give values as hint in annotation 
  (interactive)
  ;; need to filter out macros with values that aren't strings
  (let* ( ;; (macro-templates (-filter (lambda (x) (stringp (cdr x))) org-macro-templates))
	  (macro-templates org-macro-templates)
	  (macro-string (consult--read macro-templates
			  :annotate (lambda (cand)
				      (consult--annotate-align
					cand
					;; (cdr (assoc cand macro-templates))
					;; "asdf"
					(if (stringp (cdr (assoc cand macro-templates)))
					  (cdr (assoc cand macro-templates))
					  "bottom text")
					)))))
    ;; insert in brackets
    (insert (concat "{{{" macro-string "}}}"))
    )
  )

(defun org-update-nbrs ()
  ;; read in new numbers, and restart org mode to update their in-text references
  (interactive)
  (org-babel-execute-region 1 700)
  (org-mode-restart)
  )


;; *** misc 

(defun re-seq (regexp string)
  "Get a list of all regexp matches in a string"
  (save-match-data
    (let ((pos 0)
           matches)
      (while (string-match regexp string pos)
	;; yeet the string properties
        (push (substring-no-properties (match-string 0 string)) matches)
        (setq pos (match-end 0)))
      matches)))



(defun open-pdf-fig ()
  "get the a consult menu with all the pdfs linked (only pdfs so far)"
  "assumes there's a figures folder in current dir"
  (interactive)
  (let* (
	  (figs (re-seq "\[\[file:[a-z/_0-9\.]*.pdf]]" (buffer-string)))
	  ;; remove the beginning/end parts 
	  (figs2 (mapcar (lambda (x) (substring x 7 (- (length x) 2))) figs))
	  (fig (consult--read figs2))
	  (dir (file-name-directory (buffer-file-name)))
	  )
    (org-open-file (concat dir fig))

    ))

;; https://emacs.stackexchange.com/questions/50216/org-mode-code-block-parentheses-mismatch
;; stop using < and > as bracket delimiters
(defun org-syntax-table-modify ()
  "Modify `org-mode-syntax-table' for the current org buffer."
  (modify-syntax-entry ?< "." org-mode-syntax-table)
  (modify-syntax-entry ?> "." org-mode-syntax-table))

(add-hook 'org-mode-hook #'org-syntax-table-modify)

(defun ess-reload-package (process signal)
  "detach package and reattach package"
  (let ((ess--inhibit-presend-hooks t)) ;; somehow needed to run ess-send-string when not focusing on ESS buffer
    
    (when (memq (process-status process) '(exit signal))

      ;; (message "Do something!")
      
      ;; (ess-send-string (get-process ess-current-process-name)
      (ess-send-string (get-process ESS-PROCESS-CURRENTLY-RUNNING-UPRADE)
	(concat "detach(\"package:" PKG-NAME "\", unload = T)\n") t)

      ;; (ess-send-string (get-process ess-current-process-name)
      (ess-send-string (get-process ESS-PROCESS-CURRENTLY-RUNNING-UPRADE)
	(concat "library(" PKG-NAME ")\n") t)


      (shell-command-sentinel process signal)))
  )


(defun ess-r-devtools-update-package ()
  "updates the pmdata package"
  (interactive)
  ;; set PROCESS-CURRENTLY-RUNNING-UPRADE to read it back in in ess-reload-package after compilation
  ;; (can't pass variables to set-process-sentinel)
  (setq ESS-PROCESS-CURRENTLY-RUNNING-UPRADE ess-current-process-name)
  (setq PKG-NAME (completing-read "package to update" '(pmdata jtls)))
  ;; https://emacs.stackexchange.com/questions/42172/run-elisp-when-async-shell-command-is-done
  (let* (
	  (inital-buffer (buffer-name))
	  (output-buffer (generate-new-buffer "async compile output buffer"))
	  (proc (progn
    		  (async-shell-command (concat "cd /home/johannes/Dropbox/phd/" PKG-NAME 
					 "&& Rscript -e \"library(devtools); document(); "
					 "install(upgrade='never')\"")
		    output-buffer)
		  (get-buffer-process output-buffer))))
    
    
    
    (if (process-live-p proc)
      (set-process-sentinel proc #'ess-reload-package)
      (message "No process running."))))



(defun ess-get-popup-cmd (output-buffer)
  "generates popup command: selects object and operation to be performed on it "

  (let (
	 (object-names nil) ;;;; list of object names
	 (obj-to-display "") ;; object (plot/table) to display
	 (obj-operation "") ;; command (w/d/g-plt/tbl) to run on obj-to-display
	 (popup-cmd "") ;; command combining obj-operation obj-to-display
	 )

    ;; read object names back to emacs into list, kill temp buffer
    (set-buffer output-buffer)
    (setq object-names (split-string (substring-no-properties (buffer-string))))
    (kill-buffer output-buffer)

    ;; get object to display 
    (setq obj-to-display (completing-read "object to operate on: " object-names))

    ;; if selecting a table object: get function, add wcpF for some commands
    (when (string-equal (substring obj-to-display 0 2) "t_")
      (progn 
	(setq obj-operation (completing-read "function to use: " '(gtbl dtblF wtbl wtbl_pdf gdtbl)))
	;; for commands that operate on tex/pdf file: add wcpF

	(when (member obj-operation '("wtbl_pdf" "dtblF"))

	  (setq obj-to-display (concat obj-to-display "_wcpF")))))

    ;; if selecting a plot: select the handling function
    (when (string-equal (substring obj-to-display 0 2) "p_")
      (setq obj-operation (completing-read "function to use: " '(gplt dpltF dpltR wplt gdplt gwdplt wdplt))))
    
    ;; concat object and operation together
    (setq popup-cmd (concat obj-operation "(\"" obj-to-display "\")"))

    popup-cmd
    )  
  )



(defun ess-r-process-object ()
  (interactive)
  ;; temp buffer for getting R obj names (from gc_tbls/plts) back into emacs
  (let (
	 (cur-buffer (current-buffer)) ;; save current buffer to switch back to it later on
	 (ess-proc (get-process ess-current-process-name)) ;; ess-process for sending
	 (output-buffer (get-buffer-create (make-temp-name "kappa"))) ;; temporary buffer for writing object names
	 (popup-cmd "") ;; overall command
	 )	 
    

    ;; (message ess-current-process-name)

    ;; get the object names and write them to buffer
    (ess-command "\ncat(names(gc_tbls()), names(gc_plts()), \"\n\")" output-buffer)

    ;; generate popup command (object and operation)
    (setq popup-cmd (ess-get-popup-cmd output-buffer))

    ;; set buffer, needed for ess-send-string somehow
    (set-buffer cur-buffer)
    
    ;; send command to emacs
    (ess-send-string ess-proc popup-cmd t) 
    )
  )

;; switch CREATED timestamps to be inactive
(setq org-expiry-inactive-timestamps t)

(defun org-insert-custom-header ()
  (interactive)
  (org-insert-heading)
  (org-expiry-insert-created)
  (org-id-get-create)
  ;; (message "kappa")
  )

(defun org-end-of-subtree-pos ()
  "Return the position where the current org headline entry ends."
  (save-excursion
    (org-end-of-subtree t t)
    (point)))


(defun org-agenda-skip-entry-if-tag-match (tags-to-yeet)
  ;; skip an org-agenda item if it matches any of the tags-to-yeet
  ;; to be used in org-agenda-skip-function:
  ;; if headline contains any of tags-to-yeet, this returns the end of the tree (and sub-items);
  ;; if no tags-to-yeet are matched, it returns nil

  ;; (interactive)

  (let*
    
    ;; get tag string (one string, e.g. "tag1:tag2:tag3"
    (
      ;; (tags-to-yeet (list "tec" "postponed"))
      (headline-tag-string (org-entry-get nil "TAGS"))
      (headline-tags nil)
      (yeet-decision nil)
      )

    ;; only go down this branch if there are tags
    (if (not headline-tag-string)
      nil 
      (progn

	;; split to single tags, keep only those with length > 0
	(setq headline-tags (-filter (lambda (tag_elm) (> (length tag_elm) 0))
			      (split-string
				(substring-no-properties headline-tag-string) ":")))
	;; yeet if any tags of headline are in tags-to-yeet
	(setq yeet-decision (length (-intersection tags-to-yeet headline-tags)))
	;; if yeet decision is 0 (no overlap) return nil, else get info of end of tree
	(if (eq 0 yeet-decision) nil (org-end-of-subtree-pos))
	)
         
      )))




(defun eval-last-sexp-in-ielm ()
  "Evaluate the last sexp in IELM."
  (interactive)
  (let ((sexp (thing-at-point 'sexp t)))
    (with-current-buffer "*ielm*"
      (goto-char (point-max))
      (insert sexp)
      (ielm-return))))





(defun org-cmp-closed (a b)
  "get recently closed tasks for agenda"
  ;; https://emacs.stackexchange.com/questions/73602/how-can-i-see-a-list-of-done-tasks-in-org-agenda-sorted-by-closed-date
  (let* ((a-marker (get-text-property 0 'org-marker a))
         (b-marker (get-text-property 0 'org-marker b))
         (now (current-time))
         (a-closed-ts (org-timestamp-from-string
                       (org-entry-get a-marker "CLOSED")))
         (b-closed-ts (org-timestamp-from-string
                       (org-entry-get b-marker "CLOSED")))
         (a-closed-time (or (and a-closed-ts
                                 (org-timestamp-to-time a-closed-ts))
                            now))
         (b-closed-time (or (and b-closed-ts
                                 (org-timestamp-to-time b-closed-ts))
                            now)))
    (cond ((time-less-p b-closed-time a-closed-time) +1)
          ((time-less-p a-closed-time b-closed-time) -1)
          (t nil))))
