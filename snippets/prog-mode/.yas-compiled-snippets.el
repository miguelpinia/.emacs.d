;;; Compiled snippets and support files for `prog-mode'
;;; contents of the .yas-setup.el support file:
;;;
(defun yas-with-comment (str)
  (format "%s%s%s" comment-start str comment-end))
;;; Snippet definitions:
;;;
(yas-define-snippets 'prog-mode
                     '(("x" "`(yas-with-comment \"XXX: \")`" "xxx" nil nil nil "/home/miguel/.emacs.d/snippets/prog-mode/xxx" nil nil)
                       ("t" "`(yas-with-comment \" TODO:\")` ${1:todo} (MAPA `(format-time-string \"%Y-%m-%d\")`)" "todo" nil nil nil "/home/miguel/.emacs.d/snippets/prog-mode/todo" nil nil)
                       ("fi" "`(yas-with-comment \"FIXME: \")`" "fixme" nil nil nil "/home/miguel/.emacs.d/snippets/prog-mode/fixme" nil nil)))


;;; Do not edit! File generated at Mon Aug  9 14:21:33 2021
