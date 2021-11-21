;;; package --- Summary:
;;; Commentary:
;;; Code:

(defun mg-TeX-delete-current-macro (&optional arg)
  "Remove the current macro.
With an optional argument ARG, delete just the ARG-th macro
starting from the innermost."
  (interactive "*p")
  (let (macro end)
    (when
    (dotimes (i arg macro)
      (goto-char (TeX-find-macro-start))
      (setq macro (TeX-current-macro)
        end (TeX-find-macro-end))
      ;; If we need to look for an outer macro we have to "exit" from the
      ;; current one.
      (backward-char))
      ;; Return to the beginning of the macro to be deleted.
      (forward-char)
      (re-search-forward
       (concat (regexp-quote TeX-esc) macro "\\(?:\\[[^]]*\\]\\)?"
           TeX-grop "\\(\\(.\\|\n\\)*\\)")
       end t)
      (replace-match "\\1")
      ;; Delete the closing brace.
      (delete-backward-char 1))))

(use-package tex-buf :ensure auctex)

(use-package reftex
  :ensure t
  :defer t
  :custom
  (reftex-default-bibliography "~/Dropbox/org/phd/research/refs.bib")
  (reftex-cite-prompt-optional-args t)
  (reftex-plug-into-AUCTeX t)
  :config
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex))

(use-package tex
  :ensure auctex)

(use-package tex-site
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :custom (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-source-correlate-mode t)
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
  (setq TeX-view-program-selection '((output-pdf "pdf-tools")
                                     (output-pdf "Evince"))
        TeX-source-correlate-start-server t
        TeX-view-program-list '(("pdf-tools" TeX-pdf-tools-sync-view)
                                ("Evince" "evince --page-index=%(outpage) %o"))
        TeX-source-correlate-method '((dvi . source-specials)
                                      (pdf . synctex)))
  (define-key LaTeX-mode-map (kbd "C-c d") 'mg-TeX-delete-current-macro))


(provide 'latex-setup)
;;; latex-setup.el ends here
