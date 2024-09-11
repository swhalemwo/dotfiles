;; COLOR AGENDA VIEW START

(add-hook 'org-finalize-agenda-hook
    (lambda ()
      (save-excursion
        (goto-char (point-min))
        (while (re-search-forward " rep:" nil t) 
          (add-text-properties (match-beginning 0) (match-end 0)
             '(face (:background "pale green"))))
        (goto-char (point-min))
        (while (re-search-forward " pro2003:" nil t) 
          (add-text-properties (match-beginning 0) (match-end 0)
	       '(face (:background "#FFFF99"))))
	        (goto-char (point-min))
        (while (re-search-forward " ssc2028:" nil t) 
          (add-text-properties (match-beginning 0) (match-end 0)
             '(face (:background "#FFCCFF"))))
        (goto-char (point-min))
        (while (re-search-forward " mail:" nil t) 
          (add-text-properties (match-beginning 0) (match-end 0)
	       '(face (:background "light salmon"))))
	        (goto-char (point-min))
        (while (re-search-forward " cal:" nil t) 
          (add-text-properties (match-beginning 0) (match-end 0)
             '(face (:background "DodgerBlue1"))))
	        (goto-char (point-min))
        (while (re-search-forward " UCM:" nil t) 
          (add-text-properties (match-beginning 0) (match-end 0)
             '(face (:background "turquoise"))))

        (goto-char (point-min))
        (while (re-search-forward " uniq:" nil t) 
          (add-text-properties (match-beginning 0) (match-end 0)
             '(face (:background "dark khaki")))))))

;; COLOR AGENDA VIEW END
