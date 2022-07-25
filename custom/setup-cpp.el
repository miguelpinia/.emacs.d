;;; setup-cpp.el --- Summary
;;; Commentary:
;;; Code:

(use-package cmake-mode
  :ensure t)

(use-package disaster
  :ensure t
  :bind (:map c-mode-base-map
              ("C-c d" . disaster))
  ;; :config
  ;; (disaster-find-project-root &optional LOOKS FILE)
  )


(defun my:ac-c-header-init ()
  (require 'ac-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-header-symbols t))

(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

(use-package modern-cpp-font-lock
  :ensure t)

;;; setup-cpp.el ends here
