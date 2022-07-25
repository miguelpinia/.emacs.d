;;; setup-clojure.el --- Summary
;;; Commentary:
;;; Code:

;;;;
;; Clojures
;;;;
(defun my-clojure-mode-hook ()
  "Foo."
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package sotlisp :ensure t)
(use-package clojure-mode
  :ensure t
  :config
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
  (add-hook 'clojure-mode-hook #'my-clojure-mode-hook)
  (add-hook 'clojure-mode-hook #'aggressive-indent-mode)
  (define-clojure-indent (prop/for-all 1))
  (font-lock-add-keywords
   'clojure-mode `(("\\(#\\)("
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "ƒ")
                              nil)))))
  (font-lock-add-keywords
   'clojure-mode `(("\\(#\\){"
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
  :config
  (add-hook 'cider-mode-hook 'eldoc-mode)
  (setq cider-repl-pop-to-buffer-on-connect t)
  (setq cider-show-error-buffer t)
  (setq cider-auto-select-error-buffer t)
  (setq cider-repl-history-file "~/.emacs.d/cider-history")
  (setq cider-repl-wrap-history t)
  (setq cider-repl-pop-to-buffer-on-connect t)
  (setq cider-repl-wrap-history t)
  (add-hook 'cider-repl-mode-hook 'paredit-mode)
  (progn
    (define-key clojure-mode-map (kbd "C-c C-e") 'cider-eval-last-sexp-to-repl)
    (define-key clojure-mode-map (kbd "C-c b") 'cider-eval-buffer))
  (add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
  (add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))
  )
(use-package clojure-mode-extra-font-locking
  :ensure t)
(use-package inf-lisp
  :ensure t)

(eval-when-compile
   (require 'cl-lib))

(use-package ac-cider
  :ensure t
  :config
  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
  (progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode))
  )

(use-package clj-refactor)
;; Usa clojure para otras extensiones.

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
