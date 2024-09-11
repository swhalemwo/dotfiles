(require 'mu4e)
(require 'smtpmail)

(setq mu4e-mu-home "/home/johannes/.cache/mu/")


(setq
  ;; general
  ;; mu4e-get-mail-command "offlineimap"
  mu4e-get-mail-command "mbsync -a -V -c /home/johannes/.mbsyncrc"
  mu4e-update-interval 800

  ;; smtp
  message-send-mail-function 'message-send-mail-with-sendmail
  sendmail-program "/usr/bin/msmtp"
  user-full-name "Johannes Aengenheyster"  
  ;; smtpmail-stream-type 'starttls
  ;; smtpmail-debug-info t


  mu4e-maildir "/home/johannes/mbsync/"
  ;; mu4e-maildir "~/Maildir/"		

  mu4e-drafts-folder "/outlook/Drafts"
  mu4e-sent-folder   "/outlook/Sent"
  mu4e-trash-folder  "/outlook/Deleted"

  ;; ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
  mu4e-sent-messages-behavior 'delete

  mu4e-change-filenames-when-moving t

  mu4e-alert-interesting-mail-query "flag:unread AND NOT (flag:trashed OR maildir:Junk OR maildir:/outlook/Junk)"

  ;; smtpmail-queue-mail nil

  ;; smtpmail-queue-dir   "~/mbsync/queue/cur"

  ;; keybindings
  mu4e-maildir-shortcuts
  '(("/outlook/Inbox"          . ?i)
     ("/outlook/Sent"          . ?s)
     ("/outlook/Deleted"       . ?t)
     ("/outlook2/Inbox"        . ?k)
     ("/outlook/Junk"          . ?j)
     ("/uva/Inbox"             . ?e)
     ("/uva/Sent Items"        . ?f)
     ;; ("/Exchange/INBOX"             . ?u)

     

     )
  ; attachment dir
  mu4e-attachment-dir  "/home/johannes/Downloads"

  ; insert sign
  mu4e-compose-signature-auto-include 't
)



(setq mu4e-contexts
    `( ,(make-mu4e-context
          :name "outlook"
          :enter-func (lambda () (mu4e-message "Entering general context"))
          :leave-func (lambda () (mu4e-message "Leaving Private context"))
          ;; we match based on the contact-fields of the message
          :match-func
	  (lambda (msg)
            (when msg 
              (mu4e-message-contact-field-matches msg 
                :to (password-store-get "outlook-email"))))

	  :vars `((user-mail-address . ,(password-store-get "outlook-email"))
	           ( user-full-name         . "Johannes Aengenheyster" )
		   (mu4e-sent-messages-behavior .  delete)))

       ,(make-mu4e-context
          :name "outlook2"
          :enter-func (lambda () (mu4e-message "Entering uni context"))
          :leave-func (lambda () (mu4e-message "Leaving uni context"))
          ;; we match based on the contact-fields of the message
          :match-func (lambda (msg)
                        (when msg 
                          (mu4e-message-contact-field-matches msg 
	                    :to (password-store-get "outlook2-email"))))
	  :vars `((user-mail-address . ,(password-store-get "outlook2-email"))
		   ( user-full-name         . "Johannes Aengenheyster" )
		   (mu4e-sent-messages-behavior .  delete)))      

       ,(make-mu4e-context
          :name "uva"
          :enter-func (lambda () (mu4e-message "Entering uva context"))
          :leave-func (lambda () (mu4e-message "Leaving uva context"))
          ;; we match based on the contact-fields of the message
          :match-func (lambda (msg)
                        (when msg 
                          (mu4e-message-contact-field-matches msg 
			    :to (password-store-get "uva-email"))))
	  :vars `( (user-mail-address      . ,(password-store-get "uva-email"))
                   (user-full-name         . "Johannes Aengenheyster" )
		   (mu4e-sent-folder . "/uva/Sent Items")
		   (mu4e-sent-messages-behavior .  sent)))))



  ;; set `mu4e-context-policy` and `mu4e-compose-policy` to tweak when mu4e should
  ;; guess or ask the correct context, e.g.

  ;; start with the first (default) context; 
  ;; default is to ask-if-none (ask when there's no context yet, and none match)
  ;; (setq mu4e-context-policy 'pick-first)

  ;; compose with the current context is no context matches;
  ;; default is to ask 
  ;; (setq mu4e-compose-context-policy nil)


(setq mu4e-compose-context-policy 'ask-if-none)
(setq mu4e-display-update-status-in-modeline t)

(setq mu4e-headers-fields
      '((:human-date . 12)
	(:flags . 6)
	(:mailing-list . 10)
	(:from . 22)
	(:subject . 50)))
(setq mu4e-update-interval 300)
(setq mu4e-view-show-images t)


;; (require 'mu4e-maildirs-extension)
;; (mu4e-maildirs-extension)

;; (setq mu4e-maildirs-extension-fake-maildir-separator "\\.")

;; (setq mu4e-maildirs-extension-action-text "\t* [u]pdate index & cache\n\n")
;; (setq mu4e-maildirs-extension-before-insert-maildir-hook nil)
;; (setq mu4e-maildirs-extension-default-collapse-level 1)


(add-hook 'after-init-hook 'mu4e-alert-enable-notifications)
(add-hook 'after-init-hook 'mu4e-alert-enable-mode-line-display)


