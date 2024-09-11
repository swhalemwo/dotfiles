;; ORG WORD COUNTER
(require 'cl)

(defun org-word-count (beg end
                           &optional count-latex-macro-args?
                           count-footnotes?)
  "Report the number of words in the Org mode buffer or selected region.
Ignores:
- comments
- tables
- source code blocks (#+BEGIN_SRC ... #+END_SRC, and inline blocks)
- hyperlinks (but does count words in hyperlink descriptions)
- tags, priorities, and TODO keywords in headers
- sections tagged as 'not for export'.

The text of footnote definitions is ignored, unless the optional argument
COUNT-FOOTNOTES? is non-nil.

If the optional argument COUNT-LATEX-MACRO-ARGS? is non-nil, the word count
includes LaTeX macro arguments (the material between {curly braces}).
Otherwise, and by default, every LaTeX macro counts as 1 word regardless
of its arguments."
  (interactive "r")
  (unless mark-active
    (setf beg (point-min)
          end (point-max)))
  (let ((wc 0)
        (latex-macro-regexp "\\\\[A-Za-z]+\\(\\[[^]]*\\]\\|\\){\\([^}]*\\)}"))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (cond
         ;; Ignore comments.
         ((or (org-in-commented-line) (org-at-table-p))
          nil)
         ;; Ignore hyperlinks. But if link has a description, count
         ;; the words within the description.
         ((looking-at org-bracket-link-analytic-regexp)
          (when (match-string-no-properties 5)
            (let ((desc (match-string-no-properties 5)))
              (save-match-data
                (incf wc (length (remove "" (org-split-string
                                             desc "\\W")))))))
          (goto-char (match-end 0)))
         ((looking-at org-any-link-re)
          (goto-char (match-end 0)))
         ;; Ignore source code blocks.
         ((org-between-regexps-p "^#\\+BEGIN_SRC\\W" "^#\\+END_SRC\\W")
          nil)
         ;; Ignore inline source blocks, counting them as 1 word.
         ((save-excursion
            (backward-char)
            (looking-at org-babel-inline-src-block-regexp))
          (goto-char (match-end 0))
          (setf wc (+ 2 wc)))
         ;; Count latex macros as 1 word, ignoring their arguments.
         ((save-excursion
            (backward-char)
            (looking-at latex-macro-regexp))
          (goto-char (if count-latex-macro-args?
                         (match-beginning 2)
                       (match-end 0)))
          (setf wc (+ 2 wc)))
         ;; Ignore footnotes.
         ((and (not count-footnotes?)
               (or (org-footnote-at-definition-p)
                   (org-footnote-at-reference-p)))
          nil)
         (t
          (let ((contexts (org-context)))
            (cond
             ;; Ignore tags and TODO keywords, etc.
             ((or (assoc :todo-keyword contexts)
                  (assoc :priority contexts)
                  (assoc :keyword contexts)
                  (assoc :checkbox contexts))
              nil)
             ;; Ignore sections marked with tags that are
             ;; excluded from export.
             ((assoc :tags contexts)
              (if (intersection (org-get-tags-at) org-export-exclude-tags
                                :test 'equal)
                  (org-forward-heading-same-level 1)
                nil))
             (t
              (incf wc))))))
        (re-search-forward "\\w+\\W*")))
    (message (format "%d words in %s." wc
                     (if mark-active "region" "buffer")))))



;; ORG WORD COUNTER START

;;; org-wc.el --- Count words in org mode trees.

;; Author: Simon Guest
;; Created: 2011-04-23

;;; Commentary:

;; Shows word count per heading line, summed over sub-headings.
;; Aims to be fast, so doesn't check carefully what it's counting.  ;-)
;;
;; Implementation based on:
;; - Paul Sexton's word count posted on org-mode mailing list 21/2/11.
;; - clock overlays
;;
;; v2
;; 29/4/11
;; Don't modify buffer, and fixed handling of empty sections.
;;
;; v3
;; 29/4/11
;; Handle narrowing correctly, so partial word count works on narrowed regions.

;;; Code:

;;; DRAWER-PART (org-in-drawer-p) GAVE AN ERROR, COMMENTED OUT, SHOULD BE OK AS LONG AS NO DRAWERS ARE USED

(eval-when-compile (require 'org)
                   (require 'cl))

(defun org-wc-in-heading-line ()
  "Is point in a line starting with `*'?"
  (equal (char-after (point-at-bol)) ?*))

;;;###autoload
(defun org-word-count (beg end)
  "Report the number of words in the Org mode buffer or selected region."
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (message (format "%d words in %s."
                   (org-word-count-aux beg end)
                   (if (use-region-p) "region" "buffer"))))

(defun org-word-count-aux (beg end)
  "Report the number of words in the selected region.
Ignores: heading lines,
         blocks,
         comments,
         drawers.
LaTeX macros are counted as 1 word."

  (let ((wc 0)
        (block-begin-re "^#\\\+BEGIN")
        (block-end-re "^#\\+END")
        (latex-macro-regexp "\\\\[A-Za-z]+\\(\\[[^]]*\\]\\|\\){\\([^}]*\\)}"))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (cond
         ;; Ignore heading lines, and sections tagged 'nowc' or 'noexport'.
         ((org-wc-in-heading-line)
          (let ((tags (org-get-tags-at)))
            (if (or (member "nowc" tags)
                    (member "noexport" tags))
                (outline-next-heading)
              (forward-line))))
         ;; Ignore blocks.
         ((looking-at block-begin-re)
          (re-search-forward block-end-re))
         ;; Ignore comments.
         ((org-at-comment-p)
          (forward-line))
         ;; Ignore drawers.
         ((org-at-drawer-p)
          (forward-line))
         ;; Count latex macros as 1 word, ignoring their arguments.
         ((save-excursion
            (backward-char)
            (looking-at latex-macro-regexp))
          (goto-char (match-end 0))
          (setf wc (+ 2 wc)))
         (t
          (progn
            (and (re-search-forward "\\w+\\W*" end 'skip)
                 (incf wc)))))))
    wc))

;;;###autoload
(defun org-wc-count-subtrees ()
  "Count words in each subtree, putting result as the property :org-wc on that heading."
  (interactive)
  (remove-text-properties (point-min) (point-max)
                          '(:org-wc t))
  (save-excursion
    (goto-char (point-max))
    (while (outline-previous-heading)
      (save-restriction
        (org-narrow-to-subtree)
        (let ((wc (org-word-count-aux (point-min) (point-max))))
          (put-text-property (point) (point-at-eol) :org-wc wc)
          (goto-char (point-min)))))))

;;;###autoload
(defun org-wc-display (beg end total-only)
  "Show subtree word counts in the entire buffer.
With prefix argument, only show the total wordcount for the buffer or region
in the echo area.
Use \\[org-wc-remove-overlays] to remove the subtree times.
Ignores: heading lines,
         blocks,
         comments,
         drawers.
LaTeX macros are counted as 1 word."
  (interactive "r\nP")
  (org-wc-remove-overlays)
  (unless total-only
    (let ((bmp (buffer-modified-p))
          wc
          p)
      (org-wc-count-subtrees)
      (save-excursion
        (goto-char (point-min))
        (while (or (and (equal (setq p (point)) (point-min))
                        (get-text-property p :org-wc))
                   (setq p (next-single-property-change
                            (point) :org-wc)))
          (goto-char p)
          (when (setq wc (get-text-property p :org-wc))
            (org-wc-put-overlay wc (funcall outline-level))))
        ;; Arrange to remove the overlays upon next change.
        (when org-remove-highlights-with-change
          (org-add-hook 'before-change-functions 'org-wc-remove-overlays
                        nil 'local)))
    (set-buffer-modified-p bmp)))
  (if mark-active
      (org-word-count beg end)
    (org-word-count (point-min) (point-max))))

(defvar org-wc-overlays nil)
(make-variable-buffer-local 'org-wc-overlays)

(defun org-wc-put-overlay (wc &optional level)
  "Put an overlay on the current line, displaying word count.
If LEVEL is given, prefix word count with a corresponding number of stars.
This creates a new overlay and stores it in `org-wc-overlays', so that it
will be easy to remove."
  (let* ((c 60)
         (l (if level (org-get-valid-level level 0) 0))
         (off 0)
         ov tx)
    (org-move-to-column c)
    (unless (eolp) (skip-chars-backward "^ \t"))
    (skip-chars-backward " \t")
    (setq ov (make-overlay (1- (point)) (point-at-eol))
          tx (concat (buffer-substring (1- (point)) (point))
                     (make-string (+ off (max 0 (- c (current-column)))) ?.)
                     (org-add-props (format "%s" (number-to-string wc))
                         (list 'face 'org-wc-overlay))
                     ""))
    (if (not (featurep 'xemacs))
        (overlay-put ov 'display tx)
      (overlay-put ov 'invisible t)
      (overlay-put ov 'end-glyph (make-glyph tx)))
    (push ov org-wc-overlays)))

;;;###autoload
(defun org-wc-remove-overlays (&optional beg end noremove)
  "Remove the occur highlights from the buffer.
BEG and END are ignored.  If NOREMOVE is nil, remove this function
from the `before-change-functions' in the current buffer."
  (interactive)
  (unless org-inhibit-highlight-removal
    (mapc 'delete-overlay org-wc-overlays)
    (setq org-wc-overlays nil)
    (unless noremove
      (remove-hook 'before-change-functions
                   'org-wc-remove-overlays 'local))))

(provide 'org-wc)
;;; org-wc.el ends here


;; ORG WORD COUTNER END 






