;;; Compiled snippets and support files for `rjsx-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'rjsx-mode
                     '(("typo" "<Typography variant='${1:body1}'>\n  $0\n</Typography>" "typo" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/typo" nil nil)
                       ("try" "try {\n  $1\n} catch (error) {\n  console.log('Error', error.response.data?.message || error);\n} finally {\n  $0\n}" "try" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/try" nil nil)
                       ("item" "<Grid item xs={12}>\n  $0\n</Grid>" "item" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/item" nil nil)
                       ("hook" "const $1 = ($2) => {\n  $0\n};" "hook" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/hook" nil nil)
                       ("group" "console.group('${1:Datos}');\nconsole.log(${2:state});\nconsole.groupEnd();" "group" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/group" nil nil)
                       ("ef" "React.useEffect((${1:params}) =>{\n  $0\n});" "effect" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/ef" nil nil)
                       ("dis" "dispatch({type: $1, payload: $2});\n$0" "dis" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/dis" nil nil)
                       ("container" "<Grid item container spacing={3} alignItems='stretch'>\n  $0\n</Grid>\n" "container" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/container" nil nil)
                       ("cn" "const $1 = '$1';" "cn" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/cn" nil nil)
                       ("ahook" "const $1 = async ($2) => {\n  $0\n};" "ahook" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/ahook" nil nil)
                       ("adel" "axios.delete(${1:\\`\\${backend()\\}/\\`, {\n  params: \\{id: id\\}\n}})$0" "adel" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/adel" nil nil)
                       ("Frag" "<React.Fragment $0/>" "Frag" nil nil nil "/home/miguel/.emacs.d/snippets/rjsx-mode/Frag" nil nil)))


;;; Do not edit! File generated at Tue Oct 24 21:20:12 2023
