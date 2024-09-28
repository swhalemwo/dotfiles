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
  
