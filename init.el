(require 'package)

(add-to-list 'load-path "~/.emacs.d/custom/")
;; (add-to-list 'load-path "~/.emacs.d/site-lisp")
(setq user-full-name "Miguel Piña"
      user-mail-address "miguel_pinia@ciencias.unam.mx"
      package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("tromey" . "http://tromey.com/elpa/"))
      package-archive-priorities '(("org" . 100)
                                   ("melpa" . 80)
                                   ("melpa-stable" . 60)
                                   ("gnu" . 50)
                                   ("tromey" . 30)))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(defvar package-list '(use-package))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(load "ui.el")
(load "edicion.el")
(load "navegacion.el")
(load "setup-js.el")
(load "latex-setup.el")
(load "setup-org.el")
;; (load "terminal.el")
(load "setup-md.el")
(load "setup-py.el")
(load "setup-php.el")
(load "setup-clj.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-shell-use-project-root t)
 '(org-agenda-files
   '("~/Dropbox/org/phd/research/notes/queues.org" "/home/miguel/Dropbox/org/agenda/doctorado.org" "/home/miguel/Dropbox/org/agenda/interesante.org" "/home/miguel/Dropbox/org/agenda/prepa.org" "/home/miguel/Dropbox/org/agenda/tareas.org") nil nil "Customized with use-package org")
 '(org-format-latex-options
   '(:foreground default :background default :scale 2.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-image-actual-width '(300))
 '(package-selected-packages
   '(clj-refactor ac-cider helm-bufler bufler ob-http power-mode php-mode helm-ag olivetti npm anzu nyan-mode ob-restclient restclient org-ref transient forge elpy auctex bibtex-completion org-tree-slide tramp-term org-bullets js-import rjsx-mode emmet-mode react-snippets prettier-js js-react-redux-yasnippets tern-auto-complete tern tide ag yasnippet nov resize-window helm-swoop ace-window hydra transpose-frame org-noter-pdftools org-pdftools pdf-tools helm-bibtex helm-projectile helm google-translate magit-gitflow magit dired-isearch smartparens paredit auto-complete undo-tree isearch-dabbrev column-enforce-mode use-package rainbow-delimiters projectile dracula-theme dashboard all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
