(use-package tide :ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;
;; sudo npm i -g tern ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(use-package tern :ensure t)

(use-package restclient
  :ensure t
  :mode (("\\.http\\'" . restclient-mode)))

(use-package js-react-redux-yasnippets
  :after yasnippet
  :ensure t)

(add-hook 'after-init-hook #'global-flycheck-mode)

(use-package css-mode
  :ensure t
  :mode "\\.css\\'"
  :custom
  (css-indent-offset 2)
  (flycheck-stylelintrc "~/.stylelintrc")
  :hook (css-mode-hook . (lambda ()
                           (add-to-list (make-local-variable 'company-backends)
                                        '(company-css company-files company-capf)))))

(add-hook 'js-mode-hook #'setup-tide-mode)
(setq flycheck-javascript-eslint-executable "/usr/bin/eslint")


(defun setup-tide-mode ()
  "Setup function for tide."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t
                              :placeOpenBraceOnNewLineForFunctions nil)))

(use-package prettier-js
  :ensure t
  :hook (rjsx-mode . prettier-js-mode)
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

(use-package react-snippets
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package emmet-mode
  :ensure t
  :custom
  (emmet-move-cursor-between-quotes t)
  (emmet-expand-jsx-className t)
  (emmet-preview-default t))

(use-package rjsx-mode
  :ensure t
  :mode ("\\.js\\'")
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
  (add-hook 'rjsx-mode-hook 'auto-complete-mode))

(use-package js2-mode
  :ensure t
  :init
  (add-hook 'js2-mode-hook #'setup-tide-mode)
  (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  :custom
  (indent-tabs-mode nil)
  (js2-basic-offsets 2)
  (js-indent-level 2)
  (js2-global-externs '("module" "require" "assert" "setInterval" "console" "__dirname__")))

(use-package emmet-mode
  :ensure t
  :hook (web-mode
         css-mode
         scss-mode
         sgml-mode
         rjsx-mode)
  :custom
  (emmet-indent-after-insert t)
  (emmet-move-cursor-between-quotes t)
  (emmet-expand-jsx-className t)
  (emmet-preview-default t))

(use-package mode-local
  :ensure t
  :config
  (require 'emmet-mode)
  (setq-mode-local rjsx-mode emmet-expand-jsx-className t)
  (setq-mode-local web-mode emmet-expand-jsx-className nil))



(use-package js-import
  :ensure t)

(use-package npm
  :ensure t)

(provide 'setup-js)
