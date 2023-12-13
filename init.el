(require 'package)
(setq byte-compile-warnings '(cl-functions))

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

;; (add-to-list 'load-path "~/.emacs.d/codeium.el")
(load "ui.el")
(load "edicion.el")
(load "navegacion.el")
(load "lsp-support.el")
(load "setup-js.el")
(load "latex-setup.el")
(load "setup-org.el")
(load "terminal.el")
(load "setup-md.el")
(load "setup-sql.el")
;;(load "setup-py.el")
;;(load "setup-php.el")
(load "setup-clj.el")
;; (load "setup-codeium.el")




(setq exec-path (append exec-path '("~/.nvm/versions/node/v17.2.0/bin")))
;; (setq exec-path (append exec-path '()))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(codeium/metadata/api_key "3d06f00f-d24e-45a8-80f8-c4a78b76d6d7")
 '(company-show-quick-access t nil nil "Customized with use-package company")
 '(custom-safe-themes
   '("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))
 '(elpy-shell-use-project-root t)
 '(flycheck-checker-error-threshold 2000)
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.7 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(package-selected-packages
   '(lua-mode ng2-mode ditaa-mode quarto-mode codeium edit-indirect org-journal lsp-grammarly helm-xref dap-cpptools procress doom-modeline rainbow-mode beacon helm-tramp org-re-reveal helm-lsp dap-java lsp-java which-key dap-chrome dap-mode lsp-ui lsp-mode company magit-todos flyspell-correct-helm flyspell-correct flycheck-clj-kondo flycheck-clj-condo cider docker-compose-mode dockerfile-mode fzf dired-git-info js-mode pyvenv-auto python pyvenv oc tex modern-cpp-font-lock cpp-auto-include disaster plantuml-mode cmake-mode vterm clj-refactor helm-bufler bufler ob-http power-mode php-mode helm-ag olivetti npm anzu nyan-mode ob-restclient restclient org-ref transient forge auctex bibtex-completion org-tree-slide tramp-term org-bullets js-import rjsx-mode emmet-mode react-snippets prettier-js js-react-redux-yasnippets tern-auto-complete tern tide ag yasnippet nov resize-window helm-swoop ace-window hydra transpose-frame org-noter-pdftools org-pdftools pdf-tools helm-bibtex helm-projectile helm google-translate magit-gitflow magit dired-isearch smartparens paredit undo-tree isearch-dabbrev column-enforce-mode use-package rainbow-delimiters projectile dracula-theme dashboard all-the-icons-dired))
 '(safe-local-variable-values
   '((eval org-babel-ref-resolve "skeletons")
     (eval add-hook 'before-save-hook
           (lambda nil
             (org-babel-ref-resolve "process-export-filenames")))
     (eval org-babel-ref-resolve "export-setup")
     (org-export-initial-scope . buffer)))
 '(warning-suppress-log-types '((:warning)))
 '(warning-suppress-types '((use-package) (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
