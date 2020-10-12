;;; setup-terminal.el --- Summary
;;; Commentary:
(require 'term)

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuración para ansi-term ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'term-mode-hook
          (lambda() (setq yas-dont-activate t)
            (linum-mode 0)))

(defadvice term-sentinel
    (around my-advice-term-sentinel (proc msg))
  ":v."
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)

(defvar my-term-shell "/bin/bash")

(defadvice ansi-term (before force-bash)
  ":v."
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(defun my-term-use-utf8 ()
  ":v."
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))

(add-hook 'term-exec-hook 'my-term-use-utf8)

(defun my-term-paste (&optional string)
  ":v STRING."
  (interactive)
  (process-send-string
   (get-buffer-process (current-buffer))
   (if string string (current-kill 0))))

(defun my-term-hook ()
  ":v."
  (goto-address-mode)
  (define-key term-raw-map "\C-y" 'my-term-paste)
  (setq term-buffer-maximum-size 0))

(add-hook 'term-mode-hook 'my-term-hook)

(provide 'terminal)
;;; terminal.el ends here
