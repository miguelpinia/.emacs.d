;;; package --- Summary
;;; Commentary:
;;; code:

;;;;;;;;;;;;;;;
;; Templates ;;
;;;;;;;;;;;;;;;

(require 'pdf-tools)
(require 'doc-view)

(use-package org-bullets :ensure t)
(use-package ob-restclient :ensure t)
(use-package ob-http :ensure t)
(use-package plantuml-mode :ensure t)

(setq plantuml-jar-path "~/bin/plantuml.jar")
;; (setq org-plantuml-jar-path "~/bin/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)


;; Improved task template following GTD principles:
;; - Context tags for better filtering
;; - Priority levels for focus
;; - Effort estimation for time blocking
;; - Optional deadline separate from scheduling
;; 1. Starts with INBOX - Follows your new workflow for quick capture
;; 2. Context property - Enables GTD-style context filtering (@computer, @phone, etc.)
;; 3. Better effort estimates - More realistic time blocks starting with 15min
;; 4. Next Actions section - Forces you to think of concrete first steps
;; 5. LOGBOOK drawer - Better time tracking organization
;; 6. Notes section - Space for additional context and updates
;; 7. Cleaner structure - Proper heading levels and organization
;; The LOGBOOK drawer is Org-mode's built-in system for tracking time and state changes. Here's how it works and why it's valuable:
;; ## What LOGBOOK Does
;; Automatic tracking:
;; • State changes (TODO → STARTED → DONE) with timestamps
;; • Time clocking (when you clock in/out with C-c C-x C-i/C-o)
;; • Notes added during state transitions (when using @ in keywords)
;; Example of what gets logged:
;; :LOGBOOK:
;; - State "DONE"       from "STARTED"    [2025-10-21 Tue 14:30]
;; - State "STARTED"    from "TODO"       [2025-10-21 Tue 09:15]
;; CLOCK: [2025-10-21 Tue 09:15]--[2025-10-21 Tue 14:30] =>  5:15
;; - Note taken on [2025-10-21 Tue 14:30] \\
;;   Completed after resolving API timeout issues
;; :END:
;; ## Key Benefits
;; 1. Time tracking - See exactly how long tasks take
;; 2. Progress history - Track when things got stuck or moved forward
;; 3. Learning - Improve time estimates based on actual data
;; 4. Accountability - Clear record of work done
;; 5. Context switching - Notes capture why you stopped/started
;; ## Useful Commands
;; • C-c C-x C-i - Clock in (start timing)
;; • C-c C-x C-o - Clock out (stop timing)
;; • C-c C-x C-d - Display time spent
;; • C-c C-x C-r - Generate clock report
;; The empty LOGBOOK drawer in the template ensures Org-mode has a designated place for this tracking, keeping your task structure clean while capturing valuable productivity data automatically.

;; The LOGBOOK drawer is Org-mode's built-in system for tracking time and state changes. Here's how it works and why it's valuable:

;; ## What LOGBOOK Does

;; Automatic tracking:
;; • State changes (TODO → STARTED → DONE) with timestamps
;; • Time clocking (when you clock in/out with C-c C-x C-i/C-o)
;; • Notes added during state transitions (when using @ in keywords)

;; Example of what gets logged:
;; :LOGBOOK:
;; - State "DONE"       from "STARTED"    [2025-10-21 Tue 14:30]
;; - State "STARTED"    from "TODO"       [2025-10-21 Tue 09:15]
;; CLOCK: [2025-10-21 Tue 09:15]--[2025-10-21 Tue 14:30] =>  5:15
;; - Note taken on [2025-10-21 Tue 14:30] \\
;;   Completed after resolving API timeout issues
;; :END:


;; ## Key Benefits

;; 1. Time tracking - See exactly how long tasks take
;; 2. Progress history - Track when things got stuck or moved forward
;; 3. Learning - Improve time estimates based on actual data
;; 4. Accountability - Clear record of work done
;; 5. Context switching - Notes capture why you stopped/started

;; ## Useful Commands

;; • C-c C-x C-i - Clock in (start timing)
;; • C-c C-x C-o - Clock out (stop timing)
;; • C-c C-x C-d - Display time spent
;; • C-c C-x C-r - Generate clock report

;; The empty LOGBOOK drawer in the template ensures Org-mode has a designated place for this tracking, keeping your task structure clean while capturing valuable productivity data automatically.

;; > How will be state change sequence considering last states added to the configuration?

;; > Based on your improved TODO keyword configuration, here are the typical state change sequences:

;; ## Main Task Flow
;; INBOX → TODO → NEXT → STARTED → DONE
;;   ↓       ↓       ↓       ↓
;;   ↓       ↓       ↓    WAITING → STARTED → DONE
;;   ↓       ↓    CANCELED
;;   ↓    DELEGATED
;; CANCELED


;; ## Project Flow
;; PROJECT → COMPLETED
;;    ↓
;; DROPPED


;; ## Bug/Issue Flow
;; BUG → INVESTIGATING → FIXING → FIXED
;;  ↓         ↓           ↓
;;  ↓         ↓        WONTFIX
;;  ↓      WONTFIX
;; WONTFIX


;; ## Idea Flow
;; IDEA → IMPLEMENTED
;;   ↓
;; REJECTED


;; ## LOGBOOK Examples

;; Typical task progression:
;; :LOGBOOK:
;; - State "DONE"       from "STARTED"      [2025-10-21 Tue 15:30]
;; - State "STARTED"    from "NEXT"         [2025-10-21 Tue 14:15]
;; - State "NEXT"       from "TODO"         [2025-10-21 Tue 09:00]
;; - State "TODO"       from "INBOX"        [2025-10-21 Tue 08:45]
;; :END:


;; With waiting state:
;; :LOGBOOK:
;; - State "DONE"       from "STARTED"      [2025-10-21 Tue 16:00]
;; - State "STARTED"    from "WAITING"      [2025-10-21 Tue 15:45]
;; - Note taken on [2025-10-21 Tue 15:45] \\
;;   Got approval from manager, proceeding
;; - State "WAITING"    from "STARTED"      [2025-10-21 Tue 10:30]
;; - Note taken on [2025-10-21 Tue 10:30] \\
;;   Waiting for manager approval on approach
;; :END:


;; The @ symbols in keywords like WAITING(w@) and DONE(d@) will prompt you for notes during state changes, creating rich context in your LOGBOOK.

(defvar my/org-basic-task-template
  "* INBOX %?
SCHEDULED: %^t
:PROPERTIES:
:Effort: %^{Effort|0:15|0:30|1:00|2:00|4:00|8:00}
:Context: %^{Context|@lydia|@ppas|@charon|@home|@office|@lydia-installments}
:END:
:LOGBOOK:
:END:

%^{Description}

** Next Actions:
- [ ] %^{First concrete step}

** Notes:
" "Improved basic task template with GTD structure.")




;; (defvar my/org-basic-task-template
;;   "***** TODO %?
;;    SCHEDULED: %^t
;;    :PROPERTIES:
;;    :Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}
;;    :END:
;;    %^{Descripcion}
;; " "Basic task data.")

(defvar my/org-basic-item-template "[ ] %^{Descripcion}")
(defvar my/org-basic-note-template "* %?\n\n%i\n")
(defvar my/org-basic-english-template
  "* TODO %?
%U
%^{Descripcion}")

(defvar my/org-basic-lecture-template "

***** %^{Lecture title}
      Date: %U
      Author: %^{Author name}
      Topic: %^{Topic}
      [[%%^{Link}][Source link]]
      Notes:
      %?

")

(defun miguel/buffer-mode (buffer-or-string)
  "Return the major mode associated with the buffer BUFFER-OR-STRING."
  (with-current-buffer buffer-or-string
    major-mode))



(defun miguel/docview-buffer-scroll-down ()
  "Docview-buffer-scroll-down.

  There are two visible buffers, one for taking notes and one for displaying
  PDF, and the focus is on the notes buffer.  This command moves the PDF buffer
  forward."
  (interactive)
  (other-window 1)
  (if (eq 'pdf-view-mode (miguel/buffer-mode (current-buffer)))
      (progn (pdf-view-previous-line-or-previous-page 1)
             (other-window 1))
    (other-window 1)))

(defun miguel/docview-buffer-scroll-up ()
  "Docview-buffer-scroll-up.

  There are two visible buffers, one for taking notes and one for displaying
  PDF, and the focus is on the notes buffer.  This command moves the PDF buffer
  backward."
  (interactive)
  (other-window 1)
  (if (eq 'pdf-view-mode (miguel/buffer-mode (current-buffer)))
      (progn (pdf-view-next-line-or-next-page 1)
             (other-window 1))
    (other-window 1)))

(setq doc-view-continuous t)

(use-package org
  :bind (:map org-mode-map
              ("C-j" . 'miguel/docview-buffer-scroll-down)
              ("C-k" . 'miguel/docview-buffer-scroll-up))
  :custom
  (org-latex-listings t)
  (org-hide-emphasis-markers t)
  (org-log-done t)
  (org-directory "~/amazon/org/")
  (org-confirm-babel-evaluate nil)
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t)
  (org-ellipsis "▼")
  (org-image-actual-width nil)
  (org-babel-clojure-backend 'cider)
  (org-hide-emphasis-markers t)
  (org-adapt-indentation t)
  (org-file-apps '(("\\.docx\\'" . default)
                   ("\\.mm\\'" . default)
                   ("\\.x?html?\\'" . default)
                   ("\\.pdf\\'" . (lambda (file link)
                                    (org-pdftools-open link)))
                   ("\\.djvu\\'" . "evince \"%s\"")
                   ("\\.djvu::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1")
                   (auto-mode . emacs)))
  (org-link-abbrev-alist '(("bib" . "~/Dropbox/org/phd/research/refs.bib::%s")
                           ("notes" . "~/Dropbox/org/doctorado.org::#%s")
                           ("papers" . "~/Dropbox/org/phd/research/papers/%s.pdf")))
  (org-todo-keyword-faces '(("INBOX"         . "gray")
                            ("NEXT"          . "orange")
                            ("STARTED"       . "DeepSkyBlue")
                            ("WAITING"       . "yellow")
                            ("PROJECT"       . "purple")
                            ("SOMEDAY"       . "lightgray")
                            ("BUG"           . "red")
                            ("INVESTIGATING" . "orange")
                            ("FIXING"        . "yellow")
                            ("IDEA"          . "lightblue")))
  (org-todo-keywords  '(
                        ;;   Main Task Flow (GTD-inspired):
                        ;; • INBOX - Capture everything first (GTD principle)
                        ;; • TODO - Clarified and actionable items
                        ;; • NEXT - Next actions to focus on (GTD's "Next Actions" list)
                        ;; • STARTED - Currently working on
                        ;; • WAITING - Blocked/waiting for others (with note tracking)
                        (sequence "INBOX(i)" "TODO(t@)" "NEXT(n@)" "STARTED(s@)" "WAITING(w@)" "|" "DONE(d@)" "DELEGATED(e@)" "CANCELED(c@)")
                        ;; Project Management:
                        ;; • PROJECT - Multi-step outcomes
                        ;; • SOMEDAY - Maybe/someday items (GTD's "Someday/Maybe")
                        (sequence "PROJECT(p)" "SOMEDAY(o)" "|" "COMPLETED(C@)" "DROPPED(D@)")
                        ;; Bug/Issue Tracking:
                        ;; • BUG → INVESTIGATING → FIXING → FIXED/WONTFIX
                        (sequence "BUG(b)" "INVESTIGATING(I@)" "FIXING(f@)" "|" "FIXED(F@)" "WONTFIX(W@)")
                        ;;                         Ideas/Innovation:
                        ;; • IDEA → IMPLEMENTED/REJECTED
                        (sequence "IDEA(a)" "|" "IMPLEMENTED(m@)" "REJECTED(r@)")))
  (org-capture-templates  `(("t" "tareas" entry
                             (file+olp+datetree ,(concat org-directory "agenda/tareas.org") "Tareas")
                             ,my/org-basic-task-template)
                            ("p" "prepa" entry
                             (file+olp+datetree ,(concat org-directory "agenda/prepa.org") "Tareas")
                             ,my/org-basic-task-template)
                            ("l" "Lectures" entry
                             (file+olp+datetree ,(concat org-directory "agenda/lectures.org") "Lecturas")
                             ,my/org-basic-lecture-template)
                            ("d" "Tareas doctorado" entry
                             (file+olp+datetree ,(concat org-directory "agenda/doctorado.org") "Tareas Doctorado")
                             ,my/org-basic-task-template
                             :tree-type week)
                            ("id" "item doctorado" checkitem
                             (file+headline ,(concat org-directory "agenda/doctorado.org" "Tareas rápidas"))
                             ,my/org-basic-item-template)
                            ("m" "correo" entry
                             (file+olp+datetree ,(concat org-directory "agenda/tareas.org") "Tareas")
                             "* TODO [#A] %a\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%?\n")
                            ("i" "Tarea inglés" entry
                             (file+olp+datetree ,(concat org-directory "agenda/ingles.org") "Tareas")
                             ,my/org-basic-english-template)
                            ("n" "Daily note" table-line
                             (file+olp ,(concat org-directory "agenda/organizador.org") "Notas")
                             "| %u | %^{Note} |"
                             :immediate-finish t)))
  (org-plantuml-jar-path (expand-file-name "~/bin/plantuml.jar"))
  (org-plantuml-default-exec-mode 'jar)
  (org-ditaa-jar-path (expand-file-name "~/bin/ditaa.jar"))
  (org-mu4e-link-query-in-headers-mode nil)
  (org-mu4e-convert-to-html t)
  (org-latex-pdf-process '("latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))
  :init
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (customize-set-variable 'org-agenda-prefix-format '((agenda . " %-12c %?-18t% s")
                                                      (timeline . "  % s")
                                                      (todo . " %i %-12:c")
                                                      (tags . " %i %-12:c")
                                                      (search . " %i %-12:c")))
  (customize-set-variable 'org-agenda-todo-keyword-format "%-10s")
  (customize-set-variable 'org-agenda-scheduled-leaders
                          '("[S] : " "[S] x%3d d.: "))
  (customize-set-variable 'org-agenda-deadline-leaders
                          '("[D] : " "[D] +%3d d.: " "[D] -%3d d.: "))
  (customize-set-variable 'org-agenda-time-grid
                          '((today require-timed remove-match)
                            (000 1200 2400)
                            ":  " "┈┈┈┈┈┈┈┈┈┈┈┈┈"))
  (setq org-agenda-skip-scheduled-if-deadline-is-shown t)
  (add-to-list
   'org-agenda-custom-commands
   '("w" "THIS WEEK"
     ((agenda ""
              ((org-agenda-overriding-header
                (concat "THIS WEEK (W" (format-time-string "%V") ")")))))))
  (add-to-list
   'org-agenda-custom-commands
   '("d" "DAY'S AGENDA"
     ((agenda ""
              ((org-agenda-overriding-header
                (concat "TODAY (W" (format-time-string "%V") ")"))
               (org-agenda-span 'day)
               (org-agenda-sorting-strategy
                '((agenda time-up priority-down category-keep)))
               (org-agenda-show-log t)
               (org-agenda-log-mode-items '(clock)))))))

  (customize-set-variable 'org-agenda-current-time-string "ᐊ┈┈┈┈┈┈┈┈ now")
  (defun my-org-hooks ()
    "My hooks for org mode."
    ;; Override Dracula theme for org-block faces
    (with-eval-after-load 'org-faces
      (set-face-attribute 'org-block nil
                          :background "#3a3c4e")
      ;; (set-face-attribute 'org-block nil
      ;;                     :background "#3a3c4e"
      ;;                     :box '(:line-width 5 :color "#6272a4"))
      ;; (set-face-attribute 'org-block-background
      ;;                     :background "#6272a4")
      (set-face-attribute 'org-block-begin-line nil
                          :overline "#6272a4"
                          :underline "#6272a4" :foreground "#8be9fd" :background "#2f3349"
                          )
      (set-face-attribute 'org-block-end-line nil
                          :overline "#6272a4" :foreground "#8be9fd" :background "#2f3349"))

    (yas-minor-mode 1)
    (column-enforce-mode 1)
    (org-bullets-mode 1)
    ;; (turn-on-org-cdlatex)
    (set-fill-column 80)
    (flyspell-mode 1)
    (auto-fill-mode 1))
  (add-hook 'org-capture-mode-hook 'hide-lat-num)
  (add-hook 'org-agenda-mode-hook 'hide-lat-num)
  (add-hook 'org-mode-hook 'my-org-hooks)
  (add-hook 'org-mode-hook 'org-mode-reftex-setup)
  (defun org-mode-reftex-search ()
    "Jump to the notes for the paper pointed to at from reftex search."
    (interactive)
    (org-link-open-from-string
     (format "[[notes:%s]]"
             (car
              (reftex-citation t)))))
  (defun org-mode-reftex-setup ()
    "Configura reftex en org mode."
    (load-library "reftex")
    (and (buffer-file-name) (file-exists-p (buffer-file-name))
         (progn
           ;; enable auto-revert-mode to update reftex when bibtex file changes on disk
           (global-auto-revert-mode t)
           (reftex-parse-all)
           ;;add a custom reftex cite format to insert links
           (reftex-set-cite-format
            '((?b . "[[bib:%l][%l-bib]]")
              (?n . "[[notes:%l][%l-notes]]")
              (?p . "[[papers:%l][%l-paper]]")
              (?t . "%t")
              (?h . "*** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")))))
    (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
    (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))

  :config
  (setq org-agenda-files (directory-files-recursively "~/amazon/org/agenda" "\\.org$"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t)
     (latex . t)
     (sql . t)
     (java . t)
     (python . t)
     (plantuml . t)
     (C . t)
     (clojure . t)
     (R . t)
     (shell . t)
     (restclient . t)
     (http . t)
     (emacs-lisp . t)
     (markdown . t)
     (sql . t)
     (ditaa . t))))


(use-package org-ref
  :ensure t
  :after org
  :demand t
  :custom
  (org-ref-default-bibliography '("~/Dropbox/org/phd/research/refs.bib"))
  (org-ref-bibliography-notes "~/Dropbox/org/phd/research/notes/notes.org")
  (org-ref-pdf-directory "~/Dropbox/org/phd/research/papers/")
  :bind
  (("C-c C-o" . org-ref-open-pdf-at-point)
   ("C-c p" . helm-bibtex)))

(use-package org-tree-slide
  :ensure t
  :bind (("<f7>" . org-tree-slide-mode)
         ("S-<f7>" . org-tree-slide-skip-done-toggle)
         :map org-tree-slide-mode-map
         ("<f8>" . org-tree-slide-move-previous-tree)
         ("<f9>" . org-tree-slide-move-next-tree)))

(use-package org-re-reveal
  :ensure t)


(setq )

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/amazon/org/roam/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (setq org-roam-node-display-template     (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag))
        org-roam-mode-sections             (list #'org-roam-backlinks-section
                                                 #'org-roam-reflinks-section)
        org-roam-dailies-directory         "daily/"
        org-roam-dailies-capture-templates '(("e" "Daily Log Entry" entry
                                              "** %<%I:%M %p>: %?"
                                              :target (file+head+olp "%(format-time-string \"%Y-%m-%d\").org"
                                                                     "#+title: %(format-time-string \"%Y-%m-%d\")\n\n* Focus\n\n* Tasks\n\n* Journal"
                                                                     ("Journal")))

                                             ("l" "Daily Log Entry custom" entry "** %<%I:%M %p>: %?"
                                              :target (file+head+olp "%<%Y-%m-%d>.org"
                                                                     "#+title: %<%Y-%m-%d>\\n\n Long\n:PROPERTIES:\nVISIBILITY: children\n:END:\n#+FILETAGS: daily\n\n* Focus\n\n* Tasks\n\n* Journal"
                                                                     ("%^{Type node}"))
                                              :unnarrowed t)
                                             ("d" "day-entry" entry
	                                          "* %<%d-%m-%Y> \n\n%?"
	                                          :target (file+datetree "%<%Y>.org" month)
	                                          :empty-lines 1
	                                          :unnarrowed t
	                                          :jump-to-captured t)
                                             ))
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol)
  (require 'org-roam-dailies))

;; ("d" "default" entry
;;                                               "* %<%H:%M> %?"
;;                                               :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n")
;;                                               :unnarrowed t)
;; ;; (let ((head "#+title: %<%Y-%m-%d (%A)>\n#+startup: showall\n* [/] Do Today\n* [/] Maybe Do Today\n* Journal\n"))
;; ;;   `(("j" "journal" entry
;; ;;      #'org-roam-capture--get-point
;; ;;      "* %<%H:%M> %?"
;; ;;      ;; :target (file "%<%Y-%m-%d>.org")
;; ;;      :file-name (file "%<%Y-%m-%d>.org")
;; ;;      :head ,head
;; ;;      :olp ("Journal"))
;; ;;     ("t" "do today" item
;; ;;      #'org-roam-capture--get-point
;; ;;      "[ ] %(princ as/agenda-captured-link)"
;; ;;      :file-name "daily/%<%Y-%m-%d>"
;; ;;      :head ,head
;; ;;      :olp ("Do Today")
;; ;;      :immediate-finish t)
;; ;;     ("m" "maybe do today" item
;; ;;      #'org-roam-capture--get-point
;; ;;      "[ ] %(princ as/agenda-captured-link)"
;; ;;      :file-name "daily/%<%Y-%m-%d>"
;; ;;      :head ,head
;; ;;      :olp ("Maybe Do Today")
;; ;;      :immediate-finish t)))


(use-package org-roam-ui
  :ensure t
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme         t
        org-roam-ui-follow             t
        org-roam-ui-update-on-save     t
        org-roam-ui-open-on-start      t
        org-roam-node-display-template (concat "${title:*}" (propertize "${tags:10}" 'face 'org-tag)))
  ;; :bind (("C-c n u" . org-roam-ui-mode))
  )

(use-package ox-md
  :after org)
(setq org-export-backends (cons 'ox-md org-export-backends))

;; (use-package org-roam
;;   :ensure t
;;   :custom
;;   (org-roam-directory (file-truename "~/amazon/org/roam/"))
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n i" . org-roam-node-insert))
;;   )

;; (use-package org-roam
;;   :ensure t
;;   :custom
;;   (org-roam-directory (file-truename "~/amazon/org/roam/"))
;;   (org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
;;   :init
;;   (defun org-roam-node-insert-immediate (arg &rest args)
;;     (interactive "P")
;;     (let ((args (cons arg args))
;;           (org-roam-capture-templates (list (append (car org-roam-capture-templates)
;;                                                     '(:immediate-finish t)))))
;;       (apply #'org-roam-node-insert args)))

;;   (defun my/org-roam-filter-by-tag (tag-name)
;;     (lambda (node)
;;       (member tag-name (org-roam-node-tags node))))
;;   (defun my/org-roam-list-notes-by-tag (tag-name)
;;     (mapcar #'org-roam-node-file
;;             (seq-filter
;;              (lambda (node)
;;                (member tag-name (org-roam-node-tags node)))
;;              (my/org-roam-filter-by-tag tag-name))))
;;   '(org-roam-db-autosync-mode)
;;   ;; If using org-roam-protocol
;;   (require 'org-roam-protocol)
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n g" . org-roam-graph)
;;          ("C-c n i" . org-roam-node-insert)
;;          ("C-c n c" . org-roam-capture)
;;          ("C-c n j" . org-roam-dailies-capture-today)
;;          ("C-c n I" . org-roam-node-insert-immediate)))




;; (use-package lsp-grammarly
;;   :ensure t
;;   :hook ((org-mode . (lambda ()
;;                        (require 'lsp-grammarly)
;;                        (lsp)))
;;          (LaTeX-mode . (lambda ()
;;                          (require 'lsp-grammarly)
;;                          (lsp)))))

(use-package org-journal
  :ensure t)



;; (use-package org-roam-db-autosync-mode
;;   :ensure t
;;   :after org-roam)



(provide 'setup-org)
;;; setup-org.el ends here
