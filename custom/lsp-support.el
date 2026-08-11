;;; package --- summary
;;; commentary:

;;; code:

(when (executable-find "aspell") (require 'flyspell))

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
         (latex-mode . lsp-mode))
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-segments '(symbols))
  ;; (lsp-clients-clangd-executable "clangd")
  (lsp-auto-guess-root nil)
  (lsp-prefer-capf t)
  (read-process-output-max (* 1024 1024))
  (lsp-idle-delay 0.5)
  (lsp-clients-clangd-args nil)
  :commands lsp
  :config
  (setq lsp-disabled-clients '(ts-ls typescript-language-server eslint javascript-language-server))
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]org\\'"))

;; Recolor lsp-mode symbol-at-point highlighting. The lsp-face-highlight-*
;; faces inherit modus-vivendi's `highlight' face, a teal-green (#45605e) that
;; clashes with the theme; override with a muted purple so symbol occurrences
;; stand out on the hl-line without the green tint.
(with-eval-after-load 'lsp-mode
  (dolist (face '(lsp-face-highlight-read
                  lsp-face-highlight-write
                  lsp-face-highlight-textual))
    (set-face-attribute face nil
                        :inherit nil
                        :foreground 'unspecified
                        :background "#3b2d4f"
                        :underline t))
  ;; The generic `highlight' face (used as fallback by various modes) also
  ;; carries the green; neutralize it to match.
  (set-face-attribute 'highlight nil :background "#4d4d4d" :foreground 'unspecified))

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
  (lsp-ui-doc-enable nil)
  (lsp-ui-doc-delay 1)
  (lsp-ui-doc-show-with-cursor t)
  :config
  (when (display-graphic-p)
    (setq lsp-ui-doc-enable t))
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))



;; (use-package lsp-completion
;;   :ensure lsp-mode
;;   :custom (lsp-completion-enable-additional-text-edit nil))



(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config (dap-auto-configure-mode))

(use-package lsp-java
  :ensure t
  :hook (java-mode . lsp-deferred)
  :custom
  (lsp-java-vmargs '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Xmx2G" "-Xms512m"))
  (lsp-java-import-maven-enabled t)
  (lsp-java-maven-download-sources t)
  (lsp-java-sources-organize-imports-star-threshold 5)
  (lsp-java-save-actions-organize-imports t)
  (lsp-java-completion-favorite-static-members
   '("org.junit.Assert.*"
     "org.junit.jupiter.api.Assertions.*"
     "org.mockito.Mockito.*"
     "org.mockito.ArgumentMatchers.*")))

(use-package dap-java
  :ensure nil
  :after (lsp-java dap-mode))

(use-package helm-lsp
  :ensure t
  :after (lsp-mode helm)
  :bind (:map lsp-mode-map
              ([remap xref-find-apropos] . helm-lsp-workspace-symbol)))

(use-package lsp-treemacs
  :ensure t
  :after lsp-mode
  :bind (:map lsp-mode-map
              ("C-c l e" . lsp-treemacs-errors-list)
              ("C-c l s" . lsp-treemacs-symbols)))

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

(use-package plz
  :ensure t)

(provide 'lsp-support)
;;; lsp-support.el ends here
