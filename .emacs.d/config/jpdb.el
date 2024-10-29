(defun comint-nonewline-send (proc string)
  "Default function for sending to PROC input STRING.
This just sends STRING plus a newline.  To override this,
set the hook `comint-input-sender'."
  (let ((send-string (concat (py-yeet-newlines string) "\n")))
    (message send-string)
    (comint-send-string proc send-string)))
  

(defun py-send-reg (beg end blink)
  ;; send region from beg to end to py-string-sender, which sends it to comint
  (when blink
    (ess-blink-region beg end))
  (py-string-sender (buffer-substring-no-properties beg end)))

(defun py-string-sender (string)
  "Send the specified STRING to the Python process."
  (interactive "sEnter string to send: ")
  (let ((proc (get-buffer-process "*Python*")))  ;; Adjust the buffer name if different
    (message (format "%s" comint-input-filter-functions))
    (if proc
        (progn
          (with-current-buffer "*Python*"
            (insert string)
	    
	    (let (
		   ;; (comint-input-sender 'comint-simple-send))
		   (comint-input-sender 'comint-nonewline-send))
	      ;; (message (format "%s" comint-input-filter-functions))
              (comint-send-input)
	      
	      ))
          (message "Sent: %s" string))
      (message "No Python process found."))))

(defun py-send-line ()
  (interactive)
  (let (
	 ;; (beg (save-excursion (beginning-of-line) (point)))
	 (beg (save-excursion (elpy-shell--nav-beginning-of-statement) (point)))
	 (end (save-excursion (end-of-line) (point))))
    (py-send-reg beg end t)))
    


(defun py-get-statement-top-reg ()
  ;; get region for statement from top
  (let ((beg (save-excursion (elpy-shell--nav-beginning-of-statement) (point)))
	 (end (save-excursion (elpy-shell--nav-end-of-statement) (point))))
    `((beg . ,beg) (end . ,end))))


(defun py-blink-paragraph ()
  ;; see which code will be evaluated for debugging 
  (interactive)
  (let ((beg (save-excursion
	       (backward-paragraph)
	       (elpy-shell--nav-beginning-of-statement)
	       (point)))
	 (end (save-excursion (forward-paragraph) (point))))
    (message "%s-%s" beg end)
    (ess-blink-region beg end)))

(defun py-blink-statement-top ()
  (interactive)
  (let* ((reg (py-get-statement-top-reg))
    (beg (assoc-default 'beg reg))
    (end (assoc-default 'end reg)))
    (ess-blink-region beg end)))

;; (define-key elpy-mode-map (kbd "C-c b") 'py-blink-paragraph)
;; (define-key elpy-mode-map (kbd "C-c s") 'py-blink-statement-top)

(define-key elpy-mode-map (kbd "C-c g") 'py-send-group)
(define-key elpy-mode-map (kbd "C-c j") 'py-send-line)
(define-key elpy-mode-map (kbd "C-c k") 'py-summary-at-point)
	 


(defun py-send-group ()
  ;; in a group of statements, each statement has to be sent separately
    
  (interactive)
  (let ((old-point (point))
	 (group-beg (save-excursion
	       (backward-paragraph)
	       (elpy-shell--nav-beginning-of-statement)
		      (point)))
	 (group-end (save-excursion (forward-paragraph) (point)))
	 ;; temporary variables for each statement
	 (statement-reg)
	 (statement-beg)
	 (statement-end)
	 ;; (ess-blink-delay 1)
	 )

    (ess-blink-region group-beg group-end)
	 
    (save-excursion
      ;; goto beginning of paragraph
      (backward-paragraph)
      (elpy-shell--nav-beginning-of-statement)

      (while (< (point) group-end)
	;; (py-blink-statement-top) ; blink first statement
	;; (py-blink-statement-top) ; blink first statement
	;; (py-blink-statement-top) ; blink first statement
	;; (sleep-for 0.3)
	(setq statement-reg (py-get-statement-top-reg))
	(setq statement-beg (assoc-default 'beg statement-reg))
	(setq statement-end (assoc-default 'end statement-reg))
	(message "%s-%s" statement-beg statement-end)
	(py-send-reg statement-beg statement-end nil)
        (goto-char statement-end)
        (forward-char) ; go to new line
        (elpy-shell--nav-beginning-of-statement) ;; adjust for indentation
	
      ))))
	  
	

(defun py-summary-at-point ()
  (interactive)
  (let ((sym (symbol-at-point)))
    (if sym
      (py-string-sender (symbol-name sym)))))
