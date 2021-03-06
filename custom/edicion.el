(require 'dired+)
(require 'use-package)

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
  (global-set-key (kbd "C-c _") 'undo-tree-visualize))


(use-package auto-complete
  :ensure t
  :custom
  (ac-delay 0.5)
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

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
 ("C-M-d" . delete-sexp)
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

(defun insdate-insert-current-date (&optional omit-day-of-week-p)
  "Insert today's date using the current locale with a OMIT-DAY-OF-WEEK-P,the date is inserted without the day of the week."
    (interactive "P*")
    (insert (calendar-date-string (calendar-current-date) nil
                                  omit-day-of-week-p)))

(global-set-key "\C-x\M-d" `insdate-insert-current-date)

(defun ora-dired-rsync (dest)
  "Whatever DEST."
  (interactive
   (list
    (expand-file-name
     (read-file-name
      "Rsync to:"
      (dired-dwim-target-directory)))))
  ;; store all selected files into "files" list
  (let ((files (dired-get-marked-files
                nil current-prefix-arg))
        ;; the rsync command
        (tmtxt/rsync-command
         "rsync -arvz --progress "))
    ;; add all selected file names as arguments
    ;; to the rsync command
    (dolist (file files)
      (setq tmtxt/rsync-command
            (concat tmtxt/rsync-command
                    (shell-quote-argument file)
                    " ")))
    ;; append the destination
    (setq tmtxt/rsync-command
          (concat tmtxt/rsync-command
                  (shell-quote-argument dest)))
    ;; run the async shell command
    (async-shell-command tmtxt/rsync-command "*rsync*")
    ;; finally, switch to that window
    (other-window 1)))



(define-key dired-mode-map "Y" 'ora-dired-rsync)
(diredp-toggle-find-file-reuse-dir t)

(use-package dired-isearch
  :ensure t
  :config
  (define-key dired-mode-map (kbd "C-s") 'dired-isearch-forward)
  (define-key dired-mode-map (kbd "C-r") 'dired-isearch-backward)
  (define-key dired-mode-map (kbd "ESC C-s") 'dired-isearch-forward-regexp)
  (define-key dired-mode-map (kbd "ESC C-r") 'dired-isearch-backward-regexp))

;; (autoload 'cider--make-result-overlay "cider-overlays")
;; (defun endless/eval-overlay (value point)
;;   "Eval overlay VALUE POINT."
;;   (cider--make-result-overlay (format "%S" value)
;;     :where point
;;     :duration 'command)
;;   value)
;; (advice-add 'eval-region :around
;;             (lambda (f beg end &rest r)
;;               (endless/eval-overlay
;;                (apply f beg end r)
;;                end)))
;; (advice-add 'eval-last-sexp :filter-return
;;             (lambda (r)
;;               (endless/eval-overlay r (point))))
;; (advice-add 'eval-defun :filter-return
;;             (lambda (r)
;;               (endless/eval-overlay
;;                r
;;                (save-excursion
;;                  (end-of-defun)
;;                  (point)))))

(add-hook 'pdf-view-mode-hook 'auto-revert-mode)

(provide 'edicion)
