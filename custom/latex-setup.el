;;; package --- Summary:
;;; Commentary:
;;; Code:
(use-package tex-buf :ensure auctex)

(use-package reftex
  :ensure t
  :defer t
  :config
  (setq reftex-cite-prompt-optional-args t))

(use-package tex
  :ensure auctex)

(use-package tex-site
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :custom (TeX-auto-save t)
  (TeX-parse-self t)
  :config
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'LaTeX-mode-hook 'auto-complete-mode)
  (add-hook 'LaTeX-mode-hook 'smartparens-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
  ;; (add-hook 'LaTeX-mode-hook
  ;;         (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
  ;;                    (cons "\\(" "\\)"))))
  ;; (add-hook 'LaTeX-mode-hook (lambda ()
  ;;                              (rainbow-delimiters-mode)
  ;;                              (auto-complete-mode)
  ;;                              (smartparens-mode)
  ;;                              (turn-on-reftex)
  ;;                              (setq reftex-plug-into-AUCTeX t
  ;;                                    TeX-PDF-mode 1
  ;;                                    TeX-source-correlate-method 'synctex
  ;;                                    TeX-source-correlate-start-server t)
  ;;                              (reftex-isearch-minor-mode)))
  ;; (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
  ;;           #'TeX-revert-document-buffer)
  ;; (add-hook 'LaTex-mode-hook 'pdf-tools-install)
  (setq TeX-view-program-selection '((output-pdf "pdf-tools"))
        TeX-source-correlate-start-server t
        TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sinc-view"))))

(provide 'latex-setup)
;;; latex-setup.el ends here
