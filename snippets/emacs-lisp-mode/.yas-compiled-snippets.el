;;; Compiled snippets and support files for `emacs-lisp-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'emacs-lisp-mode
                     '(("yes-or-no-p" "(yes-or-no-p \"PROMPT$0 \")" "yes-or-no-p" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/yes-or-no-p" nil nil)
                       ("yonp" "(yes-or-no-p \"PROMPT$0 \")" "y-or-n-p" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/y-or-n-p" nil nil)
                       ("x-word-or-region" ";; example of a command that works on current word or text selection\n(defun down-case-word-or-region ()\n  \"Lower case the current word or text selection.\"\n(interactive)\n(let (pos1 pos2 meat)\n  (if (and transient-mark-mode mark-active)\n      (setq pos1 (region-beginning)\n            pos2 (region-end))\n    (setq pos1 (car (bounds-of-thing-at-point 'symbol))\n          pos2 (cdr (bounds-of-thing-at-point 'symbol))))\n\n  ; now, pos1 and pos2 are the starting and ending positions\n  ; of the current word, or current text selection if exists\n\n  ;; put your code here.\n  $0\n  ;; Some example of things you might want to do\n  (downcase-region pos1 pos2) ; example of a func that takes region as args\n  (setq meat (buffer-substring-no-properties pos1 pos2)) ; grab the text.\n  (delete-region pos1 pos2) ; get rid of it\n  (insert \"newText\") ; insert your new text\n\n  )\n)" "Command that works on region or word" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/x-word-or-region" nil nil)
                       ("x-traverse_dir" ";; apply a function to all files in a dir\n(require 'find-lisp)\n(mapc 'my-process-file (find-lisp-find-files \"~/myweb/\" \"\\\\.html$\"))" "traversing a directory" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/x-traverse_dir" nil nil)
                       ("x-grabthing" "(setq $0 (thing-at-point 'symbol))" "grab word under cursor" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/x-grabthing" nil nil)
                       ("x-grabstring" "(setq $0 (buffer-substring-no-properties myStartPos myEndPos))" "grab buffer substring" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/x-grabstring" nil nil)
                       ("x-find-replace" "(defun replace-html-chars-region (start end)\n  \"Replace “<” to “&lt;” and other chars in HTML.\nThis works on the current region.\"\n  (interactive \"r\")\n  (save-restriction \n    (narrow-to-region start end)\n    (goto-char (point-min))\n    (while (search-forward \"&\" nil t) (replace-match \"&amp;\" nil t))\n    (goto-char (point-min))\n    (while (search-forward \"<\" nil t) (replace-match \"&lt;\" nil t))\n    (goto-char (point-min))\n    (while (search-forward \">\" nil t) (replace-match \"&gt;\" nil t))\n    )\n  )" "find and replace on region" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/x-find-replace" nil nil)
                       ("x-file" "(defun read-lines (filePath)\n  \"Return a list of lines in FILEPATH.\"\n  (with-temp-buffer\n    (insert-file-contents filePath)\n    (split-string\n     (buffer-string) \"\\n\" t)) )\n\n;; process all lines\n(mapc \n (lambda (aLine) \n   (message aLine) ; do your stuff here\n   )\n (read-lines \"inputFilePath\")\n)" "read lines of a file" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/x-file.read-lines" nil nil)
                       ("x-file" "(defun doThisFile (fpath)\n  \"Process the file at path FPATH ...\"\n  (let ()\n    ;; create temp buffer without undo record or font lock. (more efficient)\n    ;; first space in temp buff name is necessary\n    (set-buffer (get-buffer-create \" myTemp\"))\n    (insert-file-contents fpath nil nil nil t)\n\n    ;; process it ...\n    ;; (goto-char 0) ; move to begining of file's content (in case it was open)\n    ;; ... do something here\n    ;; (write-file fpath) ;; write back to the file\n\n    (kill-buffer \" myTemp\")))" "a function that process a file" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/x-file.process" nil nil)
                       ("x-dired" ";; idiom for processing a list of files in dired's marked files\n \n;; suppose myProcessFile is your function that takes a file path\n;; and do some processing on the file\n\n(defun dired-myProcessFile ()\n  \"apply myProcessFile function to marked files in dired.\"\n  (interactive)\n  (require 'dired)\n  (mapc 'myProcessFile (dired-get-marked-files))\n)\n\n;; to use it, type M-x dired-myProcessFile" "process marked files in dired" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/x-dired.process_marked" nil nil)
                       ("<" "\"\\\\_<${1:word}\\\\_>\"" "word_regexp" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/word_regexp" nil nil)
                       ("word-or-region" ";; example of a command that works on current word or text selection\n(defun down-case-word-or-region ()\n  \"Lower case the current word or text selection.\"\n(interactive)\n(let (pos1 pos2 meat)\n  (if (and transient-mark-mode mark-active)\n      (setq pos1 (region-beginning)\n            pos2 (region-end))\n    (setq pos1 (car (bounds-of-thing-at-point 'symbol))\n          pos2 (cdr (bounds-of-thing-at-point 'symbol))))\n\n  ; now, pos1 and pos2 are the starting and ending positions\n  ; of the current word, or current text selection if exists\n\n  ;; put your code here.\n  $0\n  ;; Some example of things you might want to do\n  (downcase-region pos1 pos2) ; example of a func that takes region as args\n  (setq meat (buffer-substring-no-properties pos1 pos2)) ; grab the text.\n  (delete-region pos1 pos2) ; get rid of it\n  (insert \"newText\") ; insert your new text\n\n  )\n)\n" "Command that works on region or word" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/word-or-region" nil nil)
                       ("wcb" "(with-current-buffer $0 )" "with-current-buffer" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/with-current-buffer" nil nil)
                       ("wg" "(widget-get $0 )" "widget-get" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/widget-get" nil nil)
                       ("while" "(while $0)" "while" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/while" nil nil)
                       ("when" "(when $0)" "when" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/when" nil nil)
                       ("v" "(vector $0)" "vector" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/vector" nil nil)
                       ("unless" "(unless $0)" "unless" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/unless" nil nil)
                       ("traverse_dir" ";; apply a function to all files in a dir\n(require 'find-lisp)\n(mapc 'my-process-file (find-lisp-find-files \"~/myweb/\" \"\\\\.html$\"))\n" "traversing a directory" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/traverse_dir" nil nil)
                       ("tap" "(thing-at-point '$0) ; symbol, list, sexp, defun, filename, url, email, word, sentence, whitespace, line, page ..." "thing-at-point" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/thing-at-point" nil nil)
                       ("substring" "(substring STRING$0 FROM &optional TO)" "substring" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/substring" nil nil)
                       ("stringp" "(stringp $0)" "stringp" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/stringp" nil nil)
                       ("string=" "(string= $0 )" "string=" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/string=" nil nil)
                       ("stn" "(string-to-number \"$0\")" "string-to-number" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/string-to-number" nil nil)
                       ("sm" "(string-match \"REGEXP$0\" \"STRING\" &optional START)" "string-match" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/string-match" nil nil)
                       ("string" "(string $0 )" "string" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/string" nil nil)
                       ("ss" "(split-string $0 &optional SEPARATORS OMIT-NULLS)" "split-string" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/split-string" nil nil)
                       ("scf" "(skip-chars-forward \"$0\" &optional LIM)" "skip-chars-forward" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/skip-chars-forward" nil nil)
                       ("scb" "(skip-chars-backward \"$0\" &optional LIM)" "skip-chars-backward" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/skip-chars-backward" nil nil)
                       ("s" "(setq $0 )" "setq" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/setq" nil nil)
                       ("sm" "(set-mark $0)" "set-mark" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/set-mark" nil nil)
                       ("sfm" "(set-file-modes $0 MODE)" "set-file-modes" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/set-file-modes" nil nil)
                       ("sb" "(set-buffer $0 )" "set-buffer" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/set-buffer" nil nil)
                       ("set" "(set $0 )" "set" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/set" nil nil)
                       ("sfr" "(search-forward-regexp \"$0\" &optional BOUND NOERROR COUNT)" "search-forward-regexp" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/search-forward-regexp" nil nil)
                       ("sf" "(search-forward \"$0\" &optional BOUND NOERROR COUNT)" "search-forward" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/search-forward" nil nil)
                       ("sbr" "(search-backward-regexp \"$0\" &optional BOUND NOERROR COUNT)" "search-backward-regexp" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/search-backward-regexp" nil nil)
                       ("sb" "(search-backward \"$0\" &optional BOUND NOERROR COUNT)" "search-backward" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/search-backward" nil nil)
                       ("se" "(save-excursion $0)" "save-excursion" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/save-excursion" nil nil)
                       ("sb" "(save-buffer $0)" "save-buffer" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/save-buffer" nil nil)
                       ("require" "(require $0 )" "require" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/require" nil nil)
                       ("rris" "(replace-regexp-in-string REGEXP$0 REP STRING &optional FIXEDCASE LITERAL SUBEXP START)" "replace-regexp-in-string" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/replace-regexp-in-string" nil nil)
                       ("rr" "(replace-regexp REGEXP$0 TO-STRING &optional DELIMITED START END)" "replace-regexp" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/replace-regexp" nil nil)
                       ("repeat" "(repeat $0 )" "repeat" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/repeat" nil nil)
                       ("rf" "(rename-file FILE$0 NEWNAME &optional OK-IF-ALREADY-EXISTS)" "rename-file" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/rename-file" nil nil)
                       ("re" "(region-end)" "region-end" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/region-end" nil nil)
                       ("rb" "(region-beginning)" "region-beginning" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/region-beginning" nil nil)
                       ("rap" "(region-active-p)" "region-active-p" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/region-active-p" nil nil)
                       ("rsf" "(re-search-forward REGEXP$0 &optional BOUND NOERROR COUNT)" "re-search-forward" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/re-search-forward" nil nil)
                       ("rsb" "(re-search-backward REGEXP$0 &optional BOUND NOERROR COUNT)" "re-search-backward" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/re-search-backward" nil nil)
                       ("put" "(put $0 PROPNAME VALUE)" "put" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/put" nil nil)
                       ("push" "(push $0 )" "push" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/push" nil nil)
                       ("progn" "(progn $0)" "progn" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/progn" nil nil)
                       ("print" "(print $0)" "print" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/print" nil nil)
                       ("princ" "(princ $0)" "princ" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/princ" nil nil)
                       ("pm" "(point-min)" "point-min" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/point-min" nil nil)
                       ("point-max" "(point-max)" "point-max" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/point-max" nil nil)
                       ("p" "(point)" "point" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/point" nil nil)
                       ("o" "(or $0 )" "or" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/or" nil nil)
                       ("nts" "(number-to-string $0)" "number-to-string" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/number-to-string" nil nil)
                       ("null" "(null $0)" "null" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/null" nil nil)
                       ("nth" "(nth N$0 LIST)" "nth" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/nth" nil nil)
                       ("n" "(not $0 )" "not" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/not" nil nil)
                       ("minor" "(defvar ${1:mode}-modeline-indicator \" ${2:INDICATOR}\"\n  \"call ($1-install-mode) again if this is changed\")\n\n(defvar $1-mode nil)\n(make-variable-buffer-local '$1-mode)\n(put '$1-mode 'permanent-local t)\n\n(defun $1-mode (&optional arg)\n  \"$0\"\n  (interactive \"P\")\n  (setq $1-mode\n        (if (null arg) (not $1-mode)\n          (> (prefix-numeric-value arg) 0)))\n  (force-mode-line-update))\n\n(provide '$1-mode)" "minor_mode" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/minor_mode" nil nil)
                       ("m" "(message \"FORMATSTRING$0\" &optional ARGS)" "message" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/message" nil nil)
                       ("memq" "(memq ELT$0 LIST)" "memq" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/memq" nil nil)
                       ("ms" "(match-string $0 )" "match-string" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/match-string" nil nil)
                       ("me" "(match-end N$0)" "match-end" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/match-end" nil nil)
                       ("mb" "(match-beginning N$0)" "match-beginning" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/match-beginning" nil nil)
                       ("mapcar" "(mapcar $0 )" "mapcar" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/mapcar" nil nil)
                       ("mapc" "(mapc '$0 SEQUENCE)" "mapc" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/mapc" nil nil)
                       ("mlv" "(make-local-variable $0)" "make-local-variable" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/make-local-variable" nil nil)
                       ("md" "(make-directory $0 &optional PARENTS)" "make-directory" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/make-directory" nil nil)
                       ("la" "(looking-at $0)" "looking-at" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/looking-at" nil nil)
                       ("list" "(list $0)" "list" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/list" nil nil)
                       ("lep" "(line-end-position)" "line-end-position" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/line-end-position" nil nil)
                       ("lbp" "(line-beginning-position)" "line-beginning-position" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/line-beginning-position" nil nil)
                       ("l" "(let ($1 )\n $0\n)" "let" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/let" nil nil)
                       ("length" "(length $0)" "length" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/length" nil nil)
                       ("lambda" "(lambda ($0) \"DOCSTRING\" (interactive) BODY)" "lambda" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/lambda" nil nil)
                       ("kb" "(kill-buffer $0)" "kill-buffer" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/kill-buffer" nil nil)
                       ("kbd" "(kbd \"$0\")" "kbd" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/kbd" nil nil)
                       ("interactive" "(interactive)" "interactive" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/interactive" nil nil)
                       ("ifc" "(insert-file-contents $0 &optional VISIT BEG END REPLACE)" "insert-file-contents" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/insert-file-contents" nil nil)
                       ("i" "(insert $0)" "insert" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/insert" nil nil)
                       ("if" "(if $0)" "if" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/if" nil nil)
                       ("hash" "make-hash-table ${1:options}" "hash" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/hash" nil nil)
                       ("grabthing" "(setq $0 (thing-at-point 'symbol))\n" "grab word under cursor" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/grabthing" nil nil)
                       ("grabstring" "(setq $0 (buffer-substring-no-properties myStartPos myEndPos))\n" "grab buffer substring" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/grabstring" nil nil)
                       ("gc" "(goto-char $0)" "goto-char" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/goto-char" nil nil)
                       ("gsk" "(global-set-key (kbd \"C-$0\") 'COMMAND)" "global-set-key" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/global-set-key" nil nil)
                       ("get" "(get SYMBOL$0 PROPNAME)" "get" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/get" nil nil)
                       ("function" "(function $0 )" "function" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/function" nil nil)
                       ("funcall" "(funcall $0)" "funcall" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/funcall" nil nil)
                       ("fl" "(forward-line $0 )" "forward-line" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/forward-line" nil nil)
                       ("fc" "(forward-char $0)" "forward-char" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/forward-char" nil nil)
                       ("format" "(format \"$0\" &optional OBJECTS)" "format" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/format" nil nil)
                       ("find-replace" "(defun replace-html-chars-region (start end)\n  \"Replace “<” to “&lt;” and other chars in HTML.\nThis works on the current region.\"\n  (interactive \"r\")\n  (save-restriction \n    (narrow-to-region start end)\n    (goto-char (point-min))\n    (while (search-forward \"&\" nil t) (replace-match \"&amp;\" nil t))\n    (goto-char (point-min))\n    (while (search-forward \"<\" nil t) (replace-match \"&lt;\" nil t))\n    (goto-char (point-min))\n    (while (search-forward \">\" nil t) (replace-match \"&gt;\" nil t))\n    )\n  )\n" "find and replace on region" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/find-replace" nil nil)
                       ("ff" "(find-file $0 )" "find-file" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/find-file" nil nil)
                       ("file.read-lines" "(defun read-lines (filePath)\n  \"Return a list of lines in FILEPATH.\"\n  (with-temp-buffer\n    (insert-file-contents filePath)\n    (split-string\n     (buffer-string) \"\\n\" t)) )\n\n;; process all lines\n(mapc \n (lambda (aLine) \n   (message aLine) ; do your stuff here\n   )\n (read-lines \"inputFilePath\")\n)" "read lines of a file" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/file.read-lines" nil nil)
                       ("file.process" "(defun doThisFile (fpath)\n  \"Process the file at path FPATH ...\"\n  (let ()\n    ;; create temp buffer without undo record or font lock. (more efficient)\n    ;; first space in temp buff name is necessary\n    (set-buffer (get-buffer-create \" myTemp\"))\n    (insert-file-contents fpath nil nil nil t)\n\n    ;; process it ...\n    ;; (goto-char 0) ; move to begining of file's content (in case it was open)\n    ;; ... do something here\n    ;; (write-file fpath) ;; write back to the file\n\n    (kill-buffer \" myTemp\")))\n" "a function that process a file" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/file.process" nil nil)
                       ("frn" "(file-relative-name $0 )" "file-relative-name" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/file-relative-name" nil nil)
                       ("fnse" "(file-name-sans-extension $0)" "file-name-sans-extension" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/file-name-sans-extension" nil nil)
                       ("fnn" "(file-name-nondirectory $0 )" "file-name-nondirectory" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/file-name-nondirectory" nil nil)
                       ("fne" "(file-name-extension $0 &optional PERIOD)" "file-name-extension" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/file-name-extension" nil nil)
                       ("fnd" "(file-name-directory $0)" "file-name-directory" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/file-name-directory" nil nil)
                       ("fboundp" "(fboundp '$0 )" "fboundp" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/fboundp" nil nil)
                       ("format" "(format \"$0\" &optional OBJECTS)" "format" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/f" nil nil)
                       ("efn" "(expand-file-name $0 )" "expand-file-name" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/expand-file-name" nil nil)
                       ("error" "(error \"$0\" &optional ARGS)" "error" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/error" nil nil)
                       ("equal" "(equal $0)" "equal" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/equal" nil nil)
                       ("eq" "(eq $0)" "eq" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/eq" nil nil)
                       ("eol" "(end-of-line)" "end-of-line" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/end-of-line" nil nil)
                       ("dolist" "(dolist $0 )" "dolist" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/dolist" nil nil)
                       ("dired.process_marked" ";; idiom for processing a list of files in dired's marked files\n \n;; suppose myProcessFile is your function that takes a file path\n;; and do some processing on the file\n\n(defun dired-myProcessFile ()\n  \"apply myProcessFile function to marked files in dired.\"\n  (interactive)\n  (require 'dired)\n  (mapc 'myProcessFile (dired-get-marked-files))\n)\n\n;; to use it, type M-x dired-myProcessFile\n" "process marked files in dired" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/dired.process_marked" nil nil)
                       ("df" "(directory-files $0 &optional FULL MATCH NOSORT)" "directory-files" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/directory-files" nil nil)
                       ("dr" "(delete-region $0 )" "delete-region" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/delete-region" nil nil)
                       ("df" "(delete-file $0)" "delete-file" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/delete-file" nil nil)
                       ("dd" "(delete-directory $0 &optional RECURSIVE)" "delete-directory" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/delete-directory" nil nil)
                       ("dc" "(delete-char $0)" "delete-char" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/delete-char" nil nil)
                       ("defvar" "(defvar $0 &optional ${1:initvalue} \"${2:docstring}\")" "defvar" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/defvar" nil nil)
                       ("def" "(defun ${1:fun} (${2:args})\n  ${3:(interactive${4: \"P\"})}\n  $0)" "defun" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/defun" nil nil)
                       ("defsubst" "(defsubst $0 )" "defsubst" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/defsubst" nil nil)
                       ("dk" "(define-key KEYMAPNAME$0 (kbd \"M-b\") 'FUNCNAME)" "define-key" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/define-key" nil nil)
                       ("defcustom" "(defcustom $0 VALUE \"DOC\" &optional ARGS)" "defcustom" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/defcustom" nil nil)
                       ("defalias" "(defalias 'SYMBOL$0 'DEFINITION &optional DOCSTRING)" "defalias" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/defalias" nil nil)
                       ("ca" "(custom-autoload$0 SYMBOL LOAD &optional NOSET)" "custom-autoload" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/custom-autoload" nil nil)
                       ("cb" "(current-buffer)" "current-buffer" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/current-buffer" nil nil)
                       ("cf" "(copy-file FILE$0 NEWNAME &optional OK-IF-ALREADY-EXISTS KEEP-TIME PRESERVE-UID-GID)" "copy-file" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/copy-file" nil nil)
                       ("cd" "(copy-directory $0 NEWNAME &optional KEEP-TIME PARENTS)" "copy-directory" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/copy-directory" nil nil)
                       ("consp" "(consp $0 )" "consp" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/consp" nil nil)
                       ("cons" "(cons $0)" "cons" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/cons" nil nil)
                       ("cc" "(condition-case $0 )" "condition-case" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/condition-case" nil nil)
                       ("cond" "(cond\n(CONDITION$0 BODY)\n(CONDITION BODY)\n)" "cond" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/cond" nil nil)
                       ("concat" "(concat $0)" "concat" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/concat" nil nil)
                       ("cdr" "(cdr $0)" "cdr" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/cdr" nil nil)
                       ("car" "(car $0)" "car" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/car" nil nil)
                       ("bsnp" "(buffer-substring-no-properties START$0 END)" "buffer-substring-no-properties" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/buffer-substring-no-properties" nil nil)
                       ("bs" "(buffer-substring START$0 END)" "buffer-substring" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/buffer-substring" nil nil)
                       ("bmp" "(buffer-modified-p $0)" "buffer-modified-p" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/buffer-modified-p" nil nil)
                       ("bfn" "(buffer-file-name)" "buffer-file-name" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/buffer-file-name" nil nil)
                       ("botap" "(bounds-of-thing-at-point '$0) ; symbol, list, sexp, defun, filename, url, email, word, sentence, whitespace, line, page ..." "bounds-of-thing-at-point" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/bounds-of-thing-at-point" nil nil)
                       ("bol" "(beginning-of-line)" "beginning-of-line" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/beginning-of-line" nil nil)
                       ("bc" "(backward-char $0)" "backward-char" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/backward-char" nil nil)
                       ("autoload" "(autoload 'FUNCNAME$0 \"FILENAME\" &optional \"DOCSTRING\" INTERACTIVE TYPE)" "autoload" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/autoload" nil nil)
                       ("assq" "(assq KEY$0 LIST)" "assq" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/assq" nil nil)
                       ("aset" "(aset ARRAY$0 IDX NEWELT)" "aset" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/aset" nil nil)
                       ("aref" "(aref ARRAY$0 INDEX)" "aref" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/aref" nil nil)
                       ("apply" "(apply $0 )" "apply" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/apply" nil nil)
                       ("append" "(append $0 )" "append" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/append" nil nil)
                       ("a" "(and $0)" "and" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/and" nil nil)
                       ("ah" "(add-hook HOOK$0 FUNCTION)" "add-hook" nil nil nil "/home/miguel/.emacs.d/snippets/emacs-lisp-mode/add-hook" nil nil)))


;;; Do not edit! File generated at Mon Aug  9 14:21:32 2021
