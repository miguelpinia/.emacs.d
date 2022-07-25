;;; package --- Summary
;;; Commentary:
;;; Code:

(use-package python
  :mode ("\\.py\\'" . python-mode)
  :custom
  (python-shell-interpreter "/usr/bin/python3"))

;; (use-package elpy
;;   :ensure t
;;   :init (elpy-enable)
;;   :custom
;;   (elpy-rpc-python-command "python3")
;;   (elpy-rpc-timeout 2)
;;   (elpy-shell-echo-output nil))

;; (use-package pyenv
;;   :ensure t
;;   :custom
;;   (pyvenv-use-alias 't)
;;   (pyenv-modestring-prefix " ")
;;   (pyenv-modestring-postfix nil)
;;   (pyenv-set-path nil)
;;   :config
;;   (global-pyenv-mode)
;;   (defun pyenv-update-on-buffer-switch (prev curr)
;;     (if (string-equal "Python" (format-mode-line mode-name nil nil curr))
;;         (pyenv-use-corresponding)))
;;   (add-hook 'switch-buffer-functions 'pyenv-update-on-buffer-switch))

(provide 'setup-py)
;;; setup-py.el ends here
