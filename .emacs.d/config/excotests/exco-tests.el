(my/exco-org-insert-meeting-headline-advice 'exco-org-insert-meeting-headline "jj"
  (current-time) (current-time)
  "(ItemId (Id . \"AAAWAGouYWVuZ2VuaGV5c3RlckB1dmEubmwARgAAAAAArimMe7pMzUqvUQ37mpRH5wcABiMBUm85r0Cl732oEQ7e5wAAAAABDQAAyHp62n+SaESahiQgaf09owADRqtlYgAA\") (ChangeKey . \"DwAAABYAAADIenraf5JoRJqGJCBp/T2jAANOuy0y\"))")


(exco-org-show-year 8 13 2024)

;; advice exco-org-insert-meeting-headline to add location to property drawer of retrieved meeting


I wanna use advice: I want to advice test-adder with test-adder advised, so that test-adder-advised is called in place of test-adder. test-adder advised is supposed to use more arguments. 


(defun caller ()
  (let ((a 2)
	 (b 4))
    (test-adder a)))

    
(defun test-adder (a)
  (+ a 10))

(defun test-adder-advised (orig-fun a &optional b)
  (let ((res-a (funcall orig-fun a)))
    (if b
      (+ res-a b)
      res-a)))


(advice-add 'test-adder :around #'test-adder-advised)

(advice-remove 'test-adder 'advice-wrapper)

(caller)

This produces the following error message:

Debugger entered--Lisp error: (wrong-number-of-arguments (lambda (orig-fun a b) (let ((res-a (funcall orig-fun a))) (+ res-a b))) 2)
  test-adder-advised(#f(advice advice-wrapper :around (lambda (a) (+ a 10))) 2)
  apply(test-adder-advised #f(advice advice-wrapper :around (lambda (a) (+ a 10))) 2)
  test-adder(2)
  (let ((a 2) (b 4)) (test-adder a))
  caller()
  eval((caller) nil)
  elisp--eval-last-sexp(nil)
  eval-last-sexp(nil)
  funcall-interactively(eval-last-sexp nil)
  call-interactively(eval-last-sexp nil nil)
  command-execute(eval-last-sexp)

;; (test-adder-advised 'test-adder 2 4)
;; (advice-remove 'test-adder 'test-adder-advised)





;; (exco-org-refile-new-meetings)

;; ;; copy the headline at point to the end of the excorporate-org-schedule-file
;; (with-current-buffer (find-file-noselect excorporate-org-schedule-file)
;;   (goto-char (point-max))
;; 	(insert (org-copy-subtree))
;; 	(save-buffer)
;;   )

;; (org-refile-copy nil nil (list "hello" excorporate-org-schedule-file nil 1992) nil)



(secure-hash 'sha256 (format (format "%s%s%s%s"
			       identifier
			       subject
			       scheduled
			       location)))

(secure-hash 'sha256 (format (format "%s%s%s%s"
			       identifier
			       (assoc-default 'subject (assoc identifier existing-meetings))
			       "<2024-07-11 do 13:00-13:30>"
			       ;; (assoc-default 'scheduled (assoc identifier existing-meetings))
			       ;; scheduled
			       ;; location
			       (assoc-default 'location (assoc identifier existing-meetings))
			       )))














;; MWE for posting meeting
;; (exco-calendar-item-appointment-create
;;   (exco-select-connection-identifier)
;;   "Test meeting 1"
;;   "Hi,\n\nThis is a test meeting 1.\n\nRegards.\n"
;;   (encode-time 0 15 14 24 08 2024)
;;   (encode-time 0 0  15 24 08 2024)
;;   (lambda (identifier response)
;;     (message "%S: %S" identifier response)))



;;
(exco-calendar-item-meeting-create
  (exco-select-connection-identifier)
  "lalala"
  "body text"
  (encode-time 0 15 14 29 09 2024)
  (encode-time 0 30 14 29 09 2024)
  "TBA"
  nil
  nil
  (lambda (identifier response)
     (message "%S: %S" identifier response)))
  

(defun scope-test2 ()
  (message arg1))



(defun scope-test1 ()
  (let ((arg1 "jjj"))
    (scope-test2)))

(scope-test1)


(exco-org--delete-deleted-meetings-from-org
	  (org-time-string-to-absolute "<2024-09-28 za>")
	  (org-time-string-to-absolute "<2024-10-28 za>")
	  )

;; ** checking key consistency

;; do it in R: so much easier than elisp


(defun exco-org--meeting-to-csv (alist-meetings output-file)

  (with-temp-file (concat EXCO-TEST-DIR output-file)
    (insert "meeting_id,ChangeKey,subject,location,org_id,scheduled,hash_exco_org\n")
    (dolist (entry alist-meetings)
      ;; (debug)
      (insert (format "%s,%s,%s,%s,%s,%s,%s\n"
		(car entry)
		(cdr (assoc 'ChangeKey entry))
                (replace-regexp-in-string "," "" (cdr (assoc 'subject entry)))
		(if (eq (cdr (assoc 'location entry)) nil) "no location" 
                  (replace-regexp-in-string "," "" (cdr (assoc 'location entry))))
                (cdr (assoc 'org-id entry))
                (cdr (assoc 'scheduled entry))
		(cdr (assoc 'hash-exco-org entry)))))))

(setq EXCO-TEST-DIR "~/Dropbox/technical_stuff_general/dotfiles/.emacs.d/config/excotests/")

(exco-org--meeting-to-csv (exco-org--parse-meeting-file) "meetingfile.csv")
(exco-org--meeting-to-csv (exco-org--parse-excorporate-buffer) "exco-buffer.csv")

(exco-org--meeting-to-csv (with-current-buffer "excorporate_buffer_oct2.org" (exco-org--parse-buffer))
  "exco-buffer-oct2.csv")

(exco-org--meeting-to-csv (with-current-buffer "excorporate_buffer_oct5.org" (exco-org--parse-buffer))
  "exco-buffer-oct5.csv")
  

(apply #'encode-time `(0 0 0 ,7 ,10 ,2024))


(exco-connection-iterate
  #'exco-org-initialize-buffer
    (lambda (identifier callback)

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
	       ;; (StartDate . (apply #'encode-time `(0 0 0 7 10 2024)))
	       ;; (EndDate . (apply #'encode-time `(0 0 0 8 10 2024))))
	       (StartDate . (26371 2144))
	       (EndDate . (26372 23008)))
	     (ParentFolderIds
	       (DistinguishedFolderId (Id . "calendar"))))
	   ;; Empty arguments.
	   ,@(cdr (exco-operation-arity-nils identifier "FindItem")))
	(lambda (x y) (message (format "%s%s" x y)))))
  nil nil)


(exco-operate
  excorporate-configuration
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
	 (StartDate . "2024-10-08T00:00:00+02:00")
	 (EndDate . "2024-10-09T00:00:00+02:00"))
       ;; (StartDate . ,start-of-day-date-time)
       ;; (EndDate . ,start-of-next-day-date-time))
       (ParentFolderIds
	 (DistinguishedFolderId (Id . "calendar"))))
     ;; Empty arguments.
     ,@(cdr (exco-operation-arity-nils excorporate-configuration "FindItem")))
  ;; callback
  (lambda (x y) (message (format "%s%s" x y)))
  )
