
(defun exco-org--create-meeting-string ()
  "generates string for an excorporte meeting"

  ;; read the time
  (let* ((time-of-date-input (read-string "time: "))
	  (time-of-date (if (equal time-of-date-input "") "12:00" time-of-date-input)))

    ;; get the date from calfw position
    (concat "* todo \n"
      "SCHEDULED: "
      (substring (cfw:org-capture-day) 0 (1- (length (cfw:org-capture-day)))) " " time-of-date ">\n" 
      ":PROPERTIES:\n"
      ":LOCATION: TBA\n"  ;; set some filler location property
      ":END:\n")))

(defun exco-org-create-meeting ()
  (interactive)
  (org-capture nil "e"))




(defun exco-org--timestamp-type (timestamp)
  "Determine if an org timestamp is a single timestamp or a time range."
  (let ((time-range-regex "<[0-9]+-[0-9]+-[0-9]+ \\w+ [0-9]+:[0-9]+-[0-9]+:[0-9]+>")
         (time-regex "<[0-9]+-[0-9]+-[0-9]+ \\w+ [0-9]+:[0-9]+>"))
    (cond
      ((string-match time-range-regex timestamp) 'time-range)
      ((string-match time-regex timestamp) 'single-timestamp)
      (t (error "Invalid timestamp format")))))


(defun exco-org--split-timerange (timestamp)
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


(defun exco-org--add-hour-to-time (time)
  "Add an hour to an Emacs internal time object."
  (let* ((days (car time))
          (seconds (cadr time))
          (new-seconds (+ seconds 3600)))
    (if (>= new-seconds 86400)
      (list (1+ days) (- new-seconds 86400))
      (list days new-seconds))))



(defun exco-org--parse-time (string-timestamp)
  "generate the time objects: alist with time-start and time-end"
  ;; (let ((time-start nil)
  ;; 	(time-end nil))
  (cond
    ;; if we have a single time-stamp, add one hour by default
    ((equal (exco-org--timestamp-type string-timestamp) 'single-timestamp)
      `((time-start . ,(org-read-date nil t string-timestamp))
	 (time-end . ,(exco-org--add-hour-to-time (org-read-date nil t string-timestamp)))))
    ;; if range is given, use that

    ((equal (exco-org--timestamp-type string-timestamp) 'time-range)
      `((time-start . ,(org-read-date nil t (car (exco-org--split-timerange string-timestamp))))
	 (time-end . ,(org-read-date nil t (cadr (exco-org--split-timerange string-timestamp))))))
    
    (t (error "error in time parsing"))))



(defun exco-org--upload-meeting ()
  "upload the meeting online"

  (let ((time-info (exco-org--parse-time (cdar (org-entry-properties (point) "SCHEDULED"))))
	 (meeting-title (cdar (org-entry-properties (point) "ITEM")))
	 (location (org-entry-properties (point) "LOCATION")))

    ;; (exco-calendar-item-appointment-create
    ;;   (exco-select-connection-identifier)
    ;;   meeting-title
    ;;   "body text"
    ;; (cdr (assoc 'time-start time-info))
    ;; (cdr (assoc 'time-end time-info))
    ;;   (lambda (identifier response)
    ;; 	(exco-org--add-identifiers-to-meeting-property response)
    ;;
    
    (exco-calendar-item-meeting-create
      (exco-select-connection-identifier)
      meeting-title
      "body text"
      (cdr (assoc 'time-start time-info))
      (cdr (assoc 'time-end time-info))
      (cdar location)
      nil ;; no invitees
      nil ;; no optional invitees
      (lambda (identifier response)
	(exco-org--add-identifiers-to-meeting-property response)))
    
    )
  )



(defun exco-org--add-identifiers-to-meeting-property (exco-upload-response)
  ;; navigate response down and add MEETINGID and ChangeKey to org-headline
  
  (let* (
	  ;; extracting from already extracted response kills the reponse object
	  ;; -> need to construct multiple mimepaths
	  (mimepath-identifier-to-property '(ResponseMessages CreateItemResponseMessage Items CalendarItem))
	  (mimepath-identifier-cons (append mimepath-identifier-to-property '(ItemId)))
	  ;; then extract: one for easy access of fields, one for easy access as identifier
	  (item-identifier-to-property (car
					 (exco-extract-value mimepath-identifier-to-property exco-upload-response)))
	  (item-identifier-cons (exco-extract-value mimepath-identifier-cons exco-upload-response)))
    
    
    ;; go to schedule buffer
    (with-current-buffer (find-file-noselect excorporate-org-schedule-file)
      (goto-char (point-max)) ;; go to end (this is where capture should place the meeting)
      
      
      (org-set-property "MEETINGID" (assoc-default 'Id item-identifier-cons))
      (org-set-property "ChangeKey" (assoc-default 'ChangeKey item-identifier-cons))
      (org-set-property "Identifier" (format "%S" item-identifier-to-property))


      (setq exco-org--buffer-meetings-uid (find-file-noselect excorporate-org-schedule-file))
      (exco-org--add-uid)
      )))





(defun exco-org--post-meeting ()
  "go to exco schedule file, and then upload meeting"

  (when (not org-note-abort)
    (save-excursion
      (save-window-excursion
        (let ((inhibit-message t))
	  (org-capture-goto-last-stored))
	(when (string= (buffer-file-name) excorporate-org-schedule-file)
	  (exco-org--upload-meeting))))))

(defun exco-org--operate-daterange (identifier date-start date-end callback)
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
	 (CalendarView (MaxEntriesReturned . "300")
	   (StartDate . ,date-start)
	   (EndDate . ,date-end))
	 (ParentFolderIds
	   (DistinguishedFolderId (Id . "calendar"))))
       ;; Empty arguments.
       ,@(cdr (exco-operation-arity-nils identifier "FindItem")))
    callback)
  )


(defun exco-org--get-meetings-for-year (identifier month day year callback)
  "Return the meetings for the specified day.
IDENTIFIER is the connection identifier.  MONTH, DAY and YEAR are
the meeting month, day and year.  Call CALLBACK with two
arguments, IDENTIFIER and the server's response."
  (let* (
	  (date-start (exco-format-date-time (apply #'encode-time `(0 0 0 ,day ,(- month 1) ,year))))
	  (date-end (exco-format-date-time (apply #'encode-time `(0 0 0 ,day ,month ,(+ year 1))))))
    ;; (date-end (exco-format-date-time (apply #'encode-time `(0 0 0 ,day ,(+ month 1) ,year)))))

    (exco-org--operate-daterange identifier date-start date-end callback)
    
    ))

(defun exco-org--get-meetings-for-month (identifier month day year callback)
  "Return the meetings for the specified month."

  (let* (
	  (date-start (exco-format-date-time (apply #'encode-time `(0 0 0 ,day ,month  ,year))))
	  (date-end (exco-format-date-time (apply #'encode-time `(0 0 0 ,day ,(+ month 1) ,year)))))
    

    (exco-org--operate-daterange identifier date-start date-end callback)
    
    ))




;; (exco-connection-iterate
;;   (lambda () (exco-calfw-initialize-buffer 8 7 2024))
;;   (lambda (identifier-callback)
;;     (exco-org--get-meetings-for-year identifier 8 7 2024 callback)) nil nil)

(defun exco-org--show-year (month day year)
  "Show meetings for the date specified by MONTH DAY YEAR."
  (exco-connection-iterate #'exco-org-initialize-buffer
    (lambda (identifier callback)
      (exco-org-insert-headline identifier
	month day year)
      (exco-org--get-meetings-for-year identifier
	month day year
	callback)) 
    #'exco-org-insert-meetings-and-finalize
    #'exco-org-finalize-buffer ;; this isn't really used, but just keep it here anyways
    t))



(defun exco-org--show-month (month day year)
  "Show meetings for the date specified by MONTH DAY YEAR."
  (exco-connection-iterate #'exco-org-initialize-buffer
    (lambda (identifier callback)
      (exco-org-insert-headline identifier
	month day year)
      (exco-org--get-meetings-for-month identifier
	month day year
	callback)) 
    #'exco-org-insert-meetings-and-finalize
    #'exco-org-finalize-buffer ;; this isn't really used, but just keep it here anyways
    t))


(defvar exco-org--timer-uid-checker nil
  "Timer for waiting asynchronously for UID additions to finish.")

(defvar exco-org--buffer-meetings-uid nil
  "buffer to write the UID to")

(defun exco-org--check-uid-progress (counter-start)
  "Check if all UIDs have been added asyncly. if they have, call `exco-org-finalize-buffer`."

  
  (if (= counter-start exco-org--counter-finished)
    (progn
      (message "All UIDs added -> finalize.")
      ;; Stop the timer
      (when exco-org--timer-uid-checker
        (cancel-timer exco-org--timer-uid-checker))
      (exco-org-finalize-buffer)
      )
    (message (format "%s/%s have finished -> Still waiting." exco-org--counter-finished counter-start))))



(defun exco-org-insert-meetings-and-finalize (identifier response callback)
  "insert meetings, then add UIDs, and call finalize once all meetings are added."

  (exco-org-insert-meetings identifier response) ;; main meetings

  (let ((counter-start 0))

    ;; start the setting of the UIDs
    (with-current-buffer (exco-org--identifier-buffer identifier)
      
      (goto-char (point-min))
      (org-mode)
      (org-next-visible-heading 1) ;; go to first real meeting
      
      (setq exco-org--counter-finished 0)
      (setq exco-org--buffer-meetings-uid (exco-org--identifier-buffer identifier))

      (while (not (eobp))

	(message (format "finalize loop point: %s" (point)))
	(exco-org--add-uid)
	
	(org-next-visible-heading 1) 	;; go to next meeting
	(setq counter-start (+ counter-start 1)))
      
      
      ;; Start the timer to check every 0.1 seconds
      (setq exco-org--timer-uid-checker (run-at-time 0.1 0.1 'exco-org--check-uid-progress counter-start))
      )
    )
  )


(defun exco-org--parse-buffer ()
  "general workhorse for parsing any buffer"
  (let ((meetings nil))
    
    (org-element-map (org-element-parse-buffer) 'headline
      (lambda (headline)
	
	;; extract basic information from org entry
	(let* (
		(UID (org-element-property :UID headline))
		(ChangeKey (org-element-property :CHANGEKEY headline))
		(subject (org-element-property :raw-value headline))
		(scheduled (cdar (org-entry-properties headline "SCHEDULED")))
		(location (org-element-property :LOCATION headline))
		(org-id (org-element-property :ID headline))
		(hash-exco-org (secure-hash 'sha256 (format "%s%s%s%s" UID subject scheduled location))))

	  
	  (push `(,UID . 
		   ((subject . ,subject)
		     (location . ,location)
		     (org-id . ,org-id)
		     (ChangeKey . ,ChangeKey)
		     (scheduled . ,scheduled)
		     (hash-exco-org . ,hash-exco-org)))
	    meetings))))
    meetings))



(defun exco-org--parse-excorporate-buffer ()

  (with-current-buffer "*Excorporate*"
    (exco-org--parse-buffer)))





(defun exco-org--parse-meeting-file ()
  "see which meetings are in the org-file via org-element-map in the background; returns a list of meetings
  with the following structure: (Identifier, Subject)"
  
  ;; org-element-map over excorporate-org-schedule-file and get the meetings
  (with-current-buffer (find-file-noselect excorporate-org-schedule-file)

    (exco-org--parse-buffer)))



;; (exco-org--parse-meeting-file)

(defun exco-org--dispatch-meeting-at-point (existing-meetings ids-existing-meetings)
  "handle with meeting at point: copy if new, update if existing"
  (let* ((UID (org-entry-get (point) "UID"))
	  (subject (org-entry-get (point) "ITEM"))
	  (scheduled (org-entry-get (point) "SCHEDULED"))
	  (location (org-entry-get (point) "LOCATION"))
	  (hash-exco (secure-hash 'sha256 (format "%s%s%s%s" UID subject scheduled location)))
	  (hash-exco-org (assoc-default 'hash-exco-org (assoc UID existing-meetings)))
	  )

    ;; handle them on different cases
    ;; if not there at all: copy them over
    (cond
      ((not (member UID ids-existing-meetings)) (exco-org--refile-new-meeting))
      ;; if already there, but changed: update them 
      ((and (member UID ids-existing-meetings)
	 (not (equal hash-exco hash-exco-org)))
	(exco-org--update-changed-org-meeting subject scheduled location))

      )))


(defun exco-org--dispatch-meetings ()
  "refile new meetings (meetings which are not yet in the
  excorporate-org-schedule-file) to the
  excorporate-org-schedule-file"

  (let* ((existing-meetings (exco-org--parse-meeting-file))
	  (ids-existing-meetings (alist-keys existing-meetings)))

    (with-current-buffer "*Excorporate*"
      ;; set point to beginning
      (goto-char (point-min))
      ;; go to first top-level headline, then to first child (first real meeting)
      (org-next-visible-heading 2)

      ;; iterate over all meetings
      (while (not (eobp))

	(exco-org--dispatch-meeting-at-point existing-meetings ids-existing-meetings)

	;; go to next meeting
	(org-next-visible-heading 1))))
  
  ;; delete from org files meetings that don't exist on server  
  (exco-org--delete-deleted-meetings-from-org exco-org--date-start exco-org--date-end)

  ;; remove the advice for dispatch after finalize
  ;; it removes itself in a way
  ;; necessary to do it here because if i run it in exco-update it seems the advice is removed before running
  ;; because the excorporate code is semi-async
  ;; so I first run the dispatch, and then remove the advice
  (advice-remove 'exco-org-finalize-buffer 'exco-org--dispatch-meetings)

  
  
  )


(defun exco-org--refile-new-meeting ()
  "new meetings: copy them, assign an org-id to them"
  
  (org-copy-subtree)
  (with-current-buffer (find-file-noselect excorporate-org-schedule-file)
    (goto-char (point-max))
    (org-paste-subtree)
    (org-id-get-create)
    
    ))



(defun exco-org--update-changed-org-meeting (subject scheduled location)
  "update a meeting that has changed on the server"
  
  ;; go to the meeting in the excorporate-org-schedule-file via the identifier
  (with-current-buffer (find-file-noselect excorporate-org-schedule-file)

    (org-schedule nil scheduled) ;; set new schedule
    (org-set-property "LOCATION" location) ;; set new location
    (org-edit-headline subject)  ;; set new subject
    
    ))


(defun exco-org--insert-meeting-advice (orig-fun &rest args)
  "Insert a scheduled meeting, with MEETINGID, ChangeKey and location in org-property drawer"

  ;; insert the meeting normally 
  (apply orig-fun args)
  ;; (message (buffer-name))

  ;; (goto-char (point-max)) ;; go to end of buffer before editing things? 

  ;; now to the post-processing
  ;; get meeting value (4th argument) if it exists
  (let (
	 (id-alist (read (org-entry-get (point) "Identifier")))
	 (location (if (> (length args) 3) (nth 3 args) nil)))

    ;; (message (format "meeting buffer: %s" (buffer-name)))

    ;; (org-mode)
    
    ;; (org-id-get-create)

    ;; set meeting Id and changekey as org-properties
    (org-set-property "MEETINGID" (assoc-default 'Id (cdr id-alist)))
    (org-set-property "ChangeKey" (assoc-default 'ChangeKey (cdr id-alist)))

    ;; now set location also as property in drawer
    (when location
      (org-set-property "LOCATION" location))))



(defun exco-org--lowercase-state (orig-fun &rest args)
  "lowercase the state of the meeting since I use lowercase todo state"
  ;; get the original point
  (let ((cur-point (point)))

    ;; go to the beginning of the headline
    (org-back-to-heading)

    ;; lowercase it
    (downcase-word 1)

    ;; set point back to where it was
    (goto-char cur-point)))



(advice-add 'exco-org-insert-meeting :around #'exco-org--insert-meeting-advice)
;; (advice-remove 'exco-org-insert-meeting  #'exco-org--insert-meeting-advice)

(advice-add 'exco-org-insert-meeting-headline :after #'exco-org--lowercase-state)
;; (advice-remove 'exco-org-insert-meeting-heading #'exco-org--lowercase-state)



;; (exco-org--show-year 8 7 2024)
;; (exco-org--show-month 9 1 2024)
;; (exco-org--dispatch-meetings)

(defun exco-org--value-between-p (value min max) 
  (and (> value min) (< value max)))


(defun exco-org--delete-deleted-meetings-from-org (date-start date-end)
  "delete meetings that are not on exco (i.e. server) anymore,
i.e. have been deleted

date-start: absolute day number
date-end: absolute day number"  
  (let* ((parsed-meetings-file (exco-org--parse-meeting-file))
	  (parsed-exco-meetings (alist-keys (exco-org--parse-excorporate-buffer)))
	  ;; filter only those that are in date range and not in exco
	  (meetings-to-delete
	    (mapcan (lambda (meeting)
		      (and ;; mapcan requirement
			(and
			  ;; not in time range
			  (exco-org--value-between-p
			    (org-time-string-to-absolute (assoc-default 'scheduled meeting))
			    date-start date-end)
			  ;; not in exco buffer
			  (not (member (car meeting) parsed-exco-meetings)))
			(list meeting)))
	      parsed-meetings-file)))

    ;; ;; filter only those that are not in exco
    ;; (meetings-to-delete
    ;;   (mapcan (lambda (meeting)
    ;; 	      (and
    ;; 		(not (member (car meeting) parsed-exco-meetings))
    ;; 		(list meeting)))
    ;;     filtered-file-meetings)))

    ;; delete them 
    (with-current-buffer (find-file-noselect excorporate-org-schedule-file)
      (mapcar (lambda (meeting)
		(progn 
		  (goto-char (cdr (org-id-find (assoc-default 'org-id (cdr meeting)))))
		  (org-cut-subtree)
		  (save-buffer)
		  ))
	meetings-to-delete))

    (message (format "deleted %s meetings" (length meetings-to-delete)))))



(defun exco-org--extract-uid-from-string (str)
  "Extract the UID from the given iCalendar string STR using string parsing."
  (let ((uid nil))
    (when (string-match "UID:\\s-*\\(.*?\\)\\(?:\\n\\|$\\)" str)
      (setq uid (match-string 1 str))
      ;; Clean up the UID string by removing whitespace
      (setq uid (replace-regexp-in-string "[[:space:]]+" "" uid)))
    uid))


(defun exco-org--get-uid (str)
  "get the UID from a ical entry"
  
  (with-temp-buffer

    (insert str)
    (goto-char (point-min))
    
    ;; manual unfolding of ics fields
    (while (re-search-forward "\r?\n[ \t]" nil t)
      (replace-match "" nil nil))
    ;; (goto-char (point-max))
    
    (exco-org--extract-uid-from-string (buffer-string))))

;; (exco-org--get-uid xx)


(defun exco-org--set-uid-property (identifier meeting-id uid)
  "go to entry which has meeting-id, and set the ical uid property"

  ;; (with-current-buffer (exco-org--identifier-buffer identifier)
  (with-current-buffer exco-org--buffer-meetings-uid
    
    (message (format "uid buffer: %s" (buffer-name)))
    (message (format "uid cur-point: %s" (point)))
    (message (format "uid max-point: %s" (point-max)))
    (message (format "uid: %s" uid))

    ;; (view-buffer-other-window (exco-org--identifier-buffer identifier)) ;; for debug

    (goto-char (point-min))
    
    (goto-char (search-forward meeting-id))
    (message (format "uid pos after move: %s" (point)))


    (org-set-property "UID" uid)

    (org-delete-property "MEETINGID")
    (org-delete-property "ChangeKey")
    (org-delete-property "Identifier")

    (setq exco-org--counter-finished (+ exco-org--counter-finished 1))

    )
  )




(defun exco-org--add-uid ()
  "add ical uid to entry at point"
  (interactive)
  (let ((item-identifier (read (org-entry-get (point) "Identifier")))
	 (con-identifier (car exco--connection-identifiers)))
    ;; (message (format "%s" identifier)))
    
    (exco-operate con-identifier
      "GetItem"
      `(((ItemShape
	   (BaseShape . "IdOnly")
	   (IncludeMimeContent . t))
	  (ItemIds ,item-identifier))
	 nil nil nil nil nil nil)
      'exco-org--callback-uid )))


(defun exco-org--callback-uid (_identifier response)
  ;; response is some encoded stuff, this seems all necessary to decode ?
  (let* ((mime-path '(ResponseMessages
		       GetItemResponseMessage
		       Items
		       CalendarItem
		       MimeContent))
	  (character-set-path (append mime-path '(CharacterSet)))
	  (coding-system (intern (downcase (exco-extract-value
					     character-set-path
					     response)))))
    ;; (message "mime-path: %s" mime-path) 
    (unless (member coding-system coding-system-list)
      (error "Unrecognized coding system: %s"
	(exco-extract-value character-set-path response)))
    ;; (funcall process-item
    ;; (printer
    (exco-org--set-uid-property
      _identifier
      (exco-extract-value '(ResponseMessages GetItemResponseMessage Items CalendarItem ItemId Id) response)
      (exco-org--get-uid
	(decode-coding-string
	  (base64-decode-string
	    (cdr (exco-extract-value
		   mime-path response)))
	  coding-system)))))





(defun exco-org-sync ()
  
  ;; remove the advice in case somebody doesn't want to use dispatch
  ;; this is super spaghetti-cody, super hard to backtrace.. 
  ;; (advice-remove 'exco-org-finalize-buffer 'exco-org--dispatch-meetings)

  (interactive)

  ;; get current year
  (let* ((current-date (decode-time (current-time)))
	  (current-year (nth 5 current-date))
	  (current-month (nth 4 current-date))
	  (current-day (nth 3 current-date))
	  (exco-dispatch (if (equal (read-string "dispatch to file? ") "j") t nil)))

    ;; use advice to run dispatch after finalize because the iterate queries are (somewhat) async
    
    

    
    (when exco-dispatch 
      (advice-add 'exco-org-finalize-buffer :after 'exco-org--dispatch-meetings))
    
    ;; if C-u: only do for month for quick testing
    (if current-prefix-arg

      (progn
	;; set date range for checking schedule file for meetings which were deleted on server to delete
	;; have to cleaning dates globally since cleaning runs semi-async via advice
	(setq exco-org--date-start (time-to-days (current-time)))
	(setq exco-org--date-end
	  (time-to-days (apply #'encode-time `(0 0 0 ,current-day ,(+ current-month 1) ,current-year))))
	
	(exco-org--show-month current-month current-day current-year))
      (progn
	(setq exco-org--date-start
	  (time-to-days (apply #'encode-time `(0 0 0 ,current-day ,(- current-month 1) ,current-year))))
	(setq exco-org--date-end
	  (time-to-days (apply #'encode-time `(0 0 0 ,current-day ,current-month ,(+ current-year 1)))))
	
	(exco-org--show-year current-month current-day current-year)))
    ))




;; add hook to add ItemId to freshly posted meetings
(add-hook 'org-capture-after-finalize-hook 'exco-org--post-meeting)

