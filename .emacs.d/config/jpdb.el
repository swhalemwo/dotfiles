

(defun jpdb-comint-nonewline-send (proc string)
  "Default function for sending to PROC input STRING.
This just sends STRING plus a newline.  To override this,
set the hook `comint-input-sender'."
  (let ((send-string (concat string "\n\n")))
    ;; (message send-string)
    (comint-send-string proc send-string)))

(defun jpdb-send-selection ()
  (interactive)
  (if (use-region-p)
    (let ((beg (region-beginning))
	   (end (region-end)))
      (jpdb-send-reg beg end t))
    (message "No active region. ")))


(defun jpdb-send-reg (beg end blink)
  ;; send region from beg to end to jpdb-string-sender, which sends it to comint
  (when blink
    (ess-blink-region beg end))
  (jpdb-string-sender (buffer-substring-no-properties beg end)))

(defun jpdb-string-sender (string)
  "Send the specified STRING to the Python process."
  (interactive "sEnter string to send: ")
  (let ((proc (get-buffer-process "*Python*")))  ;; Adjust the buffer name if different
    (if proc
        (progn
          (with-current-buffer "*Python*"
            (insert string)
	    
	    (let (
		   ;; (comint-input-sender 'comint-simple-send))
		   (comint-input-sender 'jpdb-comint-nonewline-send))
	      (comint-send-input)
	      
	      )))
          ;; (message "Sent: %s" string))
      (message "No Python process found."))))

(defun jpdb-send-line ()
  ;; send line to debugger
  (interactive)
  (let (
	 ;; (beg (save-excursion (beginning-of-line) (point)))
	 (beg (save-excursion (elpy-shell--nav-beginning-of-statement) (point)))
	 (end (save-excursion (end-of-line) (point))))
    (jpdb-send-reg beg end t)))
    


(defun jpdb-get-statement-top-reg ()
  ;; get region for statement from top
  (let ((beg (save-excursion (elpy-shell--nav-beginning-of-statement) (point)))
	 (end (save-excursion (elpy-shell--nav-end-of-statement) (point))))
    `((beg . ,beg) (end . ,end))))


(defun jpdb-blink-paragraph ()
  ;; see which code will be evaluated for debugging 
  (interactive)
  (let ((beg (save-excursion
	       (backward-paragraph)
	       (elpy-shell--nav-beginning-of-statement)
	       (point)))
	 (end (save-excursion (forward-paragraph) (point))))
    ;; (message "%s-%s" beg end)
    (ess-blink-region beg end)))

(defun jpdb-blink-statement-top ()
  (interactive)
  (let* ((reg (jpdb-get-statement-top-reg))
    (beg (assoc-default 'beg reg))
    (end (assoc-default 'end reg)))
    (ess-blink-region beg end)))

;; (define-key elpy-mode-map (kbd "C-c b") 'jpdb-blink-paragraph)
;; (define-key elpy-mode-map (kbd "C-c s") 'jpdb-blink-statement-top)

	 
(defun jpdb-get-group-reg ()
  ;; get region for group 
  (let ((group-beg (save-excursion
		     (backward-paragraph)
		     (elpy-shell--nav-beginning-of-statement)
		     (point)))
	 (group-end (save-excursion (forward-paragraph) (point))))
    `((beg . ,group-beg) (end . ,group-end))))
	 


(defun jpdb-blink-group ()
  (interactive)
  (let* ((group-reg (jpdb-get-group-reg))
	  (beg (assoc-default 'beg group-reg))
	  (end (assoc-default 'end group-reg)))

    (ess-blink-region beg end)))
	   


(defun jpdb-send-group ()
  ;; in a group of statements, each statement has to be sent separately
    
  (interactive)
  (let* ((old-point (point))
	  (group-reg (jpdb-get-group-reg))
	  (group-beg (assoc-default 'beg group-reg))
	  (group-end (assoc-default 'end group-reg))
	  ;; temporary variables for each statement
	  (statement-reg)
	  (statement-beg)
	  (statement-end)
	 )

    (ess-blink-region group-beg group-end) ;; blink entire region
	 
    (save-excursion
      ;; goto beginning of paragraph
      (backward-paragraph)
      (elpy-shell--nav-beginning-of-statement)

      (while (< (point) group-end)
	;; (sleep-for 0.3)
	(setq statement-reg (jpdb-get-statement-top-reg))
	(setq statement-beg (assoc-default 'beg statement-reg))
	(setq statement-end (assoc-default 'end statement-reg))
	;; (message "%s-%s" statement-beg statement-end)
	(jpdb-send-reg statement-beg statement-end nil)
        (goto-char statement-end)
        (forward-char) ; go to new line
        (elpy-shell--nav-beginning-of-statement) ;; adjust for indentation
	
      ))))
	  
	

(defun jpdb-summary-at-point ()
  (interactive)
  (let ((sym (symbol-at-point)))
    (if sym
      (jpdb-string-sender (symbol-name sym)))))


;; (defun jpdb-yeet-newlines (string)
;;   ;; process multi-line statemetn into single-line statement
;;   ;; add semicolon when necessary
    
;;   ;; (let ((l-str-split (s-split "\n" string)))
;;   ;; 	 (mapconcat 'proc-split-string l-str-split ""))

;;   string
;;   ;; replace newlines
;;   ;; (replace-regexp-in-string "\n" "" string))
;;   )

;; (defun py-send-statement ()
;;   (interactive)
;;   (let* ((beg (save-excursion (elpy-shell--nav-beginning-of-statement) (point)))
;; 	 (end (save-excursion
;; 		(elpy-shell--nav-beginning-of-statement)
;; 		(elpy-shell--nav-end-of-statement) ;; assumes point is at beg -> have to move there first
;; 		(point))))
;; 	 ;; (string-no-newlines (replace-regexp-in-string "\n" "" (buffer-substring-no-properties beg end))))
    

;;     (py-string-sender (buffer-substring beg end))
;;     ;; (py-string-sender string-no-newlines)

;;     ))
