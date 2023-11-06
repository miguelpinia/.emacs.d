;;; package --- summary
;;; commentary:

;;; code:

(require 'flyspell)

(use-package flyspell-correct
  :ensure t
  :after flyspell
  :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

(use-package flyspell-correct-helm
  :ensure t
  :after flyspell-correct)

 (use-package lsp-mode
  :ensure t
  :init
  :hook ((lsp-mode . lsp-enable-which-key-integration)
         ((js-mode latex-mode) . lsp-mode))
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-headerline-breadcrumb-enable nil)
  ;; (lsp-clients-clangd-executable "clangd")
  (lsp-auto-guess-root t)
  (lsp-prefer-capf t)
  (lsp-completion-at-point nil)
  (read-process-output-max (* 1024 1024))
  (lsp-idle-delay 0.5)
  (lsp-clients-clangd-args nil)
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :hook ((prog-mode-hook . lsp-ui-mode))
  :custom
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-delay 0)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-delay 1)
  (lsp-ui-doc-show-with-cursor t)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))



;; (use-package lsp-completion
;;   :ensure lsp-mode
;;   :custom (lsp-completion-enable-additional-text-edit nil))



;; (use-package dap-mode
;;   :ensure t
;;   :after lsp-mode
;;   :config (dap-auto-configure-mode))

;; (use-package lsp-java
;;   :ensure t
;;   :config (add-hook 'java-mode-hook 'lsp))

;; (use-package dap-cpptools
;;   :ensure t)

;; (use-package dap-java
;;   :ensure t)

;; (use-package helm-lsp
;;   :ensure t)

;; (use-package lsp-treemacs
;;   :ensure t)

;; (with-eval-after-load 'lsp-mode
;;   (require 'dap-chrome)
;;   (setq lsp-modeline-diagnostics-enable t)
;;   (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
;;   (require 'dap-cpptools))

;; (use-package helm-xref
;;   :ensure t)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(provide 'lsp-support)
;;; lsp-support.el ends here
