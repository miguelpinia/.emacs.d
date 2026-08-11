;;; package --- summary
;;; commentary:
;;; code:

(use-package js
  :custom
  (indent-tabs-mode nil)
  (js-indent-level 2))

(use-package web-mode
  :ensure t
  :mode ("\\.tsx\\'" "\\.jsx\\'" "\\.js\\'")
  :hook ((web-mode . lsp-deferred)
         (web-mode . hs-minor-mode))
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))

(use-package web-mode
  :ensure t
  :mode "\\.tsx\\'"
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-code-indent-offset 2))

(use-package typescript-mode
  :ensure t
  :hook ((typescript-mode . hs-minor-mode)
         (typescript-mode . (lambda ()
                              (setq-local tab-width 2)
                              (setq-local typescript-indent-level 2)
                              (setq-local indent-tabs-mode nil)))))

;; tide replaced by lsp-mode + typescript-language-server
;; (use-package tide :ensure t
;;   :after (typescript-mode company flycheck)
;;   :custom (company-tooltip-align-annotations t))

(defun tide-setup-mode ()
  (interactive)
  (tide-setup)
      (flycheck-mode +1)
      (setq flycheck-check-syntax-automatically '(save mode-enabled))
      (eldoc-mode +1)
      (tide-hl-identifier-mode +1)
      (setq tide-format-options
            '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t
              :placeOpenBraceOnNewLineForFunctions nil)))

;; (add-hook 'js-mode-hook 'tide-setup-mode)
;; (add-hook 'js-mode-hook 'tide-hl-identifier-mode)
;; (add-hook 'before-save-hook 'tide-format-before-save)

;; (flycheck-add-mode 'javascript-eslint 'web-mode)
(setq flycheck-javascript-eslint-executable "/usr/bin/eslint")

(use-package restclient
  :ensure t
  :mode (("\\.http\\'" . restclient-mode)))

(use-package js-react-redux-yasnippets
  :after yasnippet
  :ensure t)

(use-package react-snippets
  :after yasnippet
  :ensure t
  :mode ())

(use-package prettier-js
  :ensure t
  :hook ((web-mode . prettier-js-mode)
         (typescript-mode . prettier-js-mode))
  :custom
  (prettier-js-args '("--trailing-comma" "es5"
                      "--tab-width" "2"
                      "--use-tabs" "false"
                      "--bracket-spacing" "true"
                      "--single-quote" "true"
                      "--semi" "true"
                      "--jsx-single-quote" "true"
                      "--jsx-bracket-same-line" "true"
                      "--arrow-parens" "always")))

(use-package css-mode
  :ensure t
  :mode "\\.css\\'"
  :custom
  (css-indent-offset 2)
  (flycheck-stylelintrc "~/.stylelintrc")
  :hook (css-mode-hook . (lambda ()
                           (add-to-list (make-local-variable 'company-backends)
                                        '(company-css company-files company-capf)))))

(use-package emmet-mode
  :ensure t
  :hook (web-mode
         css-mode
         scss-mode
         sgml-mode)
  :custom
  (emmet-indent-after-insert t)
  (emmet-move-cursor-between-quotes t)
  (emmet-expand-jsx-className t)
  (emmet-preview-default t)
  :config
  (add-to-list 'emmet-jsx-major-modes 'js-mode)
  (add-to-list 'emmet-jsx-major-modes 'web-mode))

(use-package rjsx-mode
  :ensure t
  :mode ("\\.jsx?\\'")
  :config
  (add-hook 'rjsx-mode-hook (lambda()
                              (setq-default flycheck-disabled-checkers
                                            (append flycheck-disabled-checkers
                                                    '(javascript-jshint)))
                              (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
                              (setq-default flycheck-temp-prefix ".flycheck")
                              (setq-default flycheck-disabled-checkers
                                            (append flycheck-disabled-checkers
                                                    '(json-jsonlint)))))
  (add-hook 'rjsx-mode-hook 'emmet-mode)
  (add-hook 'rjsx-mode-hook #'yas-minor-mode)
  (add-hook 'rjsx-mode-hook 'company-mode)
  (add-hook 'rjsx-mode-hook 'auto-complete-mode))



(use-package mode-local
  :ensure t
  :config
  (require 'emmet-mode)
  (setq-mode-local web-mode emmet-expand-jsx-className t))

(use-package dockerfile-mode
  :ensure t)

(use-package docker-compose-mode
  :ensure t)

(with-eval-after-load 'hideshow
  (define-key hs-minor-mode-map (kbd "C-c h h") 'hs-hide-block)
  (define-key hs-minor-mode-map (kbd "C-c h s") 'hs-show-block)
  (define-key hs-minor-mode-map (kbd "C-c h c") 'hs-toggle-hiding)
  (define-key hs-minor-mode-map (kbd "C-c h H") 'hs-hide-all)
  (define-key hs-minor-mode-map (kbd "C-c h S") 'hs-show-all))

(provide 'setup-js)
;;; setup-js.el ends here
