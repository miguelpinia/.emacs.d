;;; setup-clojure.el --- Summary
;;; Commentary:
;;; Code:

;;;;
;; Clojures
;;;;
(defun my-clojure-mode-hook ()
  "Foo."
  (clj-refactor-mode t)
  (yas-minor-mode t) ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package sotlisp :ensure t)

(use-package flycheck-clj-kondo
  :ensure t)

(use-package clojure-mode
  :ensure t
  :config
  (require 'flycheck-clj-kondo)
  (add-hook 'clojure-mode-hook 'enable-paredit-mode)
  (add-hook 'clojure-mode-hook 'auto-complete-mode)
  (add-hook 'clojure-mode-hook 'subword-mode)
  (add-hook 'clojure-mode-hook (lambda ()
                                 (setq inferior-lisp-program "lein repl")
                                 (font-lock-add-keywords
                                  nil
                                  '(("(\\(facts?\\)"
                                     (1 font-lock-keyword-face))
                                    ("(\\(background?\\)"
                                     (1 font-lock-keyword-face))))
                                 (define-clojure-indent (fact 1))
                                 (define-clojure-indent (facts 1))))
  (add-hook 'clojurescript-mode-hook 'enable-paredit-mode)
  (add-hook 'clojurescript-mode-hook 'auto-complete-mode)
  (add-hook 'clojurescript-mode-hook 'subword-mode)
  (add-hook 'clojurescript-mode-hook (lambda ()
                                       (setq inferior-lisp-program "lein repl")
                                       (font-lock-add-keywords
                                        nil
                                        '(("(\\(facts?\\)"
                                           (1 font-lock-keyword-face))
                                          ("(\\(background?\\)"
                                           (1 font-lock-keyword-face))))
                                       (define-clojure-indent (fact 1))
                                       (define-clojure-indent (facts 1))))
  (add-hook 'clojure-mode-hook #'my-clojure-mode-hook)
  (add-hook 'clojurescript-mode-hook #'my-clojure-mode-hook)
  ;; (add-hook 'clojure-mode-hook #'aggressive-indent-mode)
  (define-clojure-indent (prop/for-all 1))
  (font-lock-add-keywords
   'clojure-mode `(("\\(#\\)("
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "ƒ")
                              nil)))))
  (font-lock-add-keywords
   'clojurescript-mode `(("\\(#\\)("
                          (0 (progn (compose-region (match-beginning 1)
                                                    (match-end 1) "ƒ")
                                    nil)))))
  (font-lock-add-keywords
   'clojure-mode `(("\\(#\\){"
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "∈")
                              nil)))))
  (font-lock-add-keywords
   'clojurescript-mode `(("\\(#\\){"
                          (0 (progn (compose-region (match-beginning 1)
                                                    (match-end 1) "∈")
                                    nil)))))
  (add-to-list 'clojure--prettify-symbols-alist '(">=" . (?· (Br . Bl) ?≥)))
  (add-to-list 'clojure--prettify-symbols-alist '("<=" . (?· (Br . Bl) ?≤)))
  (add-to-list 'clojure--prettify-symbols-alist '("not=" . ?≠))
  (add-to-list 'clojure--prettify-symbols-alist '("not" . ?¬))
  (add-to-list 'clojure--prettify-symbols-alist '("->" . (?\s (Br . Bl) ?\s (Bc . Bc) ?➜)))
  (add-to-list 'clojure--prettify-symbols-alist '("->>" . (?\s (Br . Bl) ?\s (Br . Bl) ?\s
                                                               (Bc . Br) ?➜ (Bc . Bl) ?➜)))
  (add-to-list 'clojure--prettify-symbols-alist '("partial" . ?Ƥ))
  (add-to-list 'clojure--prettify-symbols-alist '("map" . ?↦))
  (add-to-list 'clojure--prettify-symbols-alist '("sum" . ?∑))
  (add-to-list 'clojure--prettify-symbols-alist '("or" . ?∨))
  (add-to-list 'clojure--prettify-symbols-alist '("and" . ?∧))
  (add-to-list 'clojure--prettify-symbols-alist '("nil" . ?∅)))

  (use-package cider
    :ensure t
    :config
    (add-hook 'cider-mode-hook 'eldoc-mode)
    (add-hook 'cider-repl-mode-hook 'paredit-mode)
    (add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
    (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
    :custom
    (cider-repl-result-prefix ";; => ")
    (cider-repl-pop-to-buffer-on-connect t)
    (cider-show-error-buffer t)
    (cider-repl-history-file "~/.emacs.d/cider-history"))


;; (use-package cider
;;   :config
;;   (add-hook 'cider-mode-hook 'eldoc-mode)
;;   (add-hook 'cider-repl-mode-hook 'paredit-mode)
;;   (progn
;;     (define-key clojure-mode-map (kbd "C-c C-e") 'cider-eval-last-sexp-to-repl)
;;     (define-key clojure-mode-map (kbd "C-c b") 'cider-eval-buffer))
;;   (add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
;;   (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
;;   (add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
;;   (add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))
;;     :custom
;;   (cider-repl-result-prefix ";; => ")
;;   (cider-eval-result-prefix "")
;;   (cider-connection-message-fn nil)
;;   (cider-repl-prompt-function (lambda (ns)
;;                                 "Return a prompt string that mentions NAMESPACE."
;;                                 (format "%s🦄> " (cider-abbreviate-ns ns))))
;;   ;; (cider-repl-display-help-banner nil)
;;   (cider-repl-pop-to-buffer-on-connect t)
;;   (cider-show-error-buffer t)
;;   (cider-auto-select-error-buffer t)
;;   (cider-repl-history-file "~/.emacs.d/cider-history")
;;   (cider-repl-wrap-history t)
;;   (cider-repl-pop-to-buffer-on-connect t)
;;   (cider-repl-wrap-history t))

(use-package clojure-mode-extra-font-locking
  :ensure t)
(use-package inf-lisp
  :ensure t)

;; (eval-when-compile
;;    (require 'cl-lib))

;; (use-package ac-cider
;;   :ensure t
;;   :config
;;   (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
;;   (add-hook 'cider-mode-hook 'ac-cider-setup)
;;   (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
;;   (progn
;;      (add-to-list 'ac-modes 'cider-mode)
;;      (add-to-list 'ac-modes 'cider-repl-mode)))

;; (use-package clj-refactor
;;   :ensure t)

;; ;; Usa clojure para otras extensiones.

;; (autoload 'cider--make-result-overlay "cider-overlays")

;; (defun eval-overlay (value point)
;;   (cider--make-result-overlay (format "%S" value)
;;     :where point
;;     :duration 'command)
;;   ;; Preserve the return value.
;;   value)

;; (advice-add 'eval-region :around
;;             (lambda (f beg end &rest r)
;;               (eval-overlay
;;                (apply f beg end r)
;;                end)))

;; (advice-add 'eval-last-sexp :filter-return
;;             (lambda (r)
;;               (eval-overlay r (point))))

;; (advice-add 'eval-defun :filter-return
;;             (lambda (r)
;;               (eval-overlay
;;                r
;;                (save-excursion
;;                  (end-of-defun)
;;                  (point)))))

;; TODO: Implementar los siguientes símbolos (MAPA 2016-11-28)

;; original	concealed

;; (add-to-list 'clojure--prettify-symbols-alist '("def" . ?≡))
;; (add-to-list 'clojure--prettify-symbols-alist '("let" . ?⊢))
;; (add-to-list 'clojure--prettify-symbols-alist '("doseq" . ?∀))
;; (add-to-list 'clojure--prettify-symbols-alist '("comp" . ?∘))
;; (add-to-list 'clojure--prettify-symbols-alist '("union" . ?⋃))
;; (add-to-list 'clojure--prettify-symbols-alist '("intersection" . ?⋂))
;; (add-to-list 'clojure--prettify-symbols-alist '("difference" . ?−))

;; def	≡
;; defn	ƒ
;; fn	λ
;; letfn	λ
;; #(...)	λ(...)
;; let	⊢
;; doseq	∀
;; ->	→
;; ->>	⇉
;; partial	Ƥ
;; comp	∘
;; not=	≠
;; and	∧
;; or	∨
;; not	¬
;; >=	≥
;; <=	≤
;; #{...}	∈{...}
;; #{}	∅
;; union	⋃
;; intersection	⋂
;; difference	−

(provide 'setup-clojure)
;;; setup-clojure.el ends here
