2;;; navegacion.el --- Summary
;;; Commentary:
;;; Code:

;; Load helm-core first to avoid autoload issues
(use-package helm-core
  :ensure t
  :demand t)

(global-unset-key (kbd "s-q"))

(setq org-reveal-root               "http://cdn.jsdelivr.net/reveal.js/3.0.0/"
      uniquify-buffer-name-style    'forward)
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)
(global-set-key (kbd "C-c C-t") 'vterm)
(fset 'yes-or-no-p 'y-or-n-p)

(when (eq system-type 'darwin)
  (setq ns-command-modifier 'meta
        ns-option-modifier 'super))


(use-package tramp
  :custom
  (tramp-default-method "sshx")
  (tramp-verbose 1)
  (vc-ignore-dir-regexp
   (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))
  (tramp-inline-compress-start-size 1000000)
  (tramp-backup-directory-alist backup-directory-alist)
  (remote-file-name-inhibit-cache t)
  (tramp-use-scp-direct-remote-copying t)
  (remote-file-name-inhibit-auto-save-visited t)
  (tramp-completion-reread-directory-timeout nil)
  (tramp-copy-size-limit (* 1024 1024))
  (magit-tramp-pipe-stty-settings 'pty)
  (tramp-ssh-controlmaster-options
   (concat "-o ControlPath=/tmp/ssh-%%r@%%h:%%p "
           "-o ControlMaster=auto "
           "-o ControlPersist=yes "
           "-o Compression=yes"))
  (projectile-mode-line "Projectile")
  :config
  (add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp nil))
  (connection-local-set-profile-variables
   'remote-direct-async-prcess
   '((tramp-direct-async-process . t)))
  (connection-local-set-profiles
   '(:application-tramp :protocol "scp")
   'remote-direct-async-process)
  (with-eval-after-load 'tramp
    (with-eval-after-load 'compile
      (remove-hook 'compilation-mode-hook #'tramp-compile-disable-ssh-controlmaster-options)))
  (remove-hook 'evil-insert-state-exit-hook #'doom-modeline-update-buffer-file-name)
  (remove-hook 'find-file-hook #'doom-modeline-update-buffer-file-name)
  (remove-hook 'find-file-hook 'forge-bug-reference-setup)
  (advice-add 'projectile-project-root :around
              (lambda (orig-fn &rest args)
                (unless (file-remote-p default-directory)
                  (apply orig-fn args)))))

;; (benchmark-run 1 (find-file "/sshx:cloud:/tmp/foo1.txt"))

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

(unless (fboundp 'facemenu-set-face)
  (defun facemenu-set-face (face &optional start end)
    (when (and start end)
      (put-text-property start end 'face face))))

(use-package google-translate
  :ensure t
  :bind ("C-c t" . google-translate-smooth-translate)
  :init
  (setq google-translate-backend-method 'curl
        google-translate-translation-directions-alist '(("es" . "en")
                                                        ("en" . "es")
                                                        ("es" . "fr")
                                                        ("fr" . "es")))
  (defun google-translate--search-tkk () "Search TKK." (list 430675 2721866130))
  :config
  (require 'google-translate-smooth-ui)
  (setq google-translate-show-phonetic                t
        google-translate-output-destination           'nil
        google-translate-listen-program               "mplayer"))


(with-eval-after-load 'helm-files
  (defun helm-ff--in-backup-directory ()
    (when backup-directory-alist
      (cl-loop for (_p . f) in backup-directory-alist
               when f
               thereis (file-equal-p f helm-ff-default-directory)))))

(use-package helm
  :ensure t
  :demand t
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
  :hook (helm-after-initialize . (lambda () (with-helm-buffer (display-line-numbers-mode -1))))
  :config
  (setq helm-ff-backup-directory         "~/.emacs.d/backups")
  (when (executable-find "curl")
    (setq helm-net-prefer-curl t))
  (helm-mode))

(use-package projectile :ensure t
  :custom
  (projectile-indexing-method 'native)
  (projectile-enable-caching t)
  (projectile-completion-system 'helm)
  (projectile-project-root-files #'(".projectile"))
  (projectile-project-search-path '(("/home/miguel/src" . 2)))
  (projectile-globally-ignored-directories
   '("node_modules" "coverage" "dist" "build" "lib"
     "log" "storybook-output" ".storybook"
     ".agents" ".perf-results" ".kiro" ".vscode" ".husky"
     "stories" ".git" ".cache" "output" ".sass-cache"
     ".idea" ".gradle" "target"))
  (projectile-globally-ignored-file-suffixes '(".map" ".log" ".pid" ".seed"))
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
  :straight t
  :custom
  (git-commit-summary-max-length 50)
  (magit-auto-revert-mode nil)
  (magit-show-long-lines-warning nil)
  (magit-commit-show-diff nil)
  (magit-branch-direct-configure nill)
  (magit-refresh-status-buffer nil)
  :bind (("C-x g" . magit-status)
         :map magit-mode-map
         ("C-c C-p" . magit-push-other)))

(use-package magit-gitflow
  :after magit
  :straight t
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))

(use-package magit-todos
  :straight t
  :after magit
  :config (magit-todos-mode 1)
  :bind ("C-x t" . helm-magit-todos))

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


;; helm-swoop removed from MELPA; use helm-occur instead
(global-set-key (kbd "C-c C-s") 'helm-occur)

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

(global-set-key (kbd "C-x C-c") 'ask-before-closing)

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


(use-package ultra-scroll
  :vc (:url "https://github.com/jdtsmith/ultra-scroll") ; if desired (emacs>=v30)
  :init
  (setq scroll-conservatively 3 ; or whatever value you prefer, since v0.4
        scroll-margin 0)        ; important: scroll-margin>0 not yet supported
  :config
  (ultra-scroll-mode 1))

(provide 'navegacion)
;;; navegacion.el ends here
