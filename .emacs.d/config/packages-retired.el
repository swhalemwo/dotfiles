;; ** helm
;; earlier to get helm-build-sync-source to work? 

;; in `package-selected-packages`: helm helm-lsp helm-descbinds helm-recoll helm-org-rifle helm-rg


(use-package helm
    :bind (("M-x" . 'helm-M-x)           
	   ("C-x b" . 'helm-buffers-list)
	   ("C-x C-f" . 'helm-find-files)
	   ("C-s" . 'isearch-forward)
	   )
    )

(defmacro helm-find-note (dir)
    ;; https://stackoverflow.com/questions/28175154/emacs-ow-can-i-helm-find-with-default-directory-pre-specified
    ;; get helm-find to always run in Dropbox
    `(defun ,(intern (format "helm-find-note-%s" dir)) ()
	 (interactive)
	 (let ((default-directory ,dir))
	     (helm-find nil))))

(global-set-key (kbd "C-x c /") (helm-find-note "~/Dropbox/"))

(global-set-key (kbd "C-S-s") 'helm-multi-occur-from-isearch)


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
    (corfu-auto-delay 0.1)

    :init
    (global-corfu-mode))




;; ** org-roam
;; (use-package org-roam
;;   :ensure t
;;   :hook
;;   (after-init . org-roam-mode)
;;   :custom
;;   (org-roam-directory "/home/johannes/Dropbox/technical_stuff_general/explore/org-roam-test/")
;;   (org-roam-mode-sections (list
;; 			    #'org-roam-backlinks-section
;; 			    #'org-roam-reflinks-section
;; 			    ;; #'org-roam-node-insert-section
;; 			    #'org-roam-unlinked-references-section
;; 			     ))
  ;; :bind (:map org-roam-mode-map
  ;;         (("C-c n l" . org-roam)
  ;;          ("C-c n f" . org-roam-find-file)
  ;;          ("C-c n g" . org-roam-graph))
  ;;         :map org-mode-map
  ;;         (("C-c n i" . org-roam-insert))
  ;;         (("C-c n I" . org-roam-insert-immediate)))
  ;; )



(use-package treesit
  :mode (("\\.tsx\\'" . tsx-ts-mode))
  :config
  ;; Do not forget to customize Combobulate to your liking:
  ;;
  ;;  M-x customize-group RET combobulate RET
  ;;
  (use-package combobulate
    :preface
    ;; You can customize Combobulate's key prefix here.
    ;; Note that you may have to restart Emacs for this to take effect!
    (setq combobulate-key-prefix "C-c o")
    ;; :hook
    ;;   ((python-ts-mode . combobulate-mode)
    ;;    (js-ts-mode . combobulate-mode)
    ;;    (html-ts-mode . combobulate-mode)
    ;;    (css-ts-mode . combobulate-mode)
    ;;    (yaml-ts-mode . combobulate-mode)
    ;;    (typescript-ts-mode . combobulate-mode)
    ;;    (json-ts-mode . combobulate-mode)
    ;;    (tsx-ts-mode . combobulate-mode))
    ;; Amend this to the directory where you keep Combobulate's source
    ;; code.
    :load-path ("~/combobulate")))
