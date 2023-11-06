;;; navegacion.el --- Summary
;;; Commentary:
;;; Code:

(setq org-reveal-root               "http://cdn.jsdelivr.net/reveal.js/3.0.0/"
      uniquify-buffer-name-style    'forward)
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)
(global-set-key (kbd "C-c C-t") 'vterm)
(fset 'yes-or-no-p 'y-or-n-p)


(use-package tramp
  :custom
  (tramp-default-method "sshx"))

(use-package tramp-term
  :ensure t)

(use-package recentf
  :ensure t
  :custom
  (recentf-save-file (concat user-emacs-directory ".recentf"))
  (recentf-max-menu-items 40)
  :config
  (recentf-mode))

(use-package ibuffer
  :custom
  (ibuffer-default-sorting-mode 'major-mode))

;; (use-package git-gutter
;;   :ensure git-gutter-fringe
;;   :after magit
;;   :init
;;   (global-git-gutter-mode 1)
;;   (setq-default left-fringe-width 25)
;;   :hook
;;   (magit-post-refresh . git-gutter:update-all-windows))

(use-package forge
  :ensure t
  :after magit
  :config '((ghub-request "GET" "/user" nil
                          :forge 'github
                          :host "api.github.com"
                          :username "miguelpinia"
                          :auth 'forge)
            (ghub-request "GET" "/user" nill
                          :forge 'gitlab
                          :host "gitlab.com/api/v4"
                          :username "miguelpinia"
                          :auth 'forge)))

(use-package google-translate
  :ensure t)

(defun google-translate--search-tkk () "Search TKK." (list 430675 2721866130))

(use-package google-translate-smooth-ui
  :after google-translate
  :defer t
  :config
  (setq google-translate-translation-directions-alist '(("es" . "en")
                                                        ("en" . "es")
                                                        ("es" . "fr")
                                                        ("fr" . "es"))
        google-translate-show-phonetic                t
        google-translate-output-destination           'nil
        google-translate-listen-program               "mplayer")
  :bind ("C-c t" . google-translate-smooth-translate))


(use-package helm
  :ensure t
  :init
  :bind  (("M-x" . helm-M-x)
          ("C-x C-f" . helm-find-files)
          ("C-c h g" . helm-google-suggest)
          ("C-x C-d" . helm-browse-project)
          ("C-x b" . helm-mini)
          ("M-y" . helm-show-kill-ring)
          :map helm-map
          ("<tab>" . helm-execute-persistent-action)
          ("C-i" . helm-execute-persistent-action)
          ("C-z" . helm-select-action))
  :custom
  (helm-split-window-inside-p            t)
  (helm-move-to-line-cycle-in-source     t)
  (helm-ff-search-library-in-sexp        t)
  (helm-scroll-amount                    8)
  (helm-ff-file-name-history-use-recentf t)
  (helm-buffers-fuzzy-matching           t)
  (helm-recentf-fuzzy-match              t)
  :config
  (when (executable-find "curl")
    (setq helm-net-prefer-curl t))
  (helm-mode))

(use-package projectile :ensure t
  :custom
  (projectile-indexing-method 'native)
  (projectile-enable-caching t)
  (projectile-completion-system 'helm)
  (projectile-project-root-files #'(".projectile"))
  :config
  (projectile-mode))

(use-package helm-projectile
  :ensure t
  :after (projectile helm)
  :bind (("C-c x f" . helm-projectile))
  :custom
  (projectile-completion-system 'helm)
  :config
  (helm-projectile-on))

(use-package magit
  :ensure t
  :custom
  (git-commit-summary-max-length 50)
  (magit-auto-revert-mode nil)
  :bind (("C-x g" . magit-status)
         :map magit-mode-map
         ("C-c C-p" . magit-push-other)))

(use-package magit-gitflow
  :after magit
  :ensure t
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))

(use-package magit-todos
  :ensure t
  :after magit
  :hook (magit-status-mode  . magit-todos-mode)
  :bind ("C-x t" . helm-magit-todos))

(use-package bibtex-completion
  :ensure t)

(use-package helm-bibtex
  :ensure t
  :after (helm bibtex-completion)
  :defer t
  :custom
  (bibtex-completion-bibliography '("~/Dropbox/org/phd/research/refs.bib"))
  (bibtex-completion-library-path '("~/Dropbox/org/phd/research/papers/"))
  (bibtex-completion-notes-path "~/Dropbox/org/phd/research/notes/")
  (bibtex-completion-display-formats '((article       . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${journal:40}")
                                       (inbook        . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
                                       (incollection  . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
                                       (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
                                       (t             . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*}"))))

(use-package helm-tramp
  :ensure t
  :after (helm)
  :custom
  (tramp-default-method "ssh")
  (make-backup-files nil)
  (create-lockfiles nil)
  :config
  (define-key global-map (kbd "C-c s") 'helm-tramp)
  (add-hook 'helm-tramp-pre-command-hook
            #'(lambda ()
               ;; (global-aggressive-indent-mode 0)
			   (projectile-mode 0)
			   ;; (editorconfig-mode 0)
               ))
  (add-hook 'helm-tramp-quit-hook #'(lambda () (global-aggressive-indent-mode 1)
			                         (projectile-mode 1)
			                         (editorconfig-mode 1))))

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))

(use-package org-pdftools
  :ensure t
  :hook (org-load . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :ensure t
  :after org-noter
  :config
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(use-package transpose-frame :ensure t)
(use-package hydra
  :ensure t
  :config
  (defhydra hydra-window (global-map "C-S-o")
  "Windows"
  ("j" windmove-left "move left")
  ("k" windmove-down "move down")
  ("i" windmove-up "move up")
  ("l" windmove-right "move right")
  ("p" other-frame "move other frame")
  ("H" hydra-move-splitter-left "Expand to left")
  ("J" hydra-move-splitter-down "Expand to down")
  ("K" hydra-move-splitter-up "Expand to up")
  ("L" hydra-move-splitter-right "Expand to right")
  ("|" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)) "Split and move to right")
  ("_" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)) "Split and move to down")
  ("v" split-window-right "Split vertical")
  ("s" ace-swap-window)
  ("x" split-window-below "Split horizontal")
  ("f" make-frame "Create new frame" :exit t)
  ("F" delete-frame "Delete frame" :exit t )
  ("q" nil "Do nothing")
  ("b" helm-mini "buffers")))

(use-package ace-window :ensure t
  :custom (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))


(use-package helm-swoop
  :ensure t
  :bind (("C-c C-s" . helm-swoop)
         ("C-c C-r" . helm-multi-swoop)
         ("C-c C-a" . helm-multi-swoop-all))
  :custom
  (helm-multi-swoop-edit-save t)
  (helm-swoop-split-with-multiple-windows t)
  (helm-swoop-split-direction 'split-window-vertically)
  (helm-swoop-speed-or-color t)
  (helm-swoop-move-to-line-cycle t)
  (helm-swoop-use-line-number-face t)
  (helm-swoop-pre-input-function (lambda () "")))

(use-package resize-window
  :ensure t
  :bind ("C-c C-;" . resize-window))

(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed."
  (interactive)
  (if (y-or-n-p (format "¿Estás seguro que quieres salir de Emacs?"))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Salida cancelada.")))

(when window-system
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))

(use-package nov
  :ensure t
  :custom
  (nov-text-width 80)
  (visual-fill-column-center t)
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  :config
  (defun my-nov-font-setup ()
    (face-remap-add-relative 'variable-pitch
                             :family "Liberation Serif"
                             :height 1.0))
  (add-hook 'nov-mode-hook 'my-nov-font-setup)
  (add-hook 'nov-mode-hook 'visual-line-mode)
  (add-hook 'nov-mode-hook 'visual-fill-column-mode))

(use-package yasnippet
  :ensure t
  :defer t
  :hook
  (after-init . yas-global-mode)
  (prog-mode . yas-minor-mode)
  :config
  (yas-load-directory (expand-file-name "snippets" user-emacs-directory))
  (yas-global-mode))

(use-package ag :ensure t)

(use-package bufler
  :ensure t
  :bind ("C-x C-b" . bufler))

(use-package helm-bufler
  :ensure t
  :defer t)

(use-package fzf
  :ensure t
  :defer t
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        fzf/grep-command "grep -nrH"
        fzf/position-bottom t
        fzf/window-height 15))

(provide 'navegacion)
;;; navegacion.el ends here
