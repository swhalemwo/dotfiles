(use-package org-brain

    ;; :bind (("H" . 'helm-brain))
    :config
    (define-key org-brain-visualize-mode-map "I" 'org-brain-index-tags)
    (define-key org-brain-visualize-mode-map "B" 'org-brain--toggle-visualize-peers)
    )

(setq org-brain-visualize-peers nil)

(defun org-brain--toggle-visualize-peers ()
    (interactive)
    """peers: children of same parents"""
    (if org-brain-visualize-peers
	    (setq org-brain-visualize-peers nil)
	(setq org-brain-visualize-peers t))
    (org-brain--revert-if-visualizing)
    )

(defun org-brain-mind-map (entry parent-max-level children-max-level)
  "Insert a tree of buttons for the parents and children of ENTRY.
Insert friends to ENTRY in a row above the tree.
Will also insert grand-parents up to PARENT-MAX-LEVEL, and
children up to CHILDREN-MAX-LEVEL.
Return the position of ENTRY in the buffer."
  (insert "FRIENDS:")
  (dolist (friend (sort (org-brain-friends entry) org-brain-visualize-sort-function))
    (insert "  ")
    (org-brain-insert-visualize-button friend 'org-brain-friend 'friend))
  (setq-local org-brain--visualize-header-end-pos (point))
  (insert "\n\n")
  (let ((indent (1- (org-brain-tree-depth (org-brain-recursive-parents entry parent-max-level))))
        (entry-pos))
      ;; (measure-time "org-brain-mind-map entry-stuff"
    (dolist (parent (sort (org-brain-siblings entry) (lambda (x y)
                                                       (funcall org-brain-visualize-sort-function
                                                                (car x) (car y)))))
	(org-brain-insert-recursive-parent-buttons (car parent) (1- parent-max-level) (1- indent))
	(if org-brain-visualize-peers
      (let* ((parent-tags (org-brain-get-tags (car parent)))
             (children-links (unless (member org-brain-exclude-siblings-tag parent-tags)
                               (cdr parent))))
        (dolist (sibling (sort children-links org-brain-visualize-sort-function))
          (insert (org-brain-map-create-indentation indent))
          (org-brain-insert-visualize-button sibling 'org-brain-sibling 'sibling)
          (insert "\n")))
      )      )
    ;; )
    (insert (org-brain-map-create-indentation indent))
    (setq entry-pos (point))
    (insert (propertize (org-brain-title entry)
                        'face 'org-brain-title
              'aa2u-text t)
      "\n")
    (dolist (child (sort (org-brain-children entry) org-brain-visualize-sort-function))
      (org-brain-insert-recursive-child-buttons child (1- children-max-level) (1+ indent)))
    entry-pos))



(defun org-brain-choose-entries (prompt entries &optional predicate require-match initial-input hist def inherit-input-method)
  "PROMPT for one or more ENTRIES, separated by `org-brain-entry-separator'.
ENTRIES can be a list, or 'all which lists all headline and file entries.
Return the prompted entries in a list.
Very similar to `org-brain-choose-entry', but can return several entries.

For PREDICATE, REQUIRE-MATCH, INITIAL-INPUT, HIST, DEF and
INHERIT-INPUT-METHOD see `completing-read'."
  (let* (
	  (targets (if (eq entries 'all)
                     (org-brain--all-targets)
		     ;; (-uniq org-brain-keywords-cache-keys) ;; use cache to get candidates faster
                    (mapcar (lambda (x)
                              (cons (org-brain-entry-name x)
                                    (if (org-brain-filep x)
                                        x
                                      (nth 2 x))))
                      entries)))

	  
         (choices (org-brain-completing-read prompt targets
                                             predicate require-match initial-input hist def inherit-input-method)))
    (mapcar (lambda (title) (org-brain-get-entry-from-title title targets))
            (if org-brain-entry-separator
                (split-string choices org-brain-entry-separator)
              (list choices)))))	


(defun org-brain-select (entry)
  "Toggle selection of ENTRY.
If run interactively, get ENTRY from context."
  
  (interactive (list (org-brain-entry-at-pt)))

  (measure-time "selecting"

  (when (null entry) (error "Cannot select null entry"))
  (if (member entry org-brain-selected)
	  (progn
          (setq org-brain-selected (delete entry org-brain-selected))
	  (message "Entry unselected.")
	  )
      (progn
          (push entry org-brain-selected)
	  (message "Entry selected."))
   
      )
  )
  (measure-time "saving"
		(org-brain-save-data))
		
  (measure-time "visualizing"
		(org-brain--revert-if-visualizing)
		)
  )

(defun helm-brain--select (_c)
    (dolist (candidate (helm-marked-candidates))
	(org-brain-select (or (org-brain-entry-from-id candidate) candidate))))


(defun org-brain-build-keyword-cache (entry)
    (message "lol")
    (push `(entry . ,(org-brain-keywords entry)) org-brain-keywords-cache)
    ;; (send-org-brain-keywords-to-python entry)
    )

(load-file "/home/johannes/Dropbox/personal_stuff/obr-viz/database_backend/constant_update.el")

;; (setf (alist-get "Hsu_2015_granted" org-brain-keywords-cache) (org-brain-keywords-get "Hsu_2015_granted"))



(defun alist-keys (alist)
  ;; gets the first entry of alist, which I guess is a list of lists
    (mapcar 'car alist))





(defun org-brain-keywords-update-entry (entry)
    "update the keyword cache for entry"
    (setf (alist-get entry org-brain-keywords-cache) (org-brain-keywords-get entry)))


(defun org-brain-keywords-cache-update ()
    "function to add to after-save-hook to update cache"
    (when (equal default-directory org-brain-path)
	
	(let* ((buf-name (buffer-name))
	       (org-brain-name (substring buf-name 0 (- (length buf-name) 4))))
	    
	    (org-brain-keywords-update-entry org-brain-name)
	    ;; (send-org-brain-keywords-to-python org-brain-name)
	    )))
	


(defun org-brain-keywords-get (entry)
    "Get alist of `org-mode' keywords and their values in file ENTRY."
  (if (org-brain-filep entry)
      (with-temp-buffer
        (insert
         (with-temp-buffer
           (ignore-errors (insert-file-contents (org-brain-entry-path entry)))
           (buffer-substring-no-properties (point-min) (org-brain-first-headline-position))))
        (org-element-map (org-element-parse-buffer) 'keyword
          (lambda (kw)
            (cons (org-element-property :key kw)
                  (org-element-property :value kw)))))
    (error "Only file entries have keywords")))

(defun org-brain-keywords (entry)
    ;; (message "entry: %s" entry)
    "get keywords: use cache is available, else look up in file"
    (if (member entry org-brain-keywords-cache-keys)
	    (assoc-default entry org-brain-keywords-cache)

	(let ((kwds (org-brain-keywords-get entry)))

	    (push `(,entry . ,kwds) org-brain-keywords-cache)
	    (push entry org-brain-keywords-cache-keys)
	    (message "entry: %s" entry)
	    ;; (send-org-brain-keywords-to-python entry)
	    kwds)
      ))




(defun org-brain-index-tags ()
    """add all parents to tags: saves a lot of manual work"""
    (interactive)
    (let ((entry-tags-all (org-brain-parents (org-brain-entry-at-pt)))
	  (to-avoid (list "cls_tags" "cls_media" "cls_toread" "sbcls_A" "sbcls_B" "sbcls_C" "sbcls_D" "sbcls_E" "cls_techreports" "cls_reviews" "cls_org_pop" "cls_org_idt"))
	  )
	(dolist (i entry-tags-all)
	    
	    (when (not (member i to-avoid))
		(progn
		    (when (not (member "cls_tags" (org-brain-parents i)))
			(message "%s: add me" i)
			(org-brain-add-child "cls_tags" (list i))
			)
		    )
		))))





;; saving org-brain cache 
;; get generic functions from https://stackoverflow.com/questions/2321904/elisp-how-to-save-data-in-a-file

(defun print-to-file (filename data)
  (with-temp-file filename
    (prin1 data (current-buffer))))

(defun read-from-file (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (cl-assert (eq (point) (point-min)))
    (read (current-buffer))))




;; (print-to-file org-brain-cache-file org-brain-keywords-cache) ;; should not be uncommented, only run once
;; (setq org-brain-keywords-cache org-brain-keywords-cache2)



(defun org-brain-save-cache ()
    (interactive)
    (print-to-file org-brain-cache-file org-brain-keywords-cache)
    )

;; add hook for regularly saving org-brain-keywords-cache



(add-hook 'after-save-hook 'org-brain-keywords-cache-update)
;; (remove-hook 'after-save-hook 'org-brain-keywords-cache-update)

;; (setq savehist-additional-variables '(org-brain-keywords-cache))

;; (when (not (> (length (emacs-uptime)) 10))
(setq org-brain-keywords-cache ())
(setq org-brain-keywords-cache-keys ())
    ;; )



(setq org-brain-cache-file "/home/johannes/Dropbox/technical_stuff_general/org-brain/org-brain-cache.el")


(setq org-brain-keywords-cache (read-from-file org-brain-cache-file))
;; (setq org-brain-keywords-cache nil)
(setq org-brain-keywords-cache-keys (alist-keys org-brain-keywords-cache))

;; (setq org-brain-keywords-cache-keys (alist-keys org-brain-keywords-cache))


(add-hook 'kill-emacs-hook 'org-brain-save-cache)
;; (run-with-timer 0 7200 'org-brain-save-cache)


