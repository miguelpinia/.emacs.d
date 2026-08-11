;;; Setup-terminal.el --- Summary
;;; Commentary:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuración para ansi-term ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'term-mode-hook
          (lambda() (setq yas-dont-activate t)
            (display-line-numbers-mode 0)))

;; (defadvice term-sentinel
;;     (around my-advice-term-sentinel (proc msg))
;;   ":v."
;;   (if (memq (process-status proc) '(signal exit))
;;       (let ((buffer (process-buffer proc)))
;;         ad-do-it
;;         (kill-buffer buffer))
;;     ad-do-it))
;; (ad-activate 'term-sentinel)

;; (defvar my-term-shell "/bin/bash")

;; (defadvice ansi-term (before force-bash)
;;   ":v."
;;   (interactive (list my-term-shell)))
;; (ad-activate 'ansi-term)

;; (defun my-term-use-utf8 ()
;;   ":v."
;;   (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))

;; (add-hook 'term-exec-hook 'my-term-use-utf8)

;; (defun my-term-paste (&optional string)
;;   ":v STRING."
;;   (interactive)
;;   (process-send-string
;;    (get-buffer-process (current-buffer))
;;    (if string string (current-kill 0))))

;; (defun my-term-hook ()
;;   ":v."
;;   (goto-address-mode)
;;   (define-key term-raw-map "\C-y" 'my-term-paste)
;;   (setq term-buffer-maximum-size 0))

;; (add-hook 'term-mode-hook 'my-term-hook)

(use-package vterm
  :ensure t
  :custom
  (vterm-shell "fish")
  (vterm-copy-exclude-prompt t)
  (vterm-buffer-name-string "*vterm %s")
  :config
  ;; (add-hook 'vterm-mode-hook
  ;;           (lambda ()
  ;;             (set (make-local-variable 'buffer-face-mode-face) '(:family "MesloLGS NF" :weight bold :height 120))
  ;;             (buffer-face-mode t)))
  (define-key vterm-mode-map (kbd "C-m") #'vterm-send-return))

(use-package ghostel
  :ensure t
  :bind (("C-x m" . ghostel)
         :map ghostel-semi-char-mode-map
         ("C-s"  . consult-line)
         ("C-k"  . my/ghostel-send-C-k-and-kill)
         ;; I'm used to go up/down the shell history with M-n/p from eshell
         ;; Simulate this behavior in ghostel by sending C-p and C-n
         ("M-p" . (lambda () (interactive) (ghostel-send-key "p" "ctrl")))
         ("M-n" . (lambda () (interactive) (ghostel-send-key "n" "ctrl")))
         :map project-prefix-map
         ("m" . ghostel-project)
         ("M" . ghostel-project-list-buffers))
  :config
  (defun my/ghostel-send-C-k-and-kill ()
    "Send `C-k' to ghostel.
Like normal Emacs `C-k'.  Kill to end of line and put content in kill-ring."
    (interactive)
    (kill-ring-save (point) (line-end-position))
    (ghostel-send-key "k" "ctrl"))

  (add-to-list 'project-switch-commands '(ghostel-project "Ghostel") t)
  (add-to-list 'project-switch-commands '(ghostel-project-list-buffers "Ghostel buffers") t)
  (add-to-list 'ghostel-eval-cmds '("magit-status-setup-buffer" magit-status-setup-buffer)))


(provide 'terminal)
;;; terminal.el ends here
;; (if (not (string= "" (string-trim (shell-command-to-string "git status --porcelain"))))
;;     " ✎" " ✔")
