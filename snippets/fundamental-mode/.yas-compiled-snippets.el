;;; Compiled snippets and support files for `fundamental-mode'
;;; contents of the .yas-setup.el support file:
;;;
(defun ca-all-asscs (asslist query)
  "returns a list of all corresponding values (like rassoc)"
  (cond
   ((null asslist) nil)
   (t
    (if (equal (cdr (car asslist)) query)
        (cons (car (car asslist)) (ca-all-asscs (cdr asslist) query))
      (ca-all-asscs (cdr asslist) query)))))
;;; Do not edit! File generated at Tue Oct 24 21:20:11 2023
