;;; Compiled snippets and support files for `octave-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'octave-mode
                     '(("if" "if ${1:cond}\n   $0\n${2:else\n        ${3:other}}\nendif" "if" nil nil nil "/home/miguel/.emacs.d/snippets/octave-mode/if" nil nil)
                       ("fun" "function ${1:return_val} = ${2:fname}(${3:args})\n          $0\nendfunction" "function" nil nil nil "/home/miguel/.emacs.d/snippets/octave-mode/function" nil nil)
                       ("for" "for ${1:var} = ${2:expr}\n    $0\nendfor" "for" nil nil nil "/home/miguel/.emacs.d/snippets/octave-mode/for" nil nil)))


;;; Do not edit! File generated at Tue Oct 24 21:20:12 2023
