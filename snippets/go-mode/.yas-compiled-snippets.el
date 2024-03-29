;;; Compiled snippets and support files for `go-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'go-mode
                     '(("var" "var (\n  ${1:name} ${2:type}\n)" "var (...)" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/var(" nil nil)
                       ("var" "var ${1:name} ${2:type}\n$0" "var" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/var" nil nil)
                       ("type" "type $1 $2 {\n  $0\n}" "type" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/type" nil nil)
                       ("sw" "switch $1 {\ncase $2:\n  $0\n}" "switch" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/switch" nil nil)
                       ("sel" "select {\ncase $1:\n  $0\n}" "select" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/select" nil nil)
                       ("pr" "fmt.Printf(\"${1:%s}\\n\", ${2:args})\n$0" "fmt.Printf(...)" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/printf" nil nil)
                       ("map" "map[${1:type}]${2:type}\n" "map" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/map" nil nil)
                       ("main" "func main() {\n  $0\n}" "func main()" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/main" nil nil)
                       ("lambda" "func(${1:args}) $2 {\n  $0\n}()" "lambda func" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/lambda" nil nil)
                       ("imp" "import (\n  \"$0\"\n)\n" "import (...)" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/import(" nil nil)
                       ("imp" "import \"$1\"\n$0" "import" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/import" nil nil)
                       ("iferr" "if err != $1 {\n  $0\n}\n" "if error" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/iferr" nil nil)
                       ("if" "if $1 {\n  $0\n}" "if" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/if" nil nil)
                       ("func" "//\nfunc ${1:name}(${2:args}) $3 {\n  $0\n}" "func" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/func" nil nil)
                       ("for" "for $1 {\n  $0\n}\n" "for" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/for" nil nil)
                       ("el" " else {\n  $0\n}" "else" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/else" nil nil)
                       ("def" "default:\n$0" "default" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/default" nil nil)
                       ("dd" "fmt.Printf(\"%+v\\n\", $1) // output for debug\n$0" "debug fmt.Printf" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/dd" nil nil)
                       ("const" "const (\n  ${1:name type} = ${2:val}\n)" "const (...)" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/const(" nil nil)
                       ("const" "const ${1:name type} = ${2:val}\n$0" "const" nil nil nil "/home/miguel/.emacs.d/snippets/go-mode/const" nil nil)))


;;; Do not edit! File generated at Tue Oct 24 21:20:11 2023
