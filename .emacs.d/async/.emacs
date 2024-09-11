(setq comp-deferred-compilation t)

(setq use-package-verbose t)

(message "test1")
(require 'package)
;; (setq package-enable-at-startup nil)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

;; (add-to-list 'load-path "/home/johannes/unicode-math-input.el")


(message "test2")
(require 'org) 
(require 'ox)
;; (require 'ox-latex)
(require 'cl)

(require 'org-ref)
(require 'use-package)
;; (require 'unicode-fonts)

(setq org-export-async-debug t)
(message "test3")

(setq org-latex-line-break-safe "\\\\")


;; (setq org-latex-pdf-process '("pdflatex -shell-escape %b" "biber %b" "pdflatex -shell-escape %b" "pdflatex -shell-escape %b"))

(setq org-latex-pdf-process '("rm -f %b.aux %b.bbl %b.bcf %b.out %b.blg"
			       "pdflatex -shell-escape %b"
			       "biber %b"
			       "pdflatex -shell-escape %b"
			       "pdflatex -shell-escape %b"))


(use-package xterm-color
  :load-path "/home/johannes/xterm-color/"

  :init
  (setq comint-output-filter-functions
        (remove 'ansi-color-process-output comint-output-filter-functions))

  (add-hook 'inferior-ess-mode-hook
            (lambda () (add-hook 'comint-preoutput-filter-functions #'xterm-color-filter nil t)))

  :config
  (setq xterm-color-use-bold t))

(setq org-babel-load-languages
      '((R . t)
	(emacs-lisp . t)
	(awk . t)
	(shell . t)
	;; (dot . t)
	;; (plantuml . t)
  ;; 	(java . t)
  ;; (cypher . t)
  ))
(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)

(setq org-confirm-babel-evaluate nil)
(setq org-export-use-babel t)

(use-package org-ref
    ;; :ensure t
    :defer t
    :config
    ;; (setq browse-url-mosaic-program 'browse-url-firefox-program)
    (setq org-ref-notes-directory "/home/johannes/Dropbox/nootes")
    (setq org-ref-bibliography-notes  "/home/johannes/Dropbox/notes/notes.org")
    (setq org-ref-default-bibliography '("/home/johannes/Dropbox/references2.bib" "/home/johannes/Dropbox/references.bib"))
    (setq org-ref-pdf-directory "/home/johannes/Dropbox/readings")
    (setq org-ref-completion-library 'org-ref-helm-bibtex)
    (setq org-ref-notes-function 'org-ref-notes-function-many-files)
    (define-key org-ref-cite-keymap (kbd "H-p") 'org-ref-open-pdf-at-point)
    ;; (define-key org-ref-cite-keymap (kbd "H-n") 'org-ref-open-notes-at-point)
    (define-key org-ref-cite-keymap (kbd "H-n") 'org-ref-open-notes-at-point-bandaid)
    (setq reftex-cite-format ;; idk if good here
          '((?c . "\\cite[]{%l}")
            (?f . "\\footcite[][]{%l}")
            (?t . "\\textcite[]{%l}")
            (?p . "\\parencite[]{%l}")
            (?o . "\\citepr[]{%l}")
            (?n . "\\nocite{%l}")))
    )

(load-file "/home/johannes/.emacs.d/config/tex.el")
(load-file "/home/johannes/.emacs.d/config/custom_funcs.el")


(setq org-export-before-processing-hook '(delete-org-comments))
(setq org-latex-prefer-user-labels t)
(add-hook 'org-export-before-processing-hook 'include-nbrs)


(add-to-list 'org-export-filter-final-output-functions
  'jackjackk/org-latex-remove-section-labels)
(add-to-list 'org-export-filter-headline-functions 'headline-numbering-filter)
(add-to-list 'org-export-filter-headline-functions 'sa-ignore-headline)

(message "LEL")




