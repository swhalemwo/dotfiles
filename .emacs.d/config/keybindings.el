

(global-set-key (kbd "C-c C-o") 'org-open-at-point)

(global-set-key (kbd "C-:") 'avy-goto-char)
(global-unset-key (kbd "C-'"))
(local-unset-key (kbd "C-'"))
(define-key org-mode-map (kbd "C-'") nil)
(global-set-key (kbd "C-'") 'avy-goto-char-timer)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)

(global-set-key (kbd "M-g g") 'consult-goto-line)

(global-unset-key (kbd "C-."))
(local-unset-key (kbd "C-."))
;; (flyspell-mode)
;; (eval-after-load 'flyspell-mode
;; (define-key flyspell-mode-map (kbd "C-.") nil) )
(global-set-key (kbd "C-.") 'ispell-word)



(global-set-key (kbd "H-;") 'shrink-window-horizontally)
(global-set-key (kbd "H-j") 'enlarge-window-horizontally)
(global-set-key (kbd "H-k") 'shrink-window)
(global-set-key (kbd "H-l") 'enlarge-window)

;; (require 'org-drill)

(define-key global-map "\C-cc" 'org-capture)

;; ace window
(global-set-key (kbd "M-o") 'ace-window)

;; (global-set-key (kbd "C-i") 'ace-window)
(global-set-key (kbd "C-c (") 'mu4e-alert-view-unread-mails)

;; multi occur in matching buffers
(global-set-key (kbd "M-s M-o") 'multi-occur-in-matching-buffers)
(global-set-key (kbd "C-c C-j") 'org-journal-new-entry)
(global-set-key (kbd "C-c )") 'reftex-citation)

;; buffer menu START
(global-set-key (kbd "C-x C-b") 'buffer-menu)



;; MACROS START
(fset 'uncomment-star
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("" 0 "%d")) arg)))
(global-set-key [24 11 49] 'uncomment-star)

(fset 'comment-star
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("* " 0 "%d")) arg)))
(global-set-key [24 11 50] 'comment-star)
;; MACROS END


;; ORG MODE CONFIG
;; The following lines are always needed. Choose your own keys.
;;(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; not needed since Emacs 22.2
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)

(global-set-key "\C-ca" 'org-agenda)

;; (global-set-key "\C-c_" 'helm-bibtex)



(global-set-key (kbd "C-c ]") nil)
(local-unset-key (kbd "C-c ]"))
(define-key org-mode-map (kbd "C-c ]") nil)


(local-set-key (kbd "C-c ]") 'org-ref-citation-at-point)
(define-key org-mode-map (kbd "C-c ]") 'org-ref-citation-at-point)
(global-set-key (kbd "C-c ]") 'org-ref-citation-at-point)

(local-set-key (kbd "C-c R") 'org-ref)
(define-key org-mode-map (kbd "C-c R") 'org-ref)
(global-set-key (kbd "C-c R") 'org-ref)


(global-unset-key (kbd "C-c C-n"))

;; (define-key KEYMAP KEY nil)


(global-set-key (kbd "C-c C-n") nil)
(global-set-key (kbd "C-c C-n") 'org-next-visible-heading)


(global-set-key (kbd "C-c m") 'magit-status)


(define-key org-mode-map (kbd "C-S-RET") 'org-insert-todo-subheading)


(define-key org-brain-visualize-mode-map (kbd "H") 'helm-brain)


(define-key emacs-lisp-mode-map (kbd "C-c C-l") 'load-current-file)


(global-set-key (kbd "C-x o") 'other-window)

(global-set-key (kbd "C-`") 'org-recoll-search)
(global-set-key (kbd "M-g b") 'magit-blame)

(global-set-key (kbd "C-M-<backspace>") 'backward-kill-sexp)


;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)


(global-set-key (kbd "C-c t") 'open-ut)

(global-set-key (kbd "C-c d") 'cfw-open)
(global-set-key (kbd "C-c u") 'mu4e)

;; (global-set-key (kbd "C-c h") 'insert-hat)
;; (global-set-key (kbd "C-c b") 'insert-bar)


(define-key org-mode-map (kbd "C-c b") 'org-brain-visualize)
(define-key org-mode-map (kbd "C-c o")  'consult-org-heading)
(define-key org-mode-map (kbd "C-,")  'consult-line)
(define-key org-mode-map (kbd "C-#")  'consult-git-grep)


;; (define-key emacs-lisp-mode-map (kbd "C-,")  'consult-line)
;; (global-set-key (kbd "C-,")  'consult-line)

;; (global-set-key (kbd "C-.")  'consult-ripgrep-curdir)



(define-key ess-mode-map (kbd "C-,") 'consult-line)
(define-key ess-mode-map (kbd "C-c n") 'r-names-at-point)
(define-key ess-mode-map (kbd "C-c z") 'r-last-trace)
(define-key ess-mode-map (kbd "C-c p") 'ess-r-process-object)
(define-key ess-mode-map (kbd "C-c s") 'r-str-at-point)
(define-key ess-mode-map (kbd "C-c r") 'r-summary-at-point)
(define-key ess-mode-map (kbd "C-.") 'consult-ripgrep-curdir)
(define-key ess-mode-map (kbd "C-#") 'consult-git-grep)






(define-key inferior-ess-mode-map (kbd "M-r") 'consult-history)

(define-key org-mode-map (kbd "C-c g") 'org-update-nbrs)
(define-key org-mode-map (kbd "C-c n") 'org-insert-macro)

(define-key org-mode-map (kbd "C-c x") 'org-insert-custom-header)

(define-key org-mode-map (kbd "C-c f") 'open-pdf-fig)

(define-key org-mode-map (kbd "C-S-<return>") 'org-insert-todo-subheading)

(define-key minibuffer-mode-map (kbd "M-r") 'consult-history) ;; add consult-history for minibuffer
(define-key ielm-map (kbd "M-r") 'consult-history) ;; add consult history for ielm history

(define-key minibuffer-mode-map (kbd "M-s") 'embark-select)


(defun insert-then-arrow-plaintext ()
  (interactive)

  (when (not (= (point)
	(save-excursion
	  (beginning-of-line)
	  (point))))
    (just-one-space 1)
    )
    
  (insert "-> ")
  ;; (reindent-then-newline-and-indent)
  )

(define-key org-mode-map (kbd "C->") 'insert-then-arrow-plaintext)


(define-key emacs-lisp-mode-map (kbd "C-c C-e") 'eval-last-sexp-in-ielm)
(define-key emacs-lisp-mode-map (kbd "C-.") 'consult-ripgrep-curdir)
(define-key emacs-lisp-mode-map (kbd "C-#")  'consult-git-grep)

(define-key emacs-lisp-mode-map (kbd "C-M-;") 'iedit-mode)
(define-key org-mode-map (kbd "C-M-;") 'iedit-mode)
(define-key ess-mode-map (kbd "C-M-;") 'iedit-mode)
(define-key elpy-mode-map (kbd "C-M-;") 'iedit-mode)
(define-key ledger-mode-map (kbd "C-M-;") 'iedit-mode)

(define-key elpy-mode-map (kbd "M-n") 'other-window)
(define-key elpy-mode-map (kbd "C-M-.") 'elpy-short-summary-at-point)

(define-key dired-mode-map (kbd "J") 'xah-open-in-external-app)

