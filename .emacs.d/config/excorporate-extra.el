;; MWE for posting meeting
;; (exco-calendar-item-appointment-create
;;   (exco-select-connection-identifier)
;;   "Test meeting 1"
;;   "Hi,\n\nThis is a test meeting 1.\n\nRegards.\n"
;;   (encode-time 0 15 14 24 08 2024)
;;   (encode-time 0 0  15 24 08 2024)
;;   (lambda (identifier response)
;;     (message "%S: %S" identifier response)))


(defun hi-printer ()
  (interactive)
  (message "hi"))


(defun excorporate-create-meeting-string ()
  "generates string for an excorporte meeting"

  ;; read the time
  (let* ((time-of-date-input (read-string "time: "))
	  (time-of-date (if (equal time-of-date-input "") "12:00" time-of-date-input)))

    ;; get the date from calfw position
    (concat "* krappa \n"
      "SCHEDULED: "
      (substring (cfw:org-capture-day) 0 (1- (length (cfw:org-capture-day)))) " " time-of-date ">" )))

(defun excorporate-create-meeting ()
  (interactive)
  (org-capture nil "e"))




(defun org-timestamp-type (timestamp)
  "Determine if an org timestamp is a single timestamp or a time range."
  (let ((time-range-regex "<[0-9]+-[0-9]+-[0-9]+ \\w+ [0-9]+:[0-9]+-[0-9]+:[0-9]+>")
         (time-regex "<[0-9]+-[0-9]+-[0-9]+ \\w+ [0-9]+:[0-9]+>"))
    (cond
      ((string-match time-range-regex timestamp) 'time-range)
      ((string-match time-regex timestamp) 'single-timestamp)
      (t (error "Invalid timestamp format")))))


(defun org-split-timerange (timestamp)
  "Split an org time range timestamp into two single timestamps."
  (let ((time-range-regex "<\\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\) \\w+ \\([0-9]+\\):\\([0-9]+\\)-\\([0-9]+\\):\\([0-9]+\\)>"))
    (if (string-match time-range-regex timestamp)
      (let ((year (match-string 1 timestamp))
             (month (match-string 2 timestamp))
             (day (match-string 3 timestamp))
             (start-hour (match-string 4 timestamp))
             (start-minute (match-string 5 timestamp))
             (end-hour (match-string 6 timestamp))
             (end-minute (match-string 7 timestamp)))
        (list (format "<%s-%s-%s do %s:%s>" year month day start-hour start-minute)
          (format "<%s-%s-%s do %s:%s>" year month day end-hour end-minute)))
      (error "Invalid time range timestamp format"))))


(defun add-hour-to-time (time)
  "Add an hour to an Emacs internal time object."
  (let* ((days (car time))
          (seconds (cadr time))
          (new-seconds (+ seconds 3600)))
    (if (>= new-seconds 86400)
      (list (1+ days) (- new-seconds 86400))
      (list days new-seconds))))



(defun exco-parse-time (string-timestamp)
  "generate the time objects: alist with time-start and time-end"
  ;; (let ((time-start nil)
  ;; 	(time-end nil))
  (cond
    ;; if we have a single time-stamp, add one hour by default
    ((equal (org-timestamp-type string-timestamp) 'single-timestamp)
      `((time-start . ,(org-read-date nil t string-timestamp))
	 (time-end . ,(add-hour-to-time (org-read-date nil t string-timestamp)))))
    ;; if range is given, use that

    ((equal (org-timestamp-type string-timestamp) 'time-range)
      `((time-start . ,(org-read-date nil t (car (org-split-timerange string-timestamp))))
	 (time-end . ,(org-read-date nil t (cadr (org-split-timerange string-timestamp))))))
    
    (t (error "error in time parsing"))))



(defun exco-upload-meeting ()
  "upload the meeting online"

  (let ((time-info (exco-parse-time (cdar (org-entry-properties (point) "SCHEDULED"))))
	 (meeting-title (cdar (org-entry-properties (point) "ITEM"))))

    (exco-calendar-item-appointment-create
      (exco-select-connection-identifier)
      meeting-title
      "body text"
      (cdr (assoc 'time-start time-info))
      (cdr (assoc 'time-end time-info))
      (lambda (identifier response)
	(message "%S: %S" identifier response)))))



(defun exco-post-meeting ()
  "go to exco schedule file, and then upload meeting"

  (when (not org-note-abort)
    (save-excursion
      (save-window-excursion
        (let ((inhibit-message t))
	  (org-capture-goto-last-stored))
	(when (string= (buffer-file-name) excorporate-org-schedule-file)
	  (exco-upload-meeting))))))

(defun exco-operate-daterange (identifier date-start date-end callback)
  "Return the meetings for the specified date range."

  (exco-operate
    identifier
    "FindItem"
    `(;; Main arguments.
       (;; RequestVersion is usually overridden by a fixed value in
	 ;; the WSDL (the RequestServerVersion element); provide the
	 ;; maximally-compatible Exchange2007 if the fixed value isn't
	 ;; present.
	 (RequestVersion (Version . "Exchange2007"))
	 (Traversal . "Shallow")
	 (ItemShape
	   (BaseShape . "AllProperties"))
	 ;; To aid productivity, excorporate-calfw automatically prunes your
	 ;; meetings to a maximum of 100 per day.
	 (CalendarView (MaxEntriesReturned . "100")
	   (StartDate . ,date-start)
	   (EndDate . ,date-end))
	 (ParentFolderIds
	   (DistinguishedFolderId (Id . "calendar"))))
       ;; Empty arguments.
       ,@(cdr (exco-operation-arity-nils identifier "FindItem")))
    callback)
  )


(defun exco-get-meetings-for-year (identifier month day year callback)
  "Return the meetings for the specified day.
IDENTIFIER is the connection identifier.  MONTH, DAY and YEAR are
the meeting month, day and year.  Call CALLBACK with two
arguments, IDENTIFIER and the server's response."
  (let* (
	  (date-start (exco-format-date-time (apply #'encode-time `(0 0 0 ,day ,(- month 1) ,year))))
	  (date-end (exco-format-date-time (apply #'encode-time `(0 0 0 ,day ,month ,(+ year 1))))))
	  ;; (date-end (exco-format-date-time (apply #'encode-time `(0 0 0 ,day ,(+ month 1) ,year)))))

    (exco-operate-daterange identifier date-start date-end callback)
        
    ))

(defun exco-get-meetings-for-month (identifier month day year callback)
  "Return the meetings for the specified month."

  (let* (
	  (date-start (exco-format-date-time (apply #'encode-time `(0 0 0 ,day ,month  ,year))))
	  (date-end (exco-format-date-time (apply #'encode-time `(0 0 0 ,day ,(+ month 1) ,year)))))
	  

    (exco-operate-daterange identifier date-start date-end callback)
        
    ))




;; (exco-connection-iterate
;;   (lambda () (exco-calfw-initialize-buffer 8 7 2024))
;;   (lambda (identifier-callback)
;;     (exco-get-meetings-for-year identifier 8 7 2024 callback)) nil nil)

(defun exco-org-show-year (month day year)
  "Show meetings for the date specified by MONTH DAY YEAR."
  (exco-connection-iterate #'exco-org-initialize-buffer
    (lambda (identifier callback)
      (exco-org-insert-headline identifier
	month day year)
      (exco-get-meetings-for-year identifier
	month day year
	callback)) 
    #'exco-org-insert-meetings
    #'exco-org-finalize-buffer))

(defun exco-org-show-month (month day year)
  "Show meetings for the date specified by MONTH DAY YEAR."
  (exco-connection-iterate #'exco-org-initialize-buffer
    (lambda (identifier callback)
      (exco-org-insert-headline identifier
	month day year)
      (exco-get-meetings-for-month identifier
	month day year
	callback)) 
    #'exco-org-insert-meetings
    #'exco-org-finalize-buffer))





(defun exco-org-parse-meeting-file ()
  "see which meetings are in the org-file via org-element-map in the background; returns a list of meetings
  with the following structure: (Identifier, Subject)"
  (let ((meetings nil))
    
    ;; org-element-map over excorporate-org-schedule-file and get the meetings
    (with-current-buffer (find-file-noselect excorporate-org-schedule-file)
      
      (org-element-map (org-element-parse-buffer) 'headline
	(lambda (headline)
	  ;; check if the headline has a "Identifier" property
	  (let* ((identifier (org-element-property :IDENTIFIER headline))
		  (subject (org-element-property :raw-value headline))
		  (scheduled (cdar (org-entry-properties headline "SCHEDULED")))
		  (location (org-element-property :LOCATION headline))
		  (org-id (org-element-property :ID headline))
		  (hash-exco-org (secure-hash 'sha256 (format "%s%s%s%s" identifier subject scheduled location))))

	    
	      (push `(,identifier . 
			((subject . ,subject)
			  (location . ,location)
			  (org-id . ,org-id)
			  (hash-exco-org . ,hash-exco-org)))
		meetings))))
      meetings)))

;; (exco-org-parse-meeting-file)

(defun exco-org-dispatch-meeting-at-point (existing-meetings ids-existing-meetings)
  "handle with meeting at point: copy if new, update if existing"
  (let* ((identifier (org-entry-get (point) "IDENTIFIER"))
	  (subject (org-entry-get (point) "ITEM"))
	  (scheduled (org-entry-get (point) "SCHEDULED"))
	  (location (org-entry-get (point) "LOCATION"))
	  (hash-exco (secure-hash 'sha256 (format "%s%s%s%s" identifier subject scheduled location)))
	  (hash-exco-org (assoc-default 'hash-exco-org (assoc identifier existing-meetings)))
	  )

    ;; handle them on different cases
    ;; if not there at all: copy them over
    (cond
      ((not (member identifier ids-existing-meetings)) (exco-org-refile-new-meeting))
      ;; if already there, but changed: update them 
      ((and (member identifier ids-existing-meetings)
	 (not (equal hash-exco hash-exco-org)))
	(exco-org-update-changed-meeting))

      )))


(defun exco-org-dispatch-meetings ()
  "refile new meetings (meetings which are not yet in the
  excorporate-org-schedule-file) to the
  excorporate-org-schedule-file"

  (let* ((existing-meetings (exco-org-parse-meeting-file))
	  (ids-existing-meetings (alist-keys existing-meetings))
	  ;; (mapcar (lambda (meeting) (assoc-default 'identifier meeting)) existing-meetings))
	  )

    (with-current-buffer "*Excorporate*"
      ;; set point to beginning
      (goto-char (point-min))
      ;; go to first top-level headline, then to first child (first real meeting)
      (org-next-visible-heading 2)

      ;; iterate over all meetings
      (while (not (eobp))

	(exco-org-dispatch-meeting-at-point existing-meetings ids-existing-meetings)

	;; go to next meeting
	(org-next-visible-heading 1))))
  
  ;; remove the advice for dispatch after finalize
  ;; it removes itself in a way
  ;; necessary to do it here because if i run it in exco-update it seems the advice is removed before running
  ;; because the excorporate code is async
  ;; so I first run the dispatch, and then remove the advice
  (advice-remove 'exco-org-finalize-buffer 'exco-org-dispatch-meetings)

  )


(defun exco-org-refile-new-meeting ()
  "new meetings: copy them, assign an org-id to them"
  
  (org-copy-subtree)
  (with-current-buffer (find-file-noselect excorporate-org-schedule-file)
    (goto-char (point-max))
    (org-paste-subtree)
    (org-id-get-create)))
    


(defun exco-org-update-changed-meeting ()
  "update a meeting that has changed on the server"
  
  ;; go to the meeting in the excorporate-org-schedule-file via the identifier
  (with-current-buffer (find-file-noselect excorporate-org-schedule-file)

    ;; (message "hi")
    ;; (message "there")
    ;; need org-ids
    
    (org-schedule nil scheduled) ;; set new schedule
    (org-set-property "LOCATION" location) ;; set new location
    (org-edit-headline subject)  ;; set new subject
  
  ))



(defun my/exco-org-insert-meeting-advice (orig-fun &rest args)
  "Insert a scheduled meeting, with location in org-property drawer"

  ;; insert the meeting normally 
  (apply orig-fun args)

  ;; get meeting value (4th argument) if it exists
  (let ((location (if (> (length args) 3)
		    (nth 3 args) nil)))
    
    ;; now set location also as property in drawer
    (when location
      (org-set-property "LOCATION" location))))

(defun my/exco-lowercase-state (orig-fun &rest args)
  "lowercase the state of the meeting"
  ;; get the original point
  (let ((cur-point (point)))

    ;; go to the beginning of the headline
    (org-back-to-heading)

    ;; lowercase it
    (downcase-word 1)

    ;; set point back to where it was
    (goto-char cur-point)))



(advice-add 'exco-org-insert-meeting :around #'my/exco-org-insert-meeting-advice)
;; (advice-remove 'exco-org-insert-meeting  #'my/exco-org-insert-meeting-advice)

(advice-add 'exco-org-insert-meeting-headline :after #'my/exco-lowercase-state)
;; (advice-remove 'exco-org-insert-meeting-heading #'my/exco-lowercase-state)


;; (exco-org-show-year 8 7 2024)
;; (exco-org-show-month 9 1 2024)
;; (exco-org-dispatch-meetings)

(defun exco-update ()
  (interactive)

  ;; get current year
  (let* ((current-date (decode-time (current-time)))
	  (current-year (nth 5 current-date))
	  (current-month (nth 4 current-date))
	  (current-day (nth 3 current-date))
	  )

    ;; (exco-org-show-year current-month current-day current-year)

    ;; use advice to run dispatch after finalize because the iterate queries are (somewhat) async 
    (advice-add 'exco-org-finalize-buffer :after 'exco-org-dispatch-meetings)
    
    (exco-org-show-month current-month current-day current-year)

    ;; remove the advice in case somebody doesn't want to use dispatch
    ;; this is super spaghetti-cody, super hard to backtrace.. 
    ;; (advice-remove 'exco-org-finalize-buffer 'exco-org-dispatch-meetings)


    ))

(add-hook 'org-capture-after-finalize-hook 'exco-post-meeting)
