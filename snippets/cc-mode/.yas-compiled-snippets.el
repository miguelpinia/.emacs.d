;;; Compiled snippets and support files for `cc-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'cc-mode
                     '(("while" "while (${1:condition}) {\n      $0\n}" "while" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/while" nil nil)
                       ("typedef" "typedef ${1:type} ${2:alias};" "typedef" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/typedef" nil nil)
                       ("?" "(${1:cond}) ? ${2:then} : ${3:else};" "ternary" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/ternary" nil nil)
                       ("struct" "struct ${1:name}\n{\n    $0\n};" "struct ... { ... }" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/struct" nil nil)
                       ("once" "#ifndef ${1:`(upcase (file-name-nondirectory (file-name-sans-extension (buffer-file-name))))`_H}\n#define $1\n\n$0\n\n#endif /* $1 */" "#ifndef XXX; #define XXX; #endif" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/once" nil nil)
                       ("math" "#include <math.h>\n$0" "math" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/math" nil nil)
                       ("main" "int main(${1:int argc, char *argv[]})\n{\n    $0\n    return 0;\n}\n" "main" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/main" nil nil)
                       ("inc" "#include <$1>\n" "#include <...>" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/inc.1" nil nil)
                       ("inc" "#include \"$1\"\n" "#include \"...\"" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/inc" nil nil)
                       ("ifdef" "#ifdef ${1:MACRO}\n\n$0\n\n#endif // $1" "ifdef" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/ifdef" nil nil)
                       ("cc-modeif" "if (${1:condition})\n{\n    $0\n}" "if (...) { ... }" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/if" nil nil)
                       ("for" "for (${1:i = 0}; ${2:i < N}; ${3:i++}) {\n    $0\n}\n" "for" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/for" nil nil)
                       ("do" "do\n{\n    $0\n} while (${1:condition});" "do { ... } while (...)" nil nil nil "/home/miguel/.emacs.d/snippets/cc-mode/do" nil nil)))


;;; Do not edit! File generated at Wed Jan 11 13:04:48 2023
