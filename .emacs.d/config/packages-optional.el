;; ** some terminal shenanigans

(add-hook 'post-command-hook 'change-my-background-color)

(add-hook 'change-major-mode-hook 'change-my-background-color)

(add-hook 'window-configuration-change-hook 'change-my-background-color)

(defun change-my-background-color ()
  (cond
    ((eq major-mode 'ansi-term-mode)
     (set-background-color "honeydew"))
    ))

;; (setq vterm-term-environment-variable "rxvt-unicode-256colors")


;; *** org-babel

(use-package ob-cypher
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages '(cypher . t))

  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
  (add-to-list 'org-babel-tangle-lang-exts '("cypher" . "cypher"))
  ;; (add-to-list 'org-babel-tangle-lang-exts '("cypher" . "obvz-cypher"))
  ;; (add-to-list 'org-babel-tangle-lang-exts '("cypher" . "obvz-cypher"))
  )
  ;; (add-to-list 'org-babel-load-languages '(cypher-obvz . t))

;; (use-package ob-async)
(use-package ob-java)

;; ;; *** ac
;; (use-package auto-complete
;;     :config 
;;     (setq ac-auto-show-menu 0.01)
;;     (setq ac-auto-start t)
;;     (setq ac-candidate-limit 1)
;;     (setq ac-candidate-menu-min 5)
;;     (setq ac-delay 0.02)
;;     (setq ac-quick-help-delay 0.1)
;;     (setq ac-show-menu-immediately-on-auto-complete t)
;;     (setq ac-use-fuzzy t)
;;     )




;; *** some jedi-testing, but that doesn't work either for complex stuff, also looks ugly
;; (defun company-jedi-setup ()
;;   (add-to-list 'company-backends 'company-jedi))
;; (add-hook 'elpy-mode-hook 'company-jedi-setup)
;; (setq jedi:setup-keys t)
;; (setq jedi:complete-on-dot t)
;; (add-hook 'elpy-mode-hook 'jedi:setup)


;; (require 'ob-dot)

;; ** helm source??
;; (require 'helm-source)



;; ** obvz
;; (load "/home/johannes/Dropbox/personal_stuff/obr-viz/obvz.el")
;; (remove-hook 'org-brain-after-visualize-hook 'obvz-update-graph)

;; (setq obvz-dir "/home/johannes/Dropbox/personal_stuff/obr-viz/")
;; (setq obvz-python-version "python3.7")



;; ** ccls
;; (setq ccls-executable "/usr/bin/ccls")

;; (use-package ccls
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda () (require 'ccls) (lsp))))

;; ** lsp
;; (use-package lsp

;;     :config
;;     (setq lsp-keymap-prefix "C-)")
;;     )



;; (use-package lsp-python-ms
;;   :ensure t
;;   :hook (python-mode . (lambda ()
;;                          (require 'lsp-python-ms)
;;                          (lsp)))
;;   :init
;;   (setq lsp-python-ms-executable (executable-find "python-language-server"))
;;   )

;; (use-package lsp-mode
;;     :ensure t)


;; (use-package lsp-python-ms
;;     :ensure t
;;     :after '(lsp)
;;   :init (setq lsp-python-ms-auto-install-server t)
;;   :hook (python-mode . (lambda ()
;;                           (require 'lsp-python-ms)
;;                           (lsp))))  ; or lsp-deferred


;; (use-package lsp-mode
;;   :ensure t
;;   :config

;; make sure we have lsp-imenu everywhere we have LSP
;; (require 'lsp-imenu)
;; (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)  
;; get lsp-python-enable defined
;; NB: use either projectile-project-root or ffip-get-project-root-directory
;;     or any other function that can be used to find the root directory of a project
;; (lsp-define-stdio-client lsp-python "python"
;;                          #'projectile-project-root
;;                          '("pyls"))

;; make sure this is activated when python-mode is activated
;; lsp-python-enable is created by macro above 
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (lsp-python-enable)))

;; lsp extras
;; (use-package lsp-ui
;;   :ensure t
;;   :config
;;   (setq lsp-ui-sideline-ignore-duplicate t)
;;   (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; (use-package company-lsp
;;   :config
;;   (push 'company-lsp company-backends))

;; NB: only required if you prefer flake8 instead of the default
;; send pyls config via lsp-after-initialize-hook -- harmless for
;; other servers due to pyls key, but would prefer only sending this
;; when pyls gets initialised (:initialize function in
;; lsp-define-stdio-client is invoked too early (before server
;; start)) -- cpbotha
;; (defun lsp-set-cfg ()
;;   (let ((lsp-cfg `(:pyls (:configurationSources ("flake8")))))
;;     ;; TODO: check lsp--cur-workspace here to decide per server / project
;;     (lsp--set-configuration lsp-cfg)))

;; (add-hook 'lsp-after-initialize-hook 'lsp-set-cfg))

;; ** calctex
;; (add-to-list 'load-path "/home/johannes/.emacs.d/calctex/calctex/")
;; (require 'calctex)


;; *** calc
(setq calc-highlight-selections-with-faces t)

;; ** pdf continuous scroll

;; (add-to-list 'load-path "/home/johannes/.emacs.d/extras/pdf-continuous-scroll-mode.el")


;; (eval-after-load "pdf-view"
;;     (progn 
;; 	(require 'pdf-view)
;; 	(require 'pdf-continuous-scroll-mode)))

;; ** eglot

(use-package eglot
  :ensure t
  :defer t
  ;; :commands (eglot eglot-ensure)
  :hook (python-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("pylsp")))
  ;; (setq eglot-ignored-server-capabilities '(
  ;; 					     :colorPresentation 
  ;; 					     :hoverProvider
  ;; 					     :completionProvider
  ;; 					     :signatureHelpProvider
  ;; 					     :definitionProvider
  ;; 					     :typeDefinitionProvider
  ;; 					     :implementationProvider
  ;; 					     :declarationProvider
  ;; 					     :referencesProvider
  ;; 					     :documentHighlightProvider
  ;; 					     :documentSymbolProvider
  ;; 					     :workspaceSymbolProvider
  ;; 					     :codeActionProvider
  ;; 					     :codeLensProvider
  ;; 					     :documentFormattingProvider
  ;; 					     :documentRangeFormattingProvider
  ;; 					     :documentOnTypeFormattingProvider
  ;; 					     :renameProvider
  ;; 					     :documentLinkProvider
  ;; 					     :colorProvider
  ;; 					     :foldingRangeProvider
  ;; 					     :executeCommandProvider
  ;; 					     :inlayHintProvider
  ;; 					     ))
  ;; (setq eglot-ignored-server-capabilities '(:documentFormattingProvider :documentRangeFormattingProvider :documentOnTypeFormattingProvider :documentHighlightProvider :colorProvider :publishDiagnostics))

  )


(defun eglot-python-mode-initialize ()
  (setq-local
    eldoc-documentation-functions
    (list
      #'eglot-signature-eldoc-function
      #'eglot-hover-eldoc-function
      #'flymake-eldoc-function
      )))

(add-hook 'eglot-managed-mode-hook #'eglot-python-mode-initialize)
(remove-hook 'eglot-managed-mode-hook #'eglot-python-mode-initialize)


(setq eldoc-echo-area-prefer-doc-buffer t
      eldoc-echo-area-use-multiline-p nil) 


(use-package poetry
  :ensure t
  :defer t
  :config
  ;; Checks for the correct virtualenv. Better strategy IMO because the default
  ;; one is quite slow.
  (setq poetry-tracking-strategy 'switch-buffer)
  :hook (python-mode . poetry-tracking-mode))

  ;; :config   
   ;; (add-to-list 'eglot-server-programs
   ;;             `(python-mode
   ;;               . ,(eglot-alternatives '(("pyright-langserver" "--stdio")
   ;;                                        "jedi-language-server"
   ;;                                        "pylsp"))))



;; (setq gc-cons-threshold 25600000)
  

;; (setq gc-cons-threshold 8000000)
;; (setq gc-cons-percentage 0.5)
;; (setq gc-cons-threshold (* 1024 1024 100))
  ;; (run-with-idle-timer 2 t (lambda () (garbage-collect)))
  
;; (run-with-idle-timer 2 t 'garbage-collect)




(setq read-process-output-max (* 1024 1024))

(setq eldoc-idle-delay 0.1)


;; (setq eglot-send-changes-idle-time 0.1)
;; (setq eglot-stay-out-of '(company ess))
;; (remove-hook 'eldoc-display-functions 'eldoc-display-in-echo-area)
;; (add-hook 'eldoc-display-functions 'eldoc-display-in-echo-area)

(setq eldoc-documentation-strategy 'eldoc-documentation-default)

(setq max-mini-window-height 3)
;; (setq max-mini-window-height 0.25)		


(defun nice-persistent-docu ()
    "put the output of eldoc documentation into persistent eldoc-pers buffer"
    (interactive)
    (let ((buffer-contents (with-current-buffer "*eldoc*"
			       (buffer-substring-no-properties 1 (buffer-end 1)))))
	(with-output-to-temp-buffer "eldoc-pers"
	    (princ buffer-contents))))

(defun eldoc-doc-buffer ()
  "Display ElDoc documentation buffer.

This holds the results of the last documentation request."
  (interactive)
  (unless (buffer-live-p eldoc--doc-buffer)
    (user-error (format
                 "ElDoc buffer doesn't exist, maybe `%s' to produce one."
                 (substitute-command-keys "\\[eldoc]"))))
  (with-current-buffer eldoc--doc-buffer
    (rename-buffer (replace-regexp-in-string "^ *" ""
                                             (buffer-name)))
    (display-buffer (current-buffer))
    (delete-other-windows)
    (nice-persistent-docu)
    ))






;; ** ellama

(use-package llm)

(use-package ellama
  :init
  ;; setup key bindings
  (setopt ellama-keymap-prefix "C-c e")
  ;; language you want ellama to translate to
  (setopt ellama-language "English")
  (setopt ellama-translate-italic nil)
  ;; could be llm-openai for example
  (require 'llm-ollama)
  (require 'llm-openai)
  (setopt llm-warn-on-nonfree nil)
  (setq llm-openai-key (password-store-get "llm-openai-key"))
  (setopt ellama-provider
    ;; 	  (make-llm-ollama
    ;; 	   ;; this model should be pulled to use it
    ;; 	   ;; value should be the same as you print in terminal during pull
    ;; 	   :chat-model "llama3:8b-instruct-q8_0"
    ;; 	   :embedding-model "nomic-embed-text"
    ;; 	   :default-chat-non-standard-params '(("num_ctx" . 8192))))
    (make-llm-openai
      :key llm-openai-key
      ;; :chat-model "gpt-3.5-turbo"))
      :chat-model "gpt-4o-mini"))
  ;; :embedding-model "nomic-embed-text"
  ;; :default-chat-non-standard-params '(("num_ctx" . 8192))

  (setopt ellama-naming-provider
    (make-llm-openai
      ;; :chat-model "gpt-3.5-turbo"
      :chat-model "gpt-4o-mini"
      :key llm-openai-key
      ;; :default-chat-non-standard-params '(("num_ctx" . 8192))
      ))
      ;; :default-chat-non-standard-params '(("stop" . ("\n")))))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  )


;; ** gptel

(use-package gptel
  :config
  (setq gptel-api-key (password-store-get "llm-openai-key"))
  (setq gptel-track-media t))



;; ** langtool

(use-package langtool
  :init
  (setq langtool-language-tool-server-jar "/home/johannes/tec/langtool/LanguageTool-6.5/languagetool-server.jar")
  :bind (:map org-mode-map
	  ("C-M-." . 'langtool-goto-next-error)
	  ("C-M-," . 'langtool-goto-previous-error)
	  ("C-M-k" . 'langtool-correct-at-point)
	  ))





;; ** polymode


;; try fix for markdown issues
;; https://github.com/polymode/polymode/issues/264

;; (use-package poly-R
;;   :config
;;   (define-innermode poly-text-R-innermode
;;     :indent-offset 2
;;     :head-matcher (cons "^[ \t]*\\(```[ \t]*{?[[:alpha:]].*\n\\)" 1)
;;     :tail-matcher (cons "^[ \t]*\\(```\\)[ \t]*$" 1)
;;     :mode 'ess-r-mode
;;     :head-mode 'host
;;     :tail-mode 'host)
;;   (define-polymode poly-text-R-mode
;;     :hostmode 'pm-host/text
;;     :innermodes '(poly-text-R-innermode))
;;   )



;; ** zetteldeft
;; (use-package zetteldeft
;;   :after deft
;;   :config
;;     (zetteldeft-set-classic-keybindings))


(use-package ejc-sql)

(ejc-create-connection
  "ch@180"
  :dependencies [[com.clickhouse/clickhouse-jdbc "0.3.2"]]
  :dbtype "clickhouse"
  :classname "com.clickhouse.jdbc.ClickHouseDriver"
  :separator "/"
  :connection-uri (concat "jdbc:clickhouse://127.0.0.1:8123/" "litanai"))

(ejc-create-connection
  "pg@wrds"
  :classpath (concat "~/.m2/repository/org.postgresql/postgresql/42.6.0/"
                    "postgresql-42.6.0.jar")
 :subprotocol "postgresql"
  ;; :subname "//localhost:5432/my_db_name"
  :host "
wrds-pgdata.wharton.upenn.edu"
  :port 9737
  :sslmode "require"
  :user (password-store-get "wrds-usr")
  :dbname "wrds"
 :password (password-store-get "wrds-pwd"))



(add-hook 'ejc-sql-connected-hook
          (lambda ()
            (ejc-set-fetch-size 50)
            (ejc-set-max-rows 50)
            (ejc-set-show-too-many-rows-message t)
            (ejc-set-column-width-limit 80)
            (ejc-set-use-unicode t)))

;; don't think there's autocompletion for clickhouse
;; (require 'ejc-autocomplete)
;; (add-hook 'ejc-sql-minor-mode-hook
;;           (lambda ()
;;             (auto-complete-mode t)
;;             (ejc-ac-setup)))


;; ** dbd mode
(load-file "~/Dropbox/technical_stuff_general/dotfiles/.emacs.d/dbd-mode/dbdiagram-mode.el")


;; ** uiua

;; (use-package uiua-ts-mode
;;   :mode "\\.ua\\'"
;;   :ensure t)

;; (use-package markdown-mode
;;   :bind (:map markdown-mode-map
;; 	  ("C-#" . consult-git-grep)))





