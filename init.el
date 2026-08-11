(require 'package)
(require 'warnings)
(setq byte-compile-warnings '(cl-functions))

(add-to-list 'load-path "~/.emacs.d/custom/")

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
      user-mail-address "miguel_pinia@ciencias.unam.mx"
      package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa"        . "https://melpa.org/packages/")
                         ("gnu"          . "https://elpa.gnu.org/packages/")
                         ("nongnu"       . "https://elpa.nongnu.org/nongnu/"))
      package-archive-priorities '(("melpa"        . 60)
                                   ("melpa-stable" . 80)
                                   ("nongnu"       . 80)
                                   ("gnu"          . 50)))

(setq warning-minimum-level :error
      warning-suppress-log-types '((:warning)))

;; straight.el bootstrap (for packages not available from an ELPA archive)
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

(require 'use-package)
(setq use-package-always-defer t)

;; Ensure compat-31 is loaded for packages requiring Emacs 31 features
(straight-use-package 'compat)
(require 'compat)

;; Machine-local configuration (gitignored, optional).
;;
;; Loaded before the modules so it can define host-specific values they consume
;; (for example `miguel/org-root'), and set up internal-only packages. Settings
;; that must override a module use `with-eval-after-load' inside that file.
(let ((local (expand-file-name "custom/local.el" user-emacs-directory)))
  (when (file-exists-p local)
    (load local nil 'nomessage)))

;; Module loads
(load "setup-org.el")
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
(load "setup-clj.el")

(setq exec-path (append exec-path '("~/.local/share/nvm/v18.20.8/bin")))

(menu-bar-mode -1)

(custom-set-variables
 '(company-show-quick-access nil nil nil "Customized with use-package company")
 '(custom-safe-themes
   '("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223"
     "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa"
     default))
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
 '(warning-suppress-log-types '((:error)))
 '(warning-suppress-types '((emacs) (use-package) (use-package))))
(custom-set-faces
 '(hl-line ((t (:extend t :background "#2f2f2f"))))
 '(region ((t (:extend t :background "purple2" :foreground "grey100" :weight bold)))))

;; When running as daemon, C-x C-c disconnects the client instead of killing the daemon
(when (daemonp)
  (global-set-key (kbd "C-x C-c") #'delete-frame))

;; Handle terminal focus events to prevent OI insertion when switching tabs
(defun my/setup-terminal-focus-events ()
  "Map terminal focus escape sequences so they don't insert OI."
  (when (not (display-graphic-p))
    (define-key input-decode-map "\e[I" [focus-in])
    (define-key input-decode-map "\e[O" [focus-out])))
(add-hook 'tty-setup-hook #'my/setup-terminal-focus-events)
(define-key global-map [focus-in] #'ignore)
(define-key global-map [focus-out] #'ignore)

;; Explicitly disable terminal focus reporting (mode 1004) so iTerm2 stops
;; sending \e[I/\e[O sequences that race with the decode map during fast
;; tmux popup open/close cycles.
(defun my/disable-terminal-focus-reporting (frame)
  "Send mode 1004 disable to the terminal for FRAME."
  (when (frame-parameter frame 'tty)
    (send-string-to-terminal "\e[?1004l" (frame-terminal frame))))
(dolist (frame (frame-list))
  (my/disable-terminal-focus-reporting frame))
(add-hook 'after-make-frame-functions #'my/disable-terminal-focus-reporting)

;; OSC 52 clipboard integration for terminal/daemon
(unless (display-graphic-p)
  (setq xterm-set-window-title nil)
  (defun my/osc52-copy (text)
    "Copy TEXT to system clipboard via OSC 52."
    (let* ((encoded (base64-encode-string (encode-coding-string text 'utf-8) t))
           (seq (concat "\e]52;c;" encoded "\a")))
      (if (frame-parameter nil 'tty)
          (send-string-to-terminal seq (frame-terminal))
        (dolist (frame (frame-list))
          (when (frame-parameter frame 'tty)
            (send-string-to-terminal seq (frame-terminal frame)))))))
  (setq interprogram-cut-function #'my/osc52-copy))

;; Work around compat's global `all' function (arity 2) colliding with
;; company-dabbrev-other-buffers' default symbol value `all'. In
;; company-dabbrev--fetch the pcase tests (pred functionp) before the
;; literal `all, so once compat makes `all' fboundp company calls
;; (funcall 'all (current-buffer)) -> wrong-number-of-arguments (2 . 2) 1.
;; Returning the symbol `all' from a function preserves all-buffers search.
(with-eval-after-load 'company-dabbrev
  (setq company-dabbrev-other-buffers (lambda (_buf) 'all)))
