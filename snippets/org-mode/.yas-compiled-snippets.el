;;; Compiled snippets and support files for `org-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-mode
                     '(("verse" "#+begin_verse\n        $0\n#+end_verse" "verse" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/verse" nil nil)
                       ("titre" "#+REVEAL_ROOT: file:///home/miguel/proyectos/reveal.js\n#+title: ${1:titulo}\n#+author: Miguel Piña\n#+date: ${1:$(format-time-string \"[%Y-%m-%d %a %H:%M]\" (current-time))}\n#+setupfile: ~/proyectos/org-html-themes/setup/theme-bigblow.setup\n\n#+OPTIONS: reveal_center:t reveal_progress:t reveal_history:nil reveal_control:t\n#+OPTIONS: reveal_mathjax:t reveal_rolling_links:t reveal_keyboard:t reveal_overview:t num:nil\n#+OPTIONS: reveal_width:1200 reveal_height:800\n#+OPTIONS: reveal_single_file:ni\n#+OPTIONS: toc:nil\n\n#+REVEAL_THEME: night\n#+REVEAL_EXTRA_CSS: file:///home/miguel/proyectos/reveal.js/presentation.css\n#+REVEAL_TRANS: slide\n#+REVEAL_SPEED: slow\n\n$0\n" "Org title" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/title_reveal" "C-c i r" nil)
                       ("title" "#+title: ${1:titulo}\n#+author: Miguel Piña\n#+date: ${1:$(format-time-string \"[%Y-%m-%d %a %H:%M]\" (current-time))}\n#+setupfile: ~/proyectos/org-html-themes/setup/theme-bigblow.setup\n\n$0" "Org title" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/title" "C-c i t" nil)
                       ("tag" "#+TAGS: ${1:tags}\n$0" "tag" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/tag" "direct-keybinding" nil)
                       ("name" "#+srcname: $0" "srcname" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/srcname" nil nil)
                       ("src" "#+begin_src ${1:language}\n$0\n#+end_src\n" "src" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/src" nil nil)
                       ("side" "#+begin_abmn\n$0\n#+end_abmn" "side" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/side" nil nil)
                       ("proof" "#+begin_proof\n$0\n#+end_proof" "proof" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/proof" nil nil)
                       ("notes" "#+begin_notes\n${1:Notas}\n#+end_notes" "notes" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/notes" "direct-keybinding" nil)
                       ("matrix" "\\left \\(\n\\begin{array}{${1:ccc}}\n${2:v1 & v2} \\\\\n$0\n\\end{array}\n\\right \\)" "matrix" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/matrix" nil nil)
                       ("\\(" "\\\\($0\\\\)" "\\(\\)" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/math" nil nil)
                       ("lemma" "#+begin_lemma\n$0\n#+end_lemma" "lemma" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/lemma" nil nil)
                       ("latex" "#+BEGIN_LaTeX\n$0\n#+END_LaTeX" "latex" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/latex" nil nil)
                       ("lat" "src_latex{\\$$0\\$}" "lat" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/lat" nil nil)
                       ("img" "<img src=\"$1\"\n alt=\"$2\" align=\"${3:left}\"\n title=\"${4:image title}\"\n class=\"img\"\n</img>\n$0" "img" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/img" nil nil)
                       ("il" "\\($0\\)" "insert latex" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/il" nil nil)
                       ("fig" "#+CAPTION: ${1:caption}\n#+ATTR_LaTeX: ${2:scale=0.75}\n#+LABEL: fig:${3:label}\n" "figure" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/figure" nil nil)
                       ("ex" "#+begin_example\n$0\n#+end_example" "ex" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/ex" nil nil)
                       ("entry" "#+begin_html\n---\nlayout: ${1:default}\ntitle: ${2:title}\n---\n#+end_html\n$0" "entry" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/entry" nil nil)
                       ("emb" "src_${1:lang}${2:[${3:where}]}{${4:code}}" "embedded" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/embedded" nil nil)
                       ("elisp" "#+begin_src emacs-lisp :tangle yes\n$0\n#+end_src" "elisp" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/elisp" nil nil)
                       ("dot" "#+begin_src dot :file ${1:file} :cmdline -T${2:pdf} :exports none :results silent\n            $0\n#+end_src\n\n[[file:$1]]" "dot" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/dot" nil nil)
                       ("defi" "#+begin_definition\n$0\n#+end_definition" "defi" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/defi" nil nil)
                       ("code" "#+begin_${1:lang} ${2:options}\n$0\n#+end_$1" "code" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/code" nil nil)
                       ("cite" "#+begin_cite\n${1:cita}\n#+end_cite" "cite" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/cite" "direct-keybinding" nil)
                       ("center" "#+begin_center\n$0\n#+end_center" "center" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/center" "direct-keybinding" nil)
                       ("cat" "#+CATEGORY: ${1:Programación}" "cat" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/cat" "direct-keybinding" nil)
                       ("blog" "#+STARTUP: showall indent\n#+STARTUP: hidestars\n#+BEGIN_HTML\n---\nlayout: default\ntitle: ${1:title}\nexcerpt: ${2:excerpt}\n---\n$0" "blog" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/blog" nil nil)
                       ("block" "#+begin_${1:solution}\n$0\n#+end_$1" "block" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/block" nil nil)
                       ("begin" "\\begin{${1:equation}}\n  $0\n\\end{$1}" "begin_block" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/begin" nil nil)
                       ("algorithm" "#+LaTeX_HEADER: \\usepackage[lined,boxed,commentsnumbered]{algorithm2e}" "algorithm" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/algorithm" nil nil)
                       ("affir" "#+begin_affirmation\n$0\n#+end_affirmation" "affir" nil nil nil "/home/miguel/.emacs.d/snippets/org-mode/affir" nil nil)))


;;; Do not edit! File generated at Tue Oct 24 21:20:12 2023
