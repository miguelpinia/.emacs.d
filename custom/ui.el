(use-package rainbow-delimiters :ensure t)

(defconst package-init-time (emacs-init-time)
  "Record down the package initialize time.")

(use-package all-the-icons)

(use-package all-the-icons-dired
  :ensure t
  :defer t
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package projectile :ensure t
  :custom
  (projectile-indexing-method 'native)
  (projectile-enable-caching t)
  (projectile-completion-system 'helm)
  :config
  (projectile-global-mode))

(use-package dashboard
  :ensure t
  :custom
  (dashboard-banner-logo-title "[D I D D Y • E M A C S]")
  (dashboard-footer-icon "")
  (dashboard-footer "╬ Copyright © 2020 Miguel Piña ╬")
  (dashboard-center-content t)
  (dashboard-set-navigator t)
  (dashboard-startup-banner 'logo)
  (dashboard-set-navigator nil)
  (dashboard-items '((agenda . 5)
                     (recents . 5)
                     (projects . 5)))
  (dashboard-insert-init-info t)
  (dashboard-insert-init-info t)
  (dashboard-set-file-icons t)
  (dashboard-set-heading-icons t)
  (dashboard-heading-icons '((recents . "file-text")
                             (bookmarks . "bookmark")
                             (agenda . "calendar")
                             (projects . "file-directory")
                             (registers . "database")))
  :hook
  (dashboard-mode . (lambda () (linum-mode -1)))
  :config
  (dashboard-setup-startup-hook))

(add-to-list 'custom-theme-load-path "~/.emacs.d/temas")
(use-package dracula-theme :ensure t)
;; (load-theme 'dracula t)

(defun mode-line-render (left right)
  "Return a string of `window-width' length containing left, and
   right aligned respectively."
  (let* ((available-width (- (window-total-width) (length left) )))
    (format (format "%%s %%%ds" available-width) left right)))

(set-frame-parameter (selected-frame) 'internal-border-width 10)
(setq x-underline-at-descent-line t)
(setq-default line-spacing 0)

(blink-cursor-mode 0)
(fringe-mode '(0 . 0))

(defvar current-time-format "%a %H:%M"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(setq-default header-line-format
              '(:eval (mode-line-render
                       (format-mode-line
                        (list
                         (propertize "File " 'face `(:weight regular))
                         "%b "
                         '(:eval (if (and buffer-file-name (buffer-modified-p))
                                     (propertize "(modified) "
                                                 'face `(:weight light
                                                                 :foreground "#aaaaaa"))))
                         "- "
                         (propertize (format-time-string current-time-format (current-time))
                                     'face `(:weight light))))
                       (format-mode-line
                        (propertize "[%l:%c]   "
                                    'face `(:weight light
						    :foreground "#aaaaaa"))))))

(setq-default mode-line-format "")

(set-face-attribute 'header-line nil
                    :height 110
                    :underline "white"
                    )
(set-face-attribute 'mode-line nil
                    :height 10
                    :underline "white"
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :box nil
                    :inherit 'mode-line)
(set-face-attribute 'mode-line-buffer-id nil
                    :weight 'light)


(defconst miguel/font "input 11")
(set-frame-font miguel/font)
(setq-default column-number-mode t ;; Muestra la linea y la columna.
              frame-title-format "%b (%f)" ;; Path completo en la barra de títulos.
              ring-bell-function 'ignore)
(global-hl-line-mode 1)
(show-paren-mode 1)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(defun remove-bars ()
  "Elimina la barra de menús, de scroll y de herramientas."
  (interactive)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1))

(when window-system
  (remove-bars))

(defun update-font ()
  "Actualiza la fuente del frame."
  (interactive)
  (set-frame-font miguel/font))

(defun fullscreen ()
  "Función para poner a Emacs en pantalla completa."
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(global-set-key (kbd "C-x <f3>") 'remove-bars)
(global-set-key (kbd "C-<f3>") 'update-font)
(global-set-key (kbd "<f11>") 'fullscreen)

(defun hide-lat-num ()
  (linum-mode 0))

(global-prettify-symbols-mode 1)

(setq org-hide-emphasis-markers t)

(provide 'ui)
