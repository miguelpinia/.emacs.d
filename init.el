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
(load "setup-js.el")
(load "setup-org.el")
(load "terminal.el")
