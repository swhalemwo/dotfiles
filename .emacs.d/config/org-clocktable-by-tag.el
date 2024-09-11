(require 'org-clock)

(defun clocktable-by-tag/shift-cell (n)
  (let ((str ""))
    (dotimes (i n)
      (setq str (concat str "| ")))
    str))

(defun clocktable-by-tag/insert-tag (files params)
  (let ((tag (plist-get params :tags))
        (summary-only (plist-get params :summary))
        (total 0))
    (insert "|--\n")
    (insert (format "| %s | *Tag time* |\n" tag))
    (mapcar
     (lambda (file)
       (let ((clock-data (with-current-buffer (find-buffer-visiting file)
                           (org-clock-get-table-data (buffer-name) params))))
         (when (> (nth 1 clock-data) 0)
           (setq total (+ total (nth 1 clock-data)))
           (if (not summary-only)
               (progn
                 (insert (format "| | File *%s* | %s |\n"
                                 (file-name-nondirectory file)
                                 (org-duration-from-minutes (nth 1 clock-data))))
                 (dolist (entry (nth 2 clock-data))
                   (insert (format "| | . %s%s | %s %s |\n"
                                   (org-clocktable-indent-string (nth 0 entry))
                                   (nth 1 entry)
                                   (clocktable-by-tag/shift-cell (nth 0 entry))
                                   (org-duration-from-minutes (nth 4 entry))))))))))
     files)
    (save-excursion
      (re-search-backward "*Tag time*")
      (org-table-next-field)
      (org-table-blank-field)
      (insert (org-duration-from-minutes total))))
  (org-table-align))

(defun org-dblock-write:clocktable-by-tag (params)
  (insert "| Tag | Headline | Time (h) |\n")
  (let ((params (org-combine-plists org-clocktable-defaults params))
        (base-buffer (org-base-buffer (current-buffer)))
	      (files (pcase (plist-get params :scope)
		             (`agenda
		              (org-agenda-files t))
		             (`agenda-with-archives
		              (org-add-archive-files (org-agenda-files t)))
		             (`file-with-archives
		              (let ((base-file (buffer-file-name base-buffer)))
		                (and base-file
			                   (org-add-archive-files (list base-file)))))
		             ((or `nil `file)
		              (list (buffer-file-name)))
		             (_ (user-error "Unknown scope: %S" scope))))
        (tags (plist-get params :tags)))
    (mapcar (lambda (tag)
              (clocktable-by-tag/insert-tag files (org-combine-plists params `(:match ,tag :tags ,tag))))
            tags)))
