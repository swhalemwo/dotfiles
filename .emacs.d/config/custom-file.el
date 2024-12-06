

;; ** custom stuff? 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-move-point-for-output nil)
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 4)
 '(custom-safe-themes
    '("0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" default))
 '(default-input-method "pyim")
 '(eldoc-documentation-strategy 'eldoc-documentation-default)
 '(eldoc-echo-area-prefer-doc-buffer t)
 '(eldoc-print-after-edit nil)
 '(embark-mixed-indicator-delay 0)
 '(free-keys-modifiers '("" "C" "M" "C-M" "C-c"))
 '(helm-type-file-actions
    '(("Find file" . helm-find-file-or-marked)
       ("Find file as root" . helm-find-file-as-root)
       ("Open file with default tool" . helm-open-file-with-default-tool)
       ("Find file other window" . helm-find-files-other-window)
       ("Find file other frame" . find-file-other-frame)
       ("Open dired in file's directory" . helm-open-dired)
       ("Attach file(s) to mail buffer `C-c C-a'" . helm-ff-mail-attach-files)
       ("Marked files in dired" . helm-marked-files-in-dired)
       ("Grep File(s) `C-u recurse'" . helm-find-files-grep)
       ("Zgrep File(s) `C-u Recurse'" . helm-ff-zgrep)
       ("Pdfgrep File(s)" . helm-ff-pdfgrep)
       ("Insert as org link" . helm-files-insert-as-org-link)
       ("Checksum File" . helm-ff-checksum)
       ("Ediff File" . helm-find-files-ediff-files)
       ("Ediff Merge File" . helm-find-files-ediff-merge-files)
       ("View file" . view-file)
       ("Insert file" . insert-file)
       ("Add marked files to file-cache" . helm-ff-cache-add-file)
       ("Delete file(s)" . helm-ff-delete-files)
       ("Copy file(s) `M-C, C-u to follow'" . helm-find-files-copy)
       ("Rename file(s) `M-R, C-u to follow'" . helm-find-files-rename)
       ("Symlink files(s) `M-S, C-u to follow'" . helm-find-files-symlink)
       ("Relsymlink file(s) `C-u to follow'" . helm-find-files-relsymlink)
       ("Hardlink file(s) `M-H, C-u to follow'" . helm-find-files-hardlink)
       ("Open file externally (C-u to choose)" . helm-open-file-externally)
       ("Find file in hex dump" . hexl-find-file)))
 '(mu4e-headers-results-limit 200)
 '(mu4e-search-results-limit 200)
 '(org-cycle-separator-lines 0)
 '(org-recoll-results-num 50)
 '(org-todo-keywords '((sequence "todo" "|" "done" "postponed")))
 '(package-selected-packages
    '(quelpa wgrep mermaid-mode ob-mermaid websocket editorconfig all-the-icons which-key ledger-mode imenu-anywhere consult affe corfu embark marginalia tree-sitter markdown-mode eglot ado-mode orgit with-editor diff-hl dash gnuplot emacsql-sqlite emacsql-sqlite3 company-jedi sql-indent sqlup-mode sql-mode solarized-theme ob-sql-mode color-theme-buffer-local vterm sql-clickhouse sqlite sqlite3 cypher-mode org-ql elpy helm-org-rifle org-gcal calfw-gcal calfw-cal calfw-org cc-cedict calfw git-timemachine helm-descbinds debbugs company org-wc graphviz-dot-mode magit eval-in-repl ob-async free-keys ess ob-cypher use-package outshine youdao-dictionary org-drill unicode-fonts pyim-wbdict gif-screencast org-brain org-contrib auctex helm-recoll org-babel-eval-in-repl async mu4e-maildirs-extension flyspell-correct f s switch-window mu4e-alert csv-mode helm-bibtex embark-consult jedi))
 '(sql-clickhouse-login-params '(database))
 '(table-cell-horizontal-chars "-=")
 '(warning-suppress-types '((emacs))))


;; old packages deleted
;; org-roam-ui org-roam
;; helm-lsp lsp-python-ms lsp-ui lsp-mode
;; lispy worf comb ivy-searcher indium
;; counsel fzf helm-rg auto-complete


;; old packages uncommented/removed from package-selected-packages
;; tree-sitter-ess-r
;; 0blayout
;; ctable 
;; 

;;  '(org-todo-keywords '((sequence "todo" "|" "done" "postponed"))) based on https://emacs.stackexchange.com/questions/55924/exclude-cancelled-items-from-org-mode-agenda
 


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#57dbce" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "PfEd" :family "DejaVu Sans Mono"))))
 '(ac-completion-face ((t (:inherit popup-menu-mouse-face))))
 '(calc-nonselected-face ((t (:inherit alert-moderate-face))))
 '(corfu-border ((t (:background "#2CCFBF"))))
 '(corfu-current ((t (:extend t :background "#00ffff" :foreground "black"))))
 '(corfu-default ((t (:background "#2CCFBF"))))
 '(csv-separator-face ((t nil)))
 '(cypher-pattern-face ((t (:foreground "DeepPink" :weight bold))))
 '(cypher-symbol-face ((t (:inherit font-lock-variable-name-face))))
 '(cypher-variable-face ((t (:foreground "black"))))
 '(eglot-highlight-symbol-face ((t nil)))
 '(eldoc-highlight-function-argument ((t (:inherit nil))))
 '(fold-this-overlay ((t (:inherit company-template-field))))
 '(font-lock-function-name-face ((t (:foreground "#882255" :weight bold))))
 '(highlight ((t (:background "cyan"))))
 '(markdown-pre-face ((t (:inherit (markdown-code-face font-lock-constant-face default)))))
 '(minimap-font-face ((t (:height 15 :family "DejaVu Sans Mono"))))
 '(org-agenda-done ((t (:foreground "black"))))
 '(org-block ((t (:inherit black))))
 '(org-headline-done ((t (:foreground "dark green"))))
 '(org-hide ((t (:foreground "LightBlue" :underline nil :weight bold))))
 '(org-indent ((t (:inherit org-hide :underline "#add8e7"))))
 '(org-scheduled ((t (:foreground "black"))))
 '(org-scheduled-previously ((t (:foreground "black"))))
 '(org-scheduled-today ((t (:foreground "black"))))
 '(org-todo ((t (:foreground "navy" :weight bold))))
 '(powerline-active1 ((t (:background "grey70"))))
 '(powerline-active2 ((t (:inherit mode-line :background "grey80"))))
 '(powerline-inactive1 ((t (:inherit mode-line-inactive :background "grey55"))))
 '(powerline-inactive2 ((t (:inherit mode-line-inactive :background "grey75"))))
 '(secondary-selection ((t (:extend t :background "dark turquoise" :foreground "black"))))
 '(show-paren-match ((t (:background "yellow"))))
 '(show-paren-mismatch ((t (:background "purple" :foreground "white" :weight bold))))
 '(table-cell ((t (:background "cyan" :foreground "black" :inverse-video nil))))
 '(term-color-cyan ((t (:background "cyan3" :foreground "orange"))))
 '(vterm-color-cyan ((t (:foreground "blue"))))
 '(vterm-color-green ((t (:foreground "Magenta4"))))
 '(vterm-color-white ((t (:foreground "blue"))))
 '(vterm-color-yellow ((t (:foreground "ForestGreen"))))
 '(warning ((t (:foreground "DarkOrange3" :weight bold)))))


;; https://notes.alexkehayias.com/emacs-inline-macro-in-the-buffer/
;; Display macros inline in buffers
(add-to-list 'font-lock-extra-managed-props 'display)


(setq org-macro-fontlock-keywords
  '(("\\({{{[a-zA-Z#%_)(-+0-9]+}}}\\)" 0
    `(face nil display
           ,(format "%s"
                    (let* ((input-str (match-string 0))
                            (el (with-temp-buffer
				  (org-mode)
                                (insert input-str)
                                (goto-char (point-min))
                                (org-element-context)))
                          (text (org-macro-expand el org-macro-templates)))
                      (if text
                          text
                        input-str)))))))
 
;; (font-lock-add-keywords 'org-mode org-macro-fontlock-keywords)

;; (font-lock-remove-keywords 'org-mode org-macro-fontlock-keywords)

(setq org-macro-fontlock t)

(defun toggle-org-macro-fontlock ()
  ;; if org-macro-fontlock is nil, add the fontlock keywords, remove otherwise
  ;; org-mode-restart necessary for some reason 
  (interactive)
  (if (not org-macro-fontlock)
    (progn
      (font-lock-add-keywords 'org-mode org-macro-fontlock-keywords)

      (org-mode-restart)
      (setq org-macro-fontlock t))
    
    (progn
      (message "time to yeet org-macro-fontlock-keywords")
      (font-lock-remove-keywords 'org-mode org-macro-fontlock-keywords)

      (org-mode-restart)
      (setq org-macro-fontlock nil))))

