(require 'package)

(add-to-list 'load-path "~/.emacs.d/custom/")
(setq user-full-name "Miguel Piña"
      user-mail-address "miguel_pinia@ciencias.unam.mx"
      package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("tromey" . "http://tromey.com/elpa/"))
      package-archive-priorities '(("melpa-stable" . 100)
                                   ("org" . 60)
                                   ("melpa" . 60)
                                   ("gnu" . 50)
                                   ("tromey" . 30)
                                   ("marmalade" . 20)))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-pdfview magit-gitflow magit nov helm-swoop resize-window hydra transpose-frame ace-window org-noter-pdftools org-pdftools pdf-tools use-package undo-tree smartparens rainbow-delimiters paredit isearch-dabbrev helm-projectile google-translate dracula-theme dired-isearch dashboard auto-complete all-the-icons-dired))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
