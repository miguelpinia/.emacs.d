;;; Compiled snippets and support files for `sh-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'sh-mode
                     '(("ife" "if ${1:cond}\nthen ${2:stuff}\nelse ${3:other}\nfi\n$0" "ife" nil nil nil "/home/miguel/.emacs.d/snippets/sh-mode/ife" nil nil)
                       ("if" "if ${1:[ -f file]}\n   then ${2:do}\nfi\n$0" "if" nil nil nil "/home/miguel/.emacs.d/snippets/sh-mode/if" nil nil)
                       ("f" "function ${1:name} {\n         $0\n}" "function" nil nil nil "/home/miguel/.emacs.d/snippets/sh-mode/function" nil nil)
                       ("for" "for ${1:var} in ${2:stuff}; do\n    $0\ndone" "for loop" nil nil nil "/home/miguel/.emacs.d/snippets/sh-mode/for loop" nil nil)
                       ("!" "#!/bin/bash\n$0" "bang" nil nil nil "/home/miguel/.emacs.d/snippets/sh-mode/bang" nil nil)
                       ("autorsh" "Autor: Miguel Angel Piña Avelino\n${1:descripcion}\nVersion: $2\n$0" "autorsh" nil nil nil "/home/miguel/.emacs.d/snippets/sh-mode/autor" "direct-keybinding" nil)
                       ("args" "if [ $# -lt ${1:2} ]\n   then $0\nfi" "args" nil nil nil "/home/miguel/.emacs.d/snippets/sh-mode/args" nil nil)))


;;; Do not edit! File generated at Mon Aug  9 14:21:33 2021
