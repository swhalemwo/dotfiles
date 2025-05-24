(require 'package)
(setq package-check-package nil)
(setq package-check-signature nil)


;; ** language specific
;; *** c++ debugging into machine code
;; '(disaster-cxx "g++ ")
;; '(disaster-cxxflags
;;   "-O3 -Wall -fopenmp -shared -std=c++17 -fPIC -I/usr/include/python3.7m -I/usr/local/include/python3.7 -I/home/johannes/.local/include/python3.7m")

;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t)

(package-initialize)

(require 'use-package)

;; ** password-store support

(use-package password-store)


;; ** version control, auto-revert

(use-package autorevert
  :config
  (setq auto-revert-check-vc-info nil)
  (setq auto-revert-interval 120)
  )


;; ** bibtex
(use-package bibtex
  :ensure t
  :bind (:map bibtex-mode-map
	  ("C-c r" . 'bibtex-reformat)    
	  ("C-c C-d" . 'doi-insert-bibtex)
	  ( "C-c i" . 'isbn-to-bibtex2)
	  ))

(use-package bibtex-completion
  :defer t
  :config
  (setq bibtex-completion-bibliography '("/home/johannes/Dropbox/references2.bib" "/home/johannes/Dropbox/references.bib"))
  (setq bibtex-completion-additional-search-fields '(journal publisher))
  (setq bibtex-completion-cite-default-as-initial-input t)
  (setq bibtex-completion-format-citation-functions
    '((org-mode . org-ref-bibtex-completion-format-org)
       (latex-mode . bibtex-completion-format-citation-cite)
       ;; (markdown-mode . bibtex-completion-format-citation-cite)
       (default . bibtex-completion-format-citation-cite)))
  (setq bibtex-completion-library-path '("/home/johannes/Dropbox/readings/"))
  (setq bibtex-completion-notes-template-multiple-files "* ${author-or-editor} (${year}): ${title}")
  (setq bibtex-completion-pdf-open-function 'helm-open-file-with-default-tool)
  (setq bibtex-completion-notes-path "/home/johannes/Dropbox/nootes")
  )

;; ** org-ref
(use-package org-ref
  :ensure t
  ;; :defer t
  :demand t
  :config
  ;; (setq browse-url-mosaic-program 'browse-url-firefox-program)
  (setq org-ref-notes-directory "/home/johannes/Dropbox/nootes")
  (setq org-ref-bibliography-notes  "/home/johannes/Dropbox/notes/notes.org")
  (setq org-ref-default-bibliography '("/home/johannes/Dropbox/references2.bib" "/home/johannes/Dropbox/references.bib"))
  (setq org-ref-pdf-directory "/home/johannes/Dropbox/readings")
  (setq org-ref-completion-library 'org-ref-helm-bibtex)
  (setq org-ref-notes-function 'org-ref-notes-function-many-files)
  (setq org-ref-activate-cite-links nil)
  (define-key org-ref-cite-keymap (kbd "H-p") 'org-ref-open-pdf-at-point)
  ;; (define-key org-ref-cite-keymap (kbd "H-n") 'org-ref-open-notes-at-point)
  (define-key org-ref-cite-keymap (kbd "H-n") 'org-ref-open-notes-at-point-bandaid))

(define-key global-map (kbd "C-c _") 'org-ref-cite-insert-helm)


(use-package org-ref-isbn)


;; ** org



(use-package org
  ;; :ensure t
  :defer t 
  :bind (:map org-mode-map
	  ("C-c r" . 'helm-org-rifle-current-buffer)
	  ("C-c p" . 'open-pdf-of-notes-or-buffer)
          ("C-+" . 'open-org-brain-of-notes)
	  ("C-c ]" . 'org-ref-insert-cite-link)
          )


  :config
  ;; (require 'org-mu4e)
  ;; (setq org-mu4e-link-query-in-headers-mode nil)
  
  (require 'ox-odt nil t)
  (setq org-priority-lowest 69)
  (setq org-cycle-include-plain-lists 'integrate)
  (setq org-autonum-enable nil)
  (setq org-link-frame-setup (quote ((vm . vm-visit-folder-other-frame)
				      (vm-imap . vm-visit-imap-folder-other-frame)
				      (gnus . org-gnus-no-new-news)
				      (file . find-file)
				      (wl . wl-other-frame))))
  (setcdr (assoc "\\.pdf\\'" org-file-apps) "zathura %s")
  ;; https://emacs.stackexchange.com/questions/54811/open-link-of-file-in-org-mode-with-its-
  ;; defalut-application-rather-than-within-sp
  (push '("\\.docx\\'" . "lowriter %s") org-file-apps)
  (push '("\\.odt\\'" . "lowriter %s") org-file-apps)
  (push '("\\.pptx\\'" . "loimpress %s") org-file-apps)
  (push '("\\.xlsx\\'" . "localc %s") org-file-apps)
  (push '("\\.xls\\'" . "localc %s") org-file-apps)
  (push '("\\.png\\'" . "feh %s") org-file-apps)
  
  
  (setq org-log-done 'time)
  (setq org-adapt-indentation nil)
  (setq org-agenda-custom-commands
    '(
       ;; ("u" "thesis" alltodo ""
       ;;     ((org-agenda-files
       ;;       '("/home/johannes/Dropbox/agenda/thesis_tasks.org"))))

       ("y" "yinan" alltodo ""
	 ((org-agenda-files
	    '("/home/johannes/Dropbox/sync/org/yinan.org"))))


       ("g" "general" alltodo ""
	 ((org-agenda-files
	    '("/home/johannes/Dropbox/sync/org/general.org"))))

       ;; ("c" "citation network" alltodo ""
       ;; ((org-agenda-files
       ;;   '("/home/johannes/Dropbox/agenda/cit_nw_tasks.org"))))

       ("c" "closing" alltodo ""
	 ((org-agenda-files
      	    '("/home/johannes/Dropbox/phd/papers/closing/tasks_closing.org"))))
       
       ;; ("v" "obvz" alltodo ""
       ;; ((org-agenda-files
       ;;   '("/home/johannes/Dropbox/agenda/org-brain-visualize.org"))))


       ("p" . "phd")
       ("pa" "phd all"
	 ((alltodo ""
	    ((org-agenda-files
	       '("/home/johannes/Dropbox/sync/org/phd.org"))
	      (org-agenda-skip-function '(org-agenda-skip-entry-if 'tags "postponed"))
	      ))))

       ("pb" "bachelor research project"
	 ((alltodo ""
	    ((org-agenda-files
	       '("/home/johannes/Dropbox/phd/teaching/brp/tasks_brp.org"))
	      (org-agenda-skip-function '(org-agenda-skip-entry-if 'tags "postponed"))
	      ))))

       ("pc" "book chapter"
	 ((alltodo ""
	    ((org-agenda-files
	       '("/home/johannes/Dropbox/phd/papers/chapter_art_capitalism/tasks_chapter.org"))
	      (org-agenda-skip-function '(org-agenda-skip-entry-if 'tags "postponed"))
	      ))))



       ;; try org-agenda-skip-function: doesn't work
       ;; ("X" "phd"
       ;; ((alltodo ""
       ;;           ((org-agenda-files '("/home/johannes/Dropbox/sync/org/phd.org"))
       ;;            (org-agenda-skip-function
       ;;             '(org-agenda-skip-entry-if 'tags "tec"
       ;;                                        'tags "postponed"))))))

       ;; try regex?  doesn't work
       ;; ("X" "phd"
       ;; ((alltodo "postponed"
       ;;           ((org-agenda-files '("/home/johannes/Dropbox/sync/org/phd.org"))))))

       ;; try todo: finds only entries with state todo
       ;; ("X" "phd"
       ;; ((todo "postponed"
       ;;    ((org-agenda-files '("/home/johannes/Dropbox/sync/org/phd.org"))))))

       ;; ("X" "phd"
       ;;   ((todo "postponed"
       ;;      ((org-agenda-files '("/home/johannes/Dropbox/sync/org/phd.org"))))))

       ;; ("X" "phd"
       ;;   ((alltodo ""
       ;;      ((org-agenda-files '("/home/johannes/Dropbox/sync/org/phd.org"))
       ;;        (org-agenda-skip-function '(org-agenda-skip-entry-if-tag-match
       ;; 					   (list "tec" "postponed" "orga" "lit"))
       ;;          )))))
       

       ;; ("x" "phd all"
       ;;   ((alltodo ""
       ;;     ((org-agenda-files
       ;; 	'("/home/johannes/Dropbox/sync/org/phd.org"))
       ;;       (org-agenda-skip-function '(org-agenda-skip-entry-if 'tags "postponed"))
       ;;   ))))

       ;; ("x" "phd main"
       ;;   alltodo ""
       ;;   ((org-agenda-files
       ;; 	'("/home/johannes/Dropbox/sync/org/phd.org"))))
       ;;   ;; (tags "-postponed-tec-lit-orga" nil "/home/johannes/Dropbox/sync/org/phd.org")
       ;;   ;;     )

       ;; ("p" "phd" alltodo ""
       ;;     ((org-agenda-files
       ;;       '("/home/johannes/Dropbox/sync/org/phd.org"))))


       ("b" "csbs" alltodo ""
	 ((org-agenda-files
	    '("/home/johannes/Dropbox/phd/csbs/csbs.org"))))


       ;; ("k" "calctex" alltodo ""
       ;;   ((org-agenda-files
       ;;      '("/home/johannes/Dropbox/agenda/calctex.org"))))

       ("o" "phd_orga" alltodo ""
	 ((org-agenda-files
	    '("/home/johannes/Dropbox/sync/org/phd_orga.org"))))

       ("x" "tec" alltodo ""
	 ((org-agenda-files
	    '("/home/johannes/Dropbox/sync/org/tec.org"))))

       ("d" "donesies"
	 ;; ((tags "CLOSED<=\"<now>\""))
	 ((tags "CLOSED>=\"<-30d>\""))
	 ((org-agenda-cmp-user-defined 'org-cmp-closed)
	   (org-agenda-sorting-strategy '(user-defined-down))))

       ("n" "new_tasks"
	 ((tags "CREATED>=\"<-14d>\"")))


       ;; ("j" "stats" alltodo ""
       ;;  ((org-agenda-files
       ;;    '("/home/johannes/Dropbox/agenda/stats23.org"))))

       
       ;; ("W" "Weekly review"
       ;;   agenda ""
       ;;   ((org-agenda-start-day "-7d")
       ;;    (org-agenda-span 14)
       ;;    (org-agenda-start-on-weekday 1)
       ;;    ;; (org-agenda-start-with-log-mode '(closed))
       ;;    (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp "^\\*\\* DONE "))))

       ;; ("z" "stats" alltodo ""
       ;; 	 ((org-agenda-files
       ;; 	    '("~/Dropbox/phd/teaching/stats24/stats24.org"))))

       ("z" "raspberry pi" alltodo ""
	 ((org-agenda-files
	    '("~/Dropbox/technical_stuff_general/rasperrypi/raspi.org"))))

       

       ("i" "influence" alltodo ""
	 ((org-agenda-files
	    ;; '("/home/johannes/Dropbox/agenda/infl.org"))))
	    '("/home/johannes/Dropbox/phd/papers/infl/tasks_infl.org"))))

       ("f" "influence2" alltodo ""
	 ((org-agenda-files
	    ;; '("/home/johannes/Dropbox/agenda/infl.org"))))
	    '("/home/johannes/Dropbox/phd/papers/foster/tasks_foster.org"))))
       
       ("r" "reading list" alltodo ""
	 ((org-agenda-files
	    '("/home/johannes/Dropbox/sync/org/reading_list.org"))))))
  (setq org-agenda-files
    '("/home/johannes/Dropbox/personal_stuff/jobs/jobs.org"
       ;; "/home/johannes/Dropbox/agenda/cit_nw_tasks.org"
       "/home/johannes/Dropbox/sync/org/general.org"
       "/home/johannes/Dropbox/phd/papers/closing/tasks_closing.org"
       "/home/johannes/Dropbox/phd/papers/infl/tasks_infl.org"
       "/home/johannes/Dropbox/phd/papers/foster/tasks_foster.org"
       "/home/johannes/Dropbox/phd/papers/chapter_art_capitalism/tasks_chapter.org"
       "/home/johannes/Dropbox/sync/org/phd_orga.org"
       "/home/johannes/Dropbox/phd/teaching/brp/tasks_brp.org"
       "/home/johannes/Dropbox/sync/org/schedule.org"
       "/home/johannes/Dropbox/sync/org/schedule_uva2.org"
       "/home/johannes/Dropbox/sync/org/yinan.org"
       ;; "/home/johannes/Dropbox/sync/org/general.org"
       "/home/johannes/Dropbox/sync/org/tec.org"
       "/home/johannes/Dropbox/phd/csbs/csbs.org"
       ;; "/home/johannes/Dropbox/phd/teaching/stats24/stats24.org"
       "/home/johannes/Dropbox/sync/org/phd.org"))
  (setq org-agenda-log-mode-items '(clock))
  (setq org-agenda-prefix-format
    '((agenda . " %i %-12:c %?-12t % s %l")
       (timeline . "  % s")
       (todo . " %i %l")
       (tags . " %i %-12:c")
       (search . " %i %-12:c")))
  ;; uncomment to use default to get org-agenda-log-mode ordered items
  ;; (setq org-agenda-sorting-strategy '(category-keep scheduled-up))
  (setq org-agenda-tags-column 80)
  (setq org-agenda-time-grid '((require-timed) (800 1000 1200 1400 1600 1800 2000) ""))
  (setq org-agenda-window-frame-fractions '(1 . 1))
  (setq org-agenda-window-setup 'current-window)
  (setq org-archive-location "/home/johannes/Dropbox/sync/org/archive.org::* From %s")
  (setq org-babel-exp-code-template "#+begin_src %lang%switches%flags
%body
#+end_src")
  (setq org-babel-load-languages
    '((R . t)
       (emacs-lisp . t)
       (awk . t)
       (python . t)
       (shell . t)
       (sql . t)
       (mermaid . t)
       ;; (uiua . t)
       ;; (clickhouse . t) 
       (dot . t)
       (plantuml . t)
       (sqlite . t)
       ;; (neato . t)
       (java . t)
       (gnuplot . t)
       (cypher . t)))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (setq org-brain-backlink "backlink: ")
  (setq org-brain-file-entries-use-title nil)
  (setq org-brain-path "/home/johannes/Dropbox/nootes/")
  (setq org-capture-templates
    '(("m" "mail" entry
	(file "/home/johannes/Dropbox/mail.org")
	"* todo %?
        %a
      ")
       ("g" "general" entry
	 (file "/home/johannes/Dropbox/sync/org/general.org")
	 "* %?")

       ("c" "calfw2org" entry 
         (file "/home/johannes/Dropbox/sync/org/schedule.org")
         #'org-calfw-new-date)

       ("e" "excorporate" entry 
         (file "/home/johannes/Dropbox/sync/org/schedule_uva2.org")
	 #'exco-org--create-meeting-string)
       
       ("s" "study" entry
	 (file "/home/johannes/Dropbox/sync/org/gsss.org")
	 "* %?")
       ("h" "chinese" entry
	 (file "/home/johannes/Dropbox/personal_stuff/chinese/drill-test.org")
	 "* item :drill: 
** pronunciation 
%^{pronunciation} 
** meaning 
%^{meaning} 
** wubi stroke 
%^{wubi stroke} 
** char 
%?")
       ;; ("d" "chinese2" entry
       ;;  (file+headline "/home/johannes/Dropbox/personal_stuff/chinese/zh-drill.org" "chinese characters")
       ;;  #'org-drill-ch-capture-gen)
       ("f" "chinese3" entry
	 (file+headline "/home/johannes/Dropbox/personal_stuff/chinese/zh-drill3.org" "chinese characters")
	 #'org-drill-ch-capture-gen2)
       ("v" "chinese4" entry
	 (file+headline "/home/johannes/Dropbox/personal_stuff/chinese/zh-drill3.org" "chinese characters")
	 #'org-drill-ch-capture-arbitrary)
       ("d" "dutch" entry
	 (file+headline "/home/johannes/Dropbox/personal_stuff/dutch/dutch_words.org" "dutch words")
	 #'org-drill-dutch-capture)
       
       ("t" "technical" entry
	 (file "/home/johannes/Dropbox/sync/org/tec.org")
	 "* %?")))
  (setq org-clock-clocked-in-display 'both)
  (setq org-clock-mode-line-total 'current)
  (setq org-duration-format (quote h:mm))

  (setq org-agenda-clock-consistency-checks
    '(
    :max-duration "10:00"
    :min-duration 0
    :max-gap "0:05"
    :gap-ok-around ("01:00")
    :default-face  ((:background "DarkRed") (:foreground "white"))
    :overlap-face nil :gap-face nil :no-end-time-face nil :long-face nil :short-face nil))




  (setq org-confirm-babel-evaluate nil)
  (setq org-directory "/home/johannes/Dropbox")
  (setq org-drill-maximum-items-per-session 70)
  (setq org-edit-src-content-indentation 0)
  ;; (setq org-emphasis-alist
  ;; 	  '(
  ;; 	    ("`" bold)
  ;; 	    ("*" bold)
  ;; 	    ("/" italic)
  ;; 	    ("!" org-clock-overlay)
  ;; 	    ("#" org-clock-overlay)
  ;; 	    ("$" org-clock-overlay)
  ;; 	    ("&" org-clock-overlay)
  ;; 	    ("_" underline)
  ;; 	    ("=" error verbatim)
  ;; 	    ("~" org-todo)
  ;; 	    ("%" bold)
  ;; 	    ("^" show-paren-match)
  ;; 	    ("+" (:strike-through t))
  ;; 	    ))
  (setq org-export-async-debug t)
  (setq org-export-async-init-file
    "/home/johannes/Dropbox/technical_stuff_general/dotfiles/.emacs.d/async/.emacs")
  (setq org-export-in-background nil)
  (setq org-export-preserve-breaks nil)
  (setq org-export-use-babel t)
  (setq org-fontify-done-headline t)
  (setq org-fontify-whole-heading-line t)
  (setq org-format-latex-options
    '(:foreground default :background default :scale 2 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
       ("begin" "$1" "$" "$$" "\\(" "\\[")))
  (setq org-indent-indentation-per-level 1)
  (setq org-indent-mode-turns-on-hiding-stars nil)
  (setq org-journal-dir "/home/johannes/Dropbox/personal_stuff/journal")
  (setq org-latex-listings nil)
  (setq org-latex-line-break-safe "\\\\") ;; iirc comment deletion doesn't result in paragraphs, but cont. newlines
  (setq org-latex-listings-langs
    '((emacs-lisp "Lisp")
       (lisp "Lisp")
       (clojure "Lisp")
       (c "C")
       (cc "C++")
       (fortran "fortran")
       (perl "Perl")
       (cperl "Perl")
       (python "Python")
       (ruby "Ruby")
       (html "HTML")
       (xml "XML")
       (tex "TeX")
       (latex "[LaTeX]TeX")
       (shell-script "bash")
       (gnuplot "Gnuplot")
       (ocaml "Caml")
       (caml "Caml")
       (sql "SQL")
       (sqlite "sql")
       (makefile "make")
       (r "r")))
  (setq org-latex-pdf-process '("rm -f %b.aux %b.bbl %b.bcf %b.out %b.blg"
				 ;; "pdflatex --shell-escape %b"
				 ;; "biber %b"
				 ;; "pdflatex --shell-escape %b"
				 ;; "pdflatex --shell-escape %b"))
				 "pdflatex %b"
				 "biber %b"
				 "pdflatex %b"
				 "pdflatex %b"))
  (setq org-latex-prefer-user-labels t)
  (setq org-latex-text-markup-alist
    '((bold . "\\textbf{%s}")
       (code . protectedtexttt)
       (italic . "\\emph{%s}")
       (strike-through . "\\sout{%s}")
       (underline . "\\uline{%s}")
       (verbatim . protectedtexttt)
       (org-clock-overlay . "\\sout{%s}")))
  (setq org-log-refile 'note)
  (setq org-modules
    '(ol-bbdb ol-bibtex ol-docview ol-gnus ol-info ol-irc ol-mhe ol-rmail ol-w3m))
  (setq org-plantuml-jar-path "/home/johannes/plantuml.jar")
  (setq org-priority-faces '((65 . "red") (66 . "darkgreen") (67 . "blue")))
  (setq org-ref-cite-onclick-function 'org-ref-helm-cite-click)
  (setq org-ref-default-bibliography '("/home/johannes/Dropbox/references2.bib"
					"/home/johannes/Dropbox/references.bib"))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 2)))
  ;; (setq org-refile-targets '((org-agenda-files . ( :level . 1))))
  ;; (setq org-refile-targets '((nil . (:level . 1))))
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-use-outline-path 'file)
  (setq org-src-fontify-natively t)
  (setq org-src-lang-modes
    '(("ocaml" . tuareg)
       ("elisp" . emacs-lisp)
       ("ditaa" . artist)
       ("asymptote" . asy)
       ("dot" . graphviz-dot)
       ("neato" . neato)
       ("sqlite" . sql)
       ("calc" . fundamental)
       ("C" . c)
       ("cpp" . c++)
       ("C++" . c++)
       ("screen" . shell-script)
       ("shell" . sh)
       ("bash" . graphviz-dot)
       ("sh" . graphviz-dot)))
  (setq org-src-preserve-indentation t)
  (setq org-src-tab-acts-natively t)
  (setq org-startup-indented t)
  (setq org-structure-template-alist
    '(("s" . "src")
       ("beqs" . "\\begin{equation*}

\\end{equation*}")))
  (setq org-table-export-default-format "orgtbl-to-latex")
  (setq org-tags-column 0)
  (setq org-tags-exclude-from-inheritance '("drill"))
  (setq org-time-stamp-custom-formats '("<%d-%m-%Y %a>" . "<%d-%m-%Y %a %H:%M>"))
  (setq org-todo-keyword-faces
    '(("REP" . outline-8)
       ("CLASS" :background "lime green" :weight bold)
       ("done" . org-done)
       ))
  (setq orgstruct-heading-prefix-regexp "##*\\*+\\|\\`")
  (setq ob-mermaid-cli-path "/usr/bin/mmdc")
  

  

  ;; (defun update-org-latex-fragment-scale ()
  ;;   (org-toggle-latex-fragment '(16))
  ;;   (plist-put org-format-latex-options :scale ( + text-scale-mode-amount 0))
    
  ;;   (org-toggle-latex-fragment '(16)))
  
  ;; (add-hook 'text-scale-mode-hook 'update-org-latex-fragment-scale)
  (remove-hook 'text-scale-mode-hook 'update-org-latex-fragment-scale)

  (setq org-id-locations-file "/home/johannes/.emacs.d/.org-id-locations")
  (setq org-id-link-to-org-use-id t)
  
  (add-hook 'org-capture-prepare-finalize-hook 'org-id-get-create)


  (require 'org-expiry)
  (defun mrb/insert-created-timestamp()
    "Insert a CREATED property using org-expiry.el for TODO entries"
    (org-expiry-insert-created)
    (org-back-to-heading)
    (org-end-of-line)
    ;; (insert "")
    )

  ;; Whenever a TODO entry is created, I want a timestamp
  ;; Advice org-insert-todo-heading to insert a created timestamp using org-expiry
  (defadvice org-insert-todo-heading (after mrb/created-timestamp-advice activate)
    "Insert a CREATED property using org-expiry.el for TODO entries"
    (mrb/insert-created-timestamp)
    )
  ;; Make it active
  (ad-activate 'org-insert-todo-heading)

  ;;   make background of code blocks a bit darker to more easily distinguish them visually
  ;; based on https://stackoverflow.com/questions/44811679/orgmode-change-code-block-background-color
  (require 'color)
  (set-face-attribute 'org-block nil :background
    (color-darken-name
      (face-attribute 'default :background) 18))

  (plist-put org-format-latex-options :background "Transparent")


  )



;; (sparql . t)
;; original
;; (setq org-agenda-prefix-format
;;       '((agenda . " %i %-12:c %?-12t % s %l")
;; 	(timeline . "  % s")
;; 	(todo . " %i %l")
;; 	(tags . " %i %-12:c")
;; 	(search . " %i %-12:c")))

;; modified based on https://stackoverflow.com/questions/58820073/s-in-org-agenda-prefix-format-doesnt-display-dates-in-the-todo-view

(setq org-agenda-prefix-format
  '((agenda  . " %i %-12:c%?-12t% s")
     (todo  . " %(let ((scheduled (org-get-scheduled-time (point)))) (if scheduled (format-time-string \" %Y-%m-%d\" scheduled) \"\")) %i %l")
     (tags  . " %i %-12:c")
     (search . " %i %-12:c")))

;; (setq org-agenda-todo-keyword-format "%-1s")

;; (setq org-agenda-todo-keyword-format "%-1s %i")

;; (setq org-agenda-todo-keyword-format "%-1s %(let ((scheduled (org-get-scheduled-time (point)))) (if scheduled (format-time-string \"%Y-%m-%d\" scheduled) \"\"))")


;; ** org-latex-preview

(use-package org-latex-preview
  :config
  ;; Increase preview width
  (plist-put org-latex-preview-appearance-options
    :page-width 0.8)

  (plist-put org-latex-preview-appearance-options :zoom 2)

  

  ;; Use dvisvgm to generate previews
  ;; You don't need this, it's the default:
  (setq org-latex-preview-process-default 'dvisvgm)
  
  ;; Turn on auto-mode, it's built into Org and much faster/more featured than
  ;; org-fragtog. (Remember to turn off/uninstall org-fragtog.)
  (add-hook 'org-mode-hook 'org-latex-preview-auto-mode)

  ;; Block C-n, C-p etc from opening up previews when using auto-mode
  (setq org-latex-preview-auto-ignored-commands
        '(next-line previous-line mwheel-scroll
          scroll-up-command scroll-down-command))

  ;; Enable consistent equation numbering
  (setq org-latex-preview-numbered t)

  ;; Bonus: Turn on live previews.  This shows you a live preview of a LaTeX
  ;; fragment and updates the preview in real-time as you edit it.
  ;; To preview only environments, set it to '(block edit-special) instead
  (setq org-latex-preview-live t)

  ;; More immediate live-previews -- the default delay is 1 second
  (setq org-latex-preview-live-debounce 0.25))




;; (setq org-format-latex-options
;;   '(:foreground default :background "Transparent" :scale 3 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
;;      ("begin" "$1" "$" "$$" "\\(" "\\[")
;;      :page-width 0.8 :zoom 2))

;; (setq org-latex-preview-appearance-options
;;   '(:foreground default :background "Transparent" :scale 3 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
;;      ("begin" "$1" "$" "$$" "\\(" "\\[")
;;      :page-width 0.8 :zoom 2))



;; ** company
;; (use-package company)
;; (add-hook 'after-init-hook 'global-company-mode)



;; ** magit
;; (setq magit-diff-refine-hunk (quote all))
;; (setq magit-buffer-diff-args "--stat")

;; (setq magit-buffer-diff-args "--submodule=diff")





;; ** sessions
(setq my-desktop-session-dir "/home/johannes/Dropbox/technical_stuff_general/config_backup/desktop-sessions/")


(defvar my-desktop-session-name-hist nil
  "Desktop session name history")

(defun my-desktop-save (&optional name)
  "Save desktop with a name."
  (interactive)
  (unless name
    (setq name (my-desktop-get-session-name "Save session as: ")))
  (make-directory (concat my-desktop-session-dir name) t)
  (desktop-save (concat my-desktop-session-dir name) t))

(defun my-desktop-read (&optional name)
  "Read desktop with a name."
  (interactive)
  (unless name
    (setq name (my-desktop-get-session-name "Load session: ")))
  (desktop-read (concat my-desktop-session-dir name)))

(defun my-desktop-get-session-name (prompt)
  (completing-read prompt (and (file-exists-p my-desktop-session-dir)
                            (directory-files my-desktop-session-dir))
    nil nil nil my-desktop-session-name-hist))



;; ** calfw

(use-package calfw)
(require 'calfw-org)

(setq cfw:org-overwrite-default-keybinding t)
(setq cfw:org-agenda-schedule-args nil)

(setq calfw-main-email (password-store-get "calfw-email"))

(setq org-calfw-new-date-string
  (concat
    "\n:PROPERTIES:\n"
    (format ":calendar-id: %s\n" calfw-main-email)
    ":END:\n"
    ":org-gcal:\n"
    ":END:"))
				  

(defun org-calfw-new-date ()
  """function to call with org capture template: asks for time first, by default 12:00"""
  (let* ((time-of-date-input (read-string "time bitch: "))
	  (time-of-date (if (equal time-of-date-input "") "12:00" time-of-date-input))
	  )
    

    (concat "* krappa \n"
      "SCHEDULED: "
      (substring (cfw:org-capture-day) 0 (1- (length (cfw:org-capture-day)))) " " time-of-date ">"
      org-calfw-new-date-string
      )

    ))





(setq cfw:fchar-junction ?╋
  cfw:fchar-vertical-line ?┃
  cfw:fchar-horizontal-line ?━
  cfw:fchar-left-junction ?┣
  cfw:fchar-right-junction ?┫
  cfw:fchar-top-junction ?┯
  cfw:fchar-top-left-corner ?┏
  cfw:fchar-top-right-corner ?┓)



(setq cfw:org-capture-template
  '("c" "calfw2org" entry 
     (file "/home/johannes/Dropbox/sync/org/schedule.org")
     "* muh  %?\n %(cfw:org-capture-day)"))

;; ** org-gcal


(use-package org-gcal
  :init 

  (setq org-gcal-client-id (password-store-get "org-gcal-client-id"))
  (setq org-gcal-client-secret (password-store-get "org-gcal-client-secret"))
  (setq org-gcal-fetch-file-alist `((,calfw-main-email .  "/home/johannes/Dropbox/sync/org/schedule.org")))
  (setq org-gcal-auto-archive nil)
    ;; try to get password caching to work: https://github.com/kidd/org-gcal.el/issues/217
  (setq plstore-cache-passphrase-for-symmetric-encryption t)
    ;; epg-pinentry-mode 'loopback
    )


;; (org-gcal-reload-client-id-secret)

;; make org-gcal work again
;; https://github.com/kidd/org-gcal.el/issues/238
;; https://www.reddit.com/r/emacs/comments/137r7j7/gnupg_241_encryption_issues_with_emacs_orgmode/
;; FIXME: might break things
(fset 'epg-wait-for-status 'ignore)



;; ** mu4e

(require 'mu4e)

(setf (alist-get 'trash mu4e-marks)
  (list :char '("d" . "▼")
    :prompt "dtrash"
    :dyn-target (lambda (target msg)
                  (mu4e-get-trash-folder msg))
    :action (lambda (docid msg target)
              ;; Here's the main difference to the regular trash mark,
              ;; no +T before -N so the message is not marked as
              ;; IMAP-deleted:
              (mu4e~proc-move docid (mu4e~mark-check-target target) "-N"))))

;; ** org-msg

(use-package org-msg
  :ensure t
  :init
  (setq mail-user-agent 'mu4e-user-agent)
  (setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil \\n:t"
    org-msg-startup "hidestars indent inlineimages"
    org-msg-greeting-fmt "\nHi%s,\n\n"
    org-msg-recipient-names '(("jeremy.compostella@gmail.com" . "Jérémy"))
    org-msg-greeting-name-limit 3
    org-msg-default-alternatives '((new		. (text html))
				    (reply-to-html	. (text html))
				    (reply-to-text	. (text)))
    org-msg-convert-citation t))


;; ** excorporate

;; read: 
;; [[id:85172178-aaa4-49b2-bf2a-150579e0ebea][oauth]]
;; https://simondobson.org/2024/02/03/getting-email/
;; https://wiki.gnome.org/Apps/Evolution/EWS/OAuth2

(use-package excorporate
  :ensure t
  :init
  (setq excorporate-tenant-identifier (password-store-get "excorporate-tenant-identifier"))
  
  (setq excorporate-configuration 
    `(("resource-url" . "https://outlook.office365.com/EWS/Exchange.asmx")
       ("resource-url-prefixes" "https://outlook.office365.com/EWS/")
       ("authorization-endpoint" . ,(format "https://login.microsoftonline.com/%s/oauth2/authorize" excorporate-tenant-identifier))
       ("access-token-endpoint" . ,(format "https://login.microsoftonline.com/%s/oauth2/token" excorporate-tenant-identifier))
       ("client-identifier" . ,(password-store-get "excorporate-client-identifier"))
       ("scope" . "openid offline_access profile Mail.ReadWriteMail.ReadWrite.Shared Mail.Send Mail.Send.SharedCalendars.ReadWrite Calendars.ReadWrite.Shared Contacts.ReadWriteContacts.ReadWrite.Shared Tasks.ReadWrite Tasks.ReadWrite.SharedMailboxSettings.ReadWrite People.Read User.ReadBasic.All")
       ("authorization-extra-arguments"
	 ("resource" . "https://outlook.office.com")
	 ("response_mode" . "query")
	 ("login_hint" . ,(password-store-get "excorporate-login-hint"))
	 ("prompt" . "login")
	 ("redirect_uri" . "https://login.microsoftonline.com/common/oauth2/nativeclient")
	 ("" . ""))
       ("" . "")))
  
  (setq excorporate-org-mschedule-file "/home/johannes/Dropbox/sync/org/schedule_uva.org")
  (setq excorporate-org-schedule-file "/home/johannes/Dropbox/sync/org/schedule_uva2.org")
  (define-key cfw:org-custom-map (kbd "e") 'exco-org-create-meeting)

  )


(use-package excorporate-org)



;; ** orderless
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; ** vertico

(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  ;; (vertico-reverse-mode)
  (setq vertico-count 30)
  (setq vertico-resize nil)
  )

(defun update-vertico-count ()
  ;; (message "setting vertico-count")
  (setq vertico-count (/ (frame-height) 2)))

(add-hook 'minibuffer-setup-hook 'update-vertico-count)
;; (remove-hook 'minibuffer-setup-hook 'update-vertico-count)


;; ** marginalia
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (
	  ;; ("M-A" . marginalia-cycle)
          :map minibuffer-local-map
          ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;; ** embark
(use-package embark
  :ensure t
  :demand

  :init
  (setq embark-confirm-act-all nil)

  :bind (
	  ("C-;" . embark-act)        ;; good alternative: M-.
	  ("C-=" . embark-collect)
	  )
  )


(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))


;; ** consult


(use-package consult
  :ensure t
  :demand
  :init
  
  (defun consult-line-multi2 ()
    (interactive)
    (let ((queryx (read (read-from-minibuffer "query: "))))
      ;; (message query)
      (consult-line-multi queryx)
      ))

  (defun consult-imenu-multi2 ()
    (interactive)
    (consult-imenu-multi (list :sort 'alpha :mode major-mode)))
  
  (global-unset-key (kbd "C-c o"))

  (defun my/consult-line-multi (buffers)
    (interactive)
    (consult-line-multi (list :include buffers)))

  (defun consult-ripgrep-curdir ()
    (interactive)
    ;; run consult-ripgrep in current dir

    (let* ((file-path (buffer-file-name))
	    (dir-path (when file-path (file-name-directory file-path))))
      (consult-ripgrep dir-path)))

  (defun consult-grep-curfile ()
    (interactive)
    (consult-grep (list (buffer-file-name))))


  

  :config 
  (add-to-list 'embark-multitarget-actions #'my/consult-line-multi) ;; allow searching in buffer selection

  (setq consult-buffer-sources 
    '(
       consult--source-recent-file
       consult--source-modified-buffer
       consult--source-hidden-buffer
       consult--source-buffer
       consult--source-file-register
       consult--source-bookmark
       consult--source-project-buffer-hidden
       consult--source-project-recent-file-hidden))

  (define-key embark-buffer-map (kbd "m") 'my/consult-line-multi)


  :bind (
	  ;; ("C-S-s" . consult-line-multi2)
	  ;; ("C-c o" . consult-imenu-multi2)
	  ("C-x b" . consult-buffer)
	  ("C-," . consult-line)
	  ("C-." . consult-ripgrep-curdir)

	  ))



;; ** affe
(use-package affe
  :bind (
	  ("C-$" . affe-find)
	  )
  )


;; consult-imenu-multi2
;; ** helm

(use-package helm
  :ensure t
  :demand 
  :bind (
	  ("C-S-s" . helm-multi-occur-from-isearch)
	  )
  )

(use-package helm-bibtex
  :ensure t
  :demand)

;; ** pdf-tools
(use-package pdf-tools)



;;  ** tree-sitter
(setq treesit-language-source-alist
  '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (r "https://github.com/r-lib/tree-sitter-r")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; ** straight

(defvar bootstrap-version)
(let ((bootstrap-file
	(expand-file-name
          "straight/repos/straight.el/bootstrap.el"
          (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
       (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
        "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; ** copilot

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :ensure t)


(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
;; (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion-by-word)



;; ** casual-dired
(use-package casual-dired
  :ensure t
  :bind (:map dired-mode-map ("C-o" . 'casual-dired-tmenu)))

;; ** elisp mode

(add-hook 'emacs-lisp-mode-hook 'outshine-mode)


;; ** vterm

(use-package vterm
  :ensure t

  :config

  (defun vterm-curdir ()
    (interactive)
    (let ((current-prefix-arg '(4))) (call-interactively 'vterm)))

  
  (setq vterm-timer-delay 0.01)
  :bind (:map vterm-mode-map
	  ("C-l" . recenter-top-bottom)
	  :map global-map 
	  ("C-c v" . vterm-curdir)))
	  


;; ** corfu

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match t)      ;; Never quit, even if there is no match
  (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect-first t)    ;; Disable candidate preselection
  (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  (corfu-scroll-margin 5)        ;; Use scroll margin
  (corfu-auto-delay 0.1)         ; probably delay
  (completion-ignore-case t)     ;; ignore case when matching
  (corfu-bar-width 0)
  (corfu-left-margin-width 0)
  (corfu-right-margin-width 0)
  ;; (corfu-
  ;; (corfu-
  ;; :init
  ;; (global-corfu-mode)
  )


(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  )




;; ** ispell fix


(defun my-dabbrev-in-text()
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

(add-hook 'text-mode-hook #'my-dabbrev-in-text)
(remove-hook 'text-mode-hook #'my-dabbrev-in-text)

;; (setq completion-at-point-functions
;;   (list #'cape-dabbrev #'ispell-completion-at-point))


(setq ispell-complete-word-dict nil)

(setq text-mode-ispell-word-completion nil)





