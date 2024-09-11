;; autoclocking based on 
;; https://emacs.stackexchange.com/questions/12369/automatic-clocking-in-org-mode-when-moving-into-section

(defun in-same-heading-as-clock-p ()
  "Check if the cursor is in the same heading as the current clock.
That means:
1. There is a current clock
2. The cursor is in the same buffer as that clock.
3. The cursor is in the same heading as that clock."
  (let ((cb (current-buffer))
	 (clockb (marker-buffer org-clock-marker))
	 clock-hb
	 cursor-hb)

    (when (and
	    clockb             ; clock buffer
	    ;; clock buffer is the same as this buffer
	    (eq cb clockb))
      (setq clock-hb (save-excursion
		       (goto-char (marker-position org-clock-marker))
		       (org-back-to-heading t)
		       (point))
        cursor-hb (save-excursion
		    (org-back-to-heading t)
		    (point)))
      (= cursor-hb clock-hb))))

(defun autoclocker ()

  ;; (message "it's clocking time")
  
  (cond
    ;; clock is running in this heading, do nothing
    ((in-same-heading-as-clock-p)
      nil)

    ;; ;; clock is running in another heading. IF this heading has autoclock
    ;; ((and (marker-buffer org-clock-marker)
    ;;    (not (in-same-heading-as-clock-p)))
    ;;   ;; first clock out
    ;;   (org-clock-out)
    ;;   (when (org-entry-get (point) "AUTOCLOCK")
    ;; 	(org-clock-in)))



    ((and
       ;; (marker-buffer org-clock-marker)
       (not (in-same-heading-as-clock-p))
       (org-entry-get (point) "AUTOCLOCK" t))
      (org-clock-in))
       

    ;; no clock is running, and 
    ((and (null (marker-buffer org-clock-marker))
       (org-entry-get (point) "AUTOCLOCK" t))
      (org-clock-in))))

(defun autoclocker-start ()
  "start autoclocking"
  (interactive)
  (add-hook 'post-command-hook 'autoclocker)
  )

(defun autoclocker-stop ()
  (interactive)
  (remove-hook 'post-command-hook 'autoclocker)
  )




