(require 'package)
(require 'warnings)
(setq byte-compile-warnings '(cl-functions))

;; Load helm-core early to fix autoload issues
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'helm-core)
  (package-install 'helm-core))
(require 'helm-core)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'load-path "~/.emacs.d/custom/")
;; (add-to-list 'load-path "~/.emacs.d/site-lisp")

;; Disable LSP in org directories
(defun disable-lsp-in-org-dirs ()
  "Disable LSP mode in org directories."
  (when (and buffer-file-name
             (string-match-p "/org/" buffer-file-name))
    (setq-local lsp-disabled-clients '(ts-ls typescript-language-server eslint))))

;; Disable tide in org directories
(defun disable-tide-in-org-dirs ()
  "Disable tide in org directories."
  (when (and buffer-file-name
             (string-match-p "/org/" buffer-file-name))
    (setq-local tide-mode nil)))

(add-hook 'find-file-hook 'disable-lsp-in-org-dirs)
(add-hook 'find-file-hook 'disable-tide-in-org-dirs)

(setq user-full-name "Miguel Piña"
      user-mail-address "mangelpa@amazon.com"
      package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa"        . "https://melpa.org/packages/")
                         ("org"          . "http://orgmode.org/elpa/")
                         ("gnu"          . "https://elpa.gnu.org/packages/")
                         ("tromey"       . "http://tromey.com/elpa/")
                         ("nongnu"       . "https://elpa.nongnu.org/nongnu/"))
      package-archive-priorities '(("org"          . 100)
                                   ("melpa"        . 60)
                                   ("melpa-stable" . 80)
                                   ("nongnu"       . 80)
                                   ("gnu"          . 50)
                                   ("tromey"       . 30)))

(setq warning-minimum-level :error
      warning-suppress-log-types '((:warning)))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(defvar package-list '(use-package))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(add-to-list 'load-path "~/.emacs.d/custom/")
;;(load "test.el")
(load "setup-org.el")
(load "amazon.el")
(load "ui.el")
(load "edicion.el")
(load "navegacion.el")
(load "terminal.el")
(load "lsp-support.el")
(load "setup-js.el")
(load "latex-setup.el")
(load "setup-md.el")
(load "setup-sql.el")
(load "setup-py.el")
(load "setup-cpp.el")
;;(load "setup-php.el")
(load "setup-clj.el")




(setq exec-path (append exec-path '("~/.local/share/nvm/v18.20.8/bin")))
;; (setq exec-path (append exec-path '()))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-show-quick-access nil nil nil "Customized with use-package company")
 '(custom-safe-themes
   '("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223"
     "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa"
     default))
 '(elpy-shell-use-project-root t)
 '(flycheck-checker-error-threshold 2000)
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.7 :html-foreground
                 "Black" :html-background "Transparent" :html-scale
                 1.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(package-selected-packages nil)
 '(safe-local-variable-values
   '((eval org-babel-ref-resolve "skeletons")
     (eval add-hook 'before-save-hook
           (lambda nil
             (org-babel-ref-resolve "process-export-filenames")))
     (eval org-babel-ref-resolve "export-setup")
     (org-export-initial-scope . buffer)))
 '(tramp-term-host-shells '(("cloud" . bash)))
 '(tramp-verbose 1)
 '(remote-file-name-inhibit-cache nil)
 '(tramp-completion-reread-directory-timeout nil)
 '(warning-suppress-log-types '((:error)))
 '(warning-suppress-types '((emacs) (use-package) (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:extend t :background "gray40"))))
 '(region ((t (:extend t :background "purple2" :foreground "grey100" :weight bold)))))
