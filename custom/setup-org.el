;;; package --- Summary
;;; Commentary:
;;; code:

;; Root of the org tree. `defvar' is deliberate: custom/local.el runs first and
;; may already have set this for the host, in which case this default is a
;; no-op. Expected layout underneath: agenda/ and roam/.
(defvar miguel/org-root "~/org/"
  "Directory containing the org files, agenda/ and roam/ subdirectories.")

;;;;;;;;;;;;;;;
;; Templates ;;
;;;;;;;;;;;;;;;

(use-package org-bullets :ensure t)
(use-package ob-restclient :ensure t)
(use-package ob-http :ensure t)
(use-package plantuml-mode :ensure t)

(let ((plantuml-path (expand-file-name "~/bin/plantuml.jar")))
  (when (file-exists-p plantuml-path)
    (setq plantuml-jar-path plantuml-path)
    (setq plantuml-default-exec-mode 'jar)))

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

(use-package org
  :custom
  (org-latex-listings t)
  (org-hide-emphasis-markers t)
  (org-log-done t)
  (org-directory miguel/org-root)
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
                   ("\\.pdf\\'" . default)
                   ("\\.djvu\\'" . "evince \"%s\"")
                   ("\\.djvu::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1")
                   (auto-mode . emacs)))
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
                        (sequence "INBOX(i)" "TODO(t@)" "NEXT(n@)" "STARTED(s@)" "WAITING(w@)" "|" "DONE(d@)" "DELEGATED(e@)" "CANCELED(c@)")
                        (sequence "PROJECT(p)" "SOMEDAY(o)" "|" "COMPLETED(C@)" "DROPPED(D@)")
                        (sequence "BUG(b)" "INVESTIGATING(I@)" "FIXING(f@)" "|" "FIXED(F@)" "WONTFIX(W@)")
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
  (org-plantuml-default-exec-mode 'jar)
  (org-ditaa-jar-path (expand-file-name "~/bin/ditaa.jar"))
  (org-latex-pdf-process '("latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))
  :init
  (let ((plantuml-path (expand-file-name "~/bin/plantuml.jar")))
    (when (file-exists-p plantuml-path)
      (setq org-plantuml-jar-path plantuml-path)))
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (with-eval-after-load 'org
    (add-to-list 'org-src-lang-modes '("plantuml" . plantuml)))
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

  :config
  (setq org-agenda-files
        (let ((agenda (expand-file-name "agenda" miguel/org-root)))
          (when (file-directory-p agenda)
            (directory-files-recursively agenda "\\.org$"))))
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
     (ditaa . t))))

(use-package org-tree-slide
  :ensure t
  :bind (("<f7>" . org-tree-slide-mode)
         ("S-<f7>" . org-tree-slide-skip-done-toggle)
         :map org-tree-slide-mode-map
         ("<f8>" . org-tree-slide-move-previous-tree)
         ("<f9>" . org-tree-slide-move-next-tree)))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename (expand-file-name "roam" miguel/org-root)))
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

(use-package ox-md
  :after org)
(with-eval-after-load 'ox
  (add-to-list 'org-export-backends 'md))

(use-package org-journal
  :ensure t)

(provide 'setup-org)
;;; setup-org.el ends here
