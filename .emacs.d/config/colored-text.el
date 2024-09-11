

;;; Code:
(require 'ov)

(org-add-link-type
 "color"
 (lambda (path)
   "No follow action.")
 (lambda (color description backend)
   (cond
    ((eq backend 'html)
     (let ((rgb (assoc color color-name-rgb-alist))
	   r g b)
       (if rgb
	   (progn
	     (setq r (* 255 (/ (nth 1 rgb) 65535.0))
		   g (* 255 (/ (nth 2 rgb) 65535.0))
		   b (* 255 (/ (nth 3 rgb) 65535.0)))
	     (format "<span style=\"color: rgb(%s,%s,%s)\">%s</span>"
		     (truncate r) (truncate g) (truncate b)
		     (or description color)))
	 (format "No Color RGB for %s" color)))))))

(defun next-color-link (limit)
  (when (re-search-forward
	 "color:[a-zA-Z]\\{2,\\}" limit t)
    (forward-char -2)
    (let* ((next-link (org-element-context))
	   color beg end post-blanks)
      (if next-link
	  (progn
	    (setq color (org-element-property :path next-link)
		  beg (org-element-property :begin next-link)
		  end (org-element-property :end next-link)
		  post-blanks (org-element-property :post-blank next-link))
	    (set-match-data
	     (list beg
		   (- end post-blanks)))
	    (ov-clear beg end 'color)
	    (ov beg
		(- end post-blanks)
	     'color t
	     'face
	     `((:foreground ,color)))
	    (goto-char end))
	(goto-char limit)
	nil))))


(add-hook 'org-mode-hook
	  (lambda ()
	    (font-lock-add-keywords
	     nil
	     '((next-color-link (0 'org-link t)))
	     t)))


(provide 'org-colored-text)
;;; org-colored-text.el ends here


(require 'org-colored-text)

;; Taken and adapted from org-colored-text
(org-add-link-type
 "color"
 (lambda (path)
   "No follow action.")
 (lambda (color description backend)
   (cond
    ((eq backend 'latex)                  ; added by TL
     (format "{\\color{%s}%s}" color description)) ; added by TL
    ((eq backend 'html)
     (let ((rgb (assoc color color-name-rgb-alist))
           r g b)
       (if rgb
           (progn
             (setq r (* 255 (/ (nth 1 rgb) 65535.0))
                   g (* 255 (/ (nth 2 rgb) 65535.0))
                   b (* 255 (/ (nth 3 rgb) 65535.0)))
             (format "<span style=\"color: rgb(%s,%s,%s)\">%s</span>"
                     (truncate r) (truncate g) (truncate b)
                     (or description color)))
         (format "No Color RGB for %s" color)))))))
