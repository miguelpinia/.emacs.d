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

(defvar my/org-basic-task-template
  "***** TODO %?
   SCHEDULED: %^t
   :PROPERTIES:
   :Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}
   :END:
   %^{Descripcion}
" "Basic task data.")

(defvar my/org-basic-item-template "[ ] %^{Descripcion}")
(defvar my/org-basic-note-template "* %?\n\n%i\n")
(defvar my/org-basic-english-template
  "* TODO %?
%U
%^{Descripcion}")

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
  (org-directory "~/Dropbox/org/")
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
  (org-agenda-files '("~/Dropbox/org/agenda/"))
  (org-todo-keyword-faces '(("PREVERIFY" . "yellow")
                            ("FEEDBACK" . "yellow")
                            ("VERIFY" . "blue")
                            ("STARTED" . "DeepSkyBlue")
                            ("ASIGNED" . "green")
                            ("WAIT" . "yellow")))
  (org-todo-keywords  '((sequence "TODO(t)" "STARTED(s)" "FEEDBACK(f@)" "WAIT(w@)"
                                  "PREVERIFY(p)" "VERIFY(v@)" "|" "DONE(d@)" "DELEGATED(e@)")
                        (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(o@)")
                        (sequence "|" "CANCELED(c@)")))
  (org-capture-templates  `(("t" "tareas" entry
                             (file+olp+datetree ,(concat org-directory "agenda/tareas.org") "Tareas")
                             ,my/org-basic-task-template)
                            ("p" "prepa" entry
                             (file+olp+datetree ,(concat org-directory "agenda/prepa.org") "Tareas")
                             ,my/org-basic-task-template)
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
  (org-ditaa-jar-path (expand-file-name "~/bin/ditaa.jar"))
  (org-mu4e-link-query-in-headers-mode nil)
  (org-mu4e-convert-to-html t)
  (org-latex-pdf-process '("latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))
  :init
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (defun my-org-hooks ()
    "My hooks for org mode."
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


(provide 'setup-org)
;;; setup-org.el ends here
