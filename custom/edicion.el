;;; package --- summary
;;; Commentary:
;;; Code:
;;(require 'dired+)
(require 'use-package)
(require 'linum)

;; (use-package power-mode
;;   :load-path "~/.emacs.d/site-lisp/power-mode.el"
;;   :init
;;   (add-hook 'after-init-hook #'power-mode))

(use-package column-enforce-mode :ensure t)

(use-package epa-file
  :custom
  (epa-file-select-keys nil)
  (epa-file-encrypt-to '("miguel_pinia@ciencias.unam.mx"))
  (password-cache-expiry (* 60 15)))

(setq-default auto-save-default nil
              backup-directory-alist  `(("." . ,(concat user-emacs-directory "backups")))
              save-place t
              save-place-file (concat user-emacs-directory "places")
              create-lockfiles nil
              puml-plantuml-jar-path (concat
                                      user-emacs-directory
                                      "dependencies/plantuml.8031.jar")
              c-basic-offset 4
              indent-tabs-mode nil
              tab-width 4
              x-select-enable-clipboard t
              x-select-enable-primary t
              save-interprogram-paste-before-kill t
              apropos-do-all t
              mouse-yank-at-point t)

(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")
(put 'downcase-region 'disabled nil)
(global-set-key (kbd "C-c ;") 'comment-box)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-c u r") 'highlight-regexp)
(global-set-key (kbd "C-c u u") 'unhighlight-regexp)
(global-set-key (kbd "C-c u .") 'highlight-symbol-at-point)

(defun trailing-whitespaces ()
    "Muestra los espacios en blanco al final de cada linea."
    (interactive)
    (setq show-trailing-whitespace t))

(add-hook 'LaTeX-mode-hook 'trailing-whitespaces)
(add-hook 'python-mode-hook 'trailing-whitespaces)
(add-hook 'cc-mode-hook  'trailing-whitespaces)
(add-hook 'java-mode-hook 'trailing-whitespaces)
(add-hook 'sql-mode-hook 'trailing-whitespaces)
(add-hook 'LaTeX-mode-hook 'column-enforce-mode)
(add-hook 'python-mode-hook 'column-enforce-mode)
(add-hook 'java-mode-hook 'column-enforce-mode)
(add-hook 'cc-mode-hook 'column-enforce-mode)
(add-hook 'prog-mode-hook #'(lambda () (linum-mode)
                              (setq linum-format "%4d \u2502 ")))

(global-unset-key (kbd "C-,"))
(global-set-key (kbd "C-,") 'comment-region)
(global-set-key (kbd "C-;") 'uncomment-region)

(add-hook 'prog-mode-hook
          (lambda ()
            (add-to-list
             'write-file-functions
             'delete-trailing-whitespace
             'delete-blank-lines)))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list
             'write-file-functions
             'delete-trailing-whitespace
             'delete-blank-lines)))

(use-package isearch-dabbrev
  :ensure t
  :config
  (eval-after-load "isearch"
  '(progn (require 'isearch-dabbrev)
     (define-key isearch-mode-map (kbd "<tab>") 'isearch-dabbrev-expand))))


(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  (global-set-key (kbd "C-c _") 'undo-tree-visualize)
  :custom
  (undo-tree-auto-save-history nil))


;; (use-package auto-complete
;;   :ensure t
;;   :custom
;;   (ac-delay 0.5)
;;   :init
;;   (progn
;;     (ac-config-default)
;;     (global-auto-complete-mode t)))

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :custom
  (company-idle-delay 0)
  (company-echo-delay 0)
  (company-show-numbers nil)
  (company-require-match nil)
  (company-tooltip-align-annotations t)
  (company-minimum-prefix-lenghth 0)
  ;; (company-backends '(company-capf))
  (company-frontends '(company-pseudo-tooltip-frontend company-preview-frontend)))

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode
          eval-expression-minibuffer-setup
          ielm-mode lisp-mode
          lisp-interaction-mode
          scheme-mode
          emacs-lisp-mode) . enable-paredit-mode))

(use-package smartparens-config
  :ensure smartparens
  :config
  (progn
    (show-smartparens-global-mode t))
  :hook ((prog-mode markdown-mode) . turn-on-smartparens-strict-mode))

(require 'smartparens)

(defmacro def-pairs (pairs)
  "Foo PAIRS."
  `(progn
     ,@(cl-loop for (key . val) in pairs
                collect
                `(defun ,(read (concat
                                "wrap-with-"
                                (prin1-to-string key)
                                "s"))
                     (&optional arg)
                   (interactive "p")
                   (sp-wrap-with-pair ,val)))))


(def-pairs ((paren        . "(")
            (bracket      . "[")
            (brace        . "{")
            (underscore   . "_")
            (single-quote . "'")
            (double-quote . "\"")
            (back-quote   . "`")))

(bind-keys
 :map smartparens-mode-map
 ("C-M-a" . sp-beginning-of-sexp)
 ("C-M-e" . sp-end-of-sexp)
 ("C-<down>" . sp-down-sexp)
 ("C-<up>"   . sp-up-sexp)
 ("M-<down>" . sp-backward-down-sexp)
 ("M-<up>"   . sp-backward-up-sexp)
 ("C-M-f" . sp-forward-sexp)
 ("C-M-b" . sp-backward-sexp)
 ("C-M-n" . sp-next-sexp)
 ("C-M-p" . sp-previous-sexp)
 ("C-S-f" . sp-forward-symbol)
 ("C-S-b" . sp-backward-symbol)
 ("C-<right>" . sp-forward-slurp-sexp)
 ("M-<right>" . sp-forward-barf-sexp)
 ("C-<left>"  . sp-backward-slurp-sexp)
 ("M-<left>"  . sp-backward-barf-sexp)
 ("C-x C-t" . sp-transpose-sexp)
 ("C-M-k" . sp-kill-sexp)
 ("C-k"   . sp-kill-hybrid-sexp)
 ("M-k"   . sp-backward-kill-sexp)
 ("C-M-w" . sp-copy-sexp)
 ("M-<backspace>" . backward-kill-word)
 ("C-<backspace>" . sp-backward-kill-word)
 ([remap sp-backward-kill-word] . backward-kill-word)
 ("M-[" . sp-backward-unwrap-sexp)
 ("M-]" . sp-unwrap-sexp)
 ("C-M-t" . sp-transpose-hybrid-sexp)
 ("C-c ("  . wrap-with-parens)
 ("C-c ["  . wrap-with-brackets)
 ("C-c {"  . wrap-with-braces)
 ("C-c '"  . wrap-with-single-quotes)
 ("C-c \"" . wrap-with-double-quotes)
 ("C-c _"  . wrap-with-underscores)
 ("C-c `"  . wrap-with-back-quotes))

(require 'calendar)

(defun insdate-insert-current-date (&optional omit-day-of-week-p)
  "Insert today's date using the current locale with a OMIT-DAY-OF-WEEK-P.
The date is inserted without the day of the week."
  (interactive "P*")
  (insert (calendar-date-string (calendar-current-date) nil
                                omit-day-of-week-p)))

(global-set-key "\C-x\M-d" `insdate-insert-current-date)

(use-package dired-isearch
  :ensure t
  :config
  (define-key dired-mode-map (kbd "C-s") 'dired-isearch-forward)
  (define-key dired-mode-map (kbd "C-r") 'dired-isearch-backward)
  (define-key dired-mode-map (kbd "ESC C-s") 'dired-isearch-forward-regexp)
  (define-key dired-mode-map (kbd "ESC C-r") 'dired-isearch-backward-regexp))

(use-package dired-git-info
  :ensure t
  :after dired
  :custom
  (dgi-auto-hide-details-p nil)
  :config
  (define-key dired-mode-map ")" 'dired-gipt-info-mode)
  (add-hook 'dired-after-readin-hook 'dired-git-info-auto-enable))

(autoload 'cider--make-result-overlay "cider-overlays")
(defun endless/eval-overlay (value point)
  "Eval overlay VALUE POINT."
  (cider--make-result-overlay (format "%S" value)
    :where point
    :duration 'command)
  value)
(advice-add 'eval-region :around
            (lambda (f beg end &rest r)
              (endless/eval-overlay
               (apply f beg end r)
               end)))
(advice-add 'eval-last-sexp :filter-return
            (lambda (r)
              (endless/eval-overlay r (point))))
(advice-add 'eval-defun :filter-return
            (lambda (r)
              (endless/eval-overlay
               r
               (save-excursion
                 (end-of-defun)
                 (point)))))

(add-hook 'pdf-view-mode-hook 'auto-revert-mode)

(use-package which-key :ensure t :config (which-key-mode))

;; (use-package dap-chrome :ensure t)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      create-lockfiles nil)

(require 'ansi-color)

(add-hook 'compilation-filter-hook
          (lambda () (ansi-color-apply-on-region (point-min) (point-max))))

(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

    ;; Handy key definition
(define-key global-map "\M-Q" 'unfill-paragraph)

(use-package lua-mode
  :ensure t
  )

(provide 'edicion)
;;; edicion.el ends here
