;;; package --- Summary
;;; commentary:
;;; code:

(use-package rainbow-delimiters :ensure t)

(defconst package-init-time (emacs-init-time)
  "Record down the package initialize time.")

(use-package dashboard
  :ensure t
  :demand t
  :custom
  (dashboard-banner-logo-title "[D I D D Y • E M A C S]")
  (dashboard-footer-icon "")
  (dashboard-footer "╬ Copyright © 2024 Miguel Piña ╬")
  (dashboard-center-content t)
  (dashboard-set-navigator t)
  (dashboard-startup-banner 'logo)
  (dashboard-set-navigator nil)
  (dashboard-items '((agenda . 5)
                     (recents . 5)
                     (projects . 5)))
  (dashboard-week-agenda t)
  (dashboard-item-names '(("Recent Files:"               . "Recently opened files:")
                          ("Agenda for today:"           . "Today's agenda:")
                          ("Agenda for the coming week:" . "Agenda:")))
  (dashboard-insert-init-info t)
  (dashboard-insert-init-info t)
  :hook
  (dashboard-mode . (lambda () (display-line-numbers-mode -1)))
  :config
  (dashboard-setup-startup-hook)
  (add-to-list 'dashboard-items '(agenda) t))

;; Themes and the heavier graphical packages are installed here but ACTIVATED
;; conditionally: a rich look for GUI frames and a lean, terminal-friendly look
;; for TUI frames. See the appearance dispatch at the end of this file.
;; modus-vivendi (the TUI theme) is built in, so it needs no package.
(use-package dracula-theme :ensure t :defer t)
(use-package all-the-icons :ensure t :defer t)
(use-package nerd-icons :ensure t :defer t)
(use-package all-the-icons-dired
  :ensure t :defer t
  :after all-the-icons)
(use-package doom-modeline
  :ensure t :defer t
  :custom
  (doom-modeline-project-detection 'auto)
  (doom-modeline-window-width-limit 80)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-buffer-file-name-style 'truncate-except-project)
  (doom-modeline-buffer-name t)
  (doom-modeline-highlight-modified-buffer-name t)
  (doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
  (doom-modeline-battery t))
(use-package beacon
  :ensure t :defer t
  :custom
  (beacon-blink-duration 1)
  (beacon-color "red")
  (beacon-size 60)
  (beacon-push-mark 10))
(menu-bar-mode -1)

(setq org-src-fontify-natively t)

(use-package anzu
  :ensure t
  :config (global-anzu-mode))

;; Setup para eliminar mode-line

(defun mode-line-render (left right)
  "Return a string of `window-width' length.
It containing LEFT, and RIGHT aligned respectively."
  (let* ((available-width (- (window-total-width) (length left) )))
    (format (format "%%s %%%ds" available-width) left right)))

(setq-default line-spacing 0)

(blink-cursor-mode 0)

(defvar current-time-format "%a %H:%M"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")


(defface mood-line-buffer-name
  '((t (:inherit (mode-line-buffer-id))))
  "Face used for major mode indicator in the mode-line."
  :group 'mood-line)


(defface mood-line-major-mode
  '((t (:inherit (bold))))
  "Face used for major mode indicator in the mode-line."
  :group 'mood-line)

(defface mood-line-status-neutral
  '((t (:inherit (shadow))))
  "Face used for neutral or inactive status indicators in the mode-line."
  :group 'mood-line)

(defface mood-line-status-info
  '((t (:inherit (font-lock-keyword-face))))
  "Face used for generic status indicators in the mode-line."
  :group 'mood-line)

(defface mood-line-status-success
  '((t (:inherit (success))))
  "Face used for success status indicators in the mode-line."
  :group 'mood-line)


(defface mood-line-status-warning
  '((t (:inherit (warning))))
  "Face for warning status indicators in the mode-line."
  :group 'mood-line)

(defface mood-line-status-error
  '((t (:inherit (error))))
  "Face for error stauts indicators in the mode-line."
  :group 'mood-line)

(defface mood-line-unimportant
  '((t (:inherit (shadow))))
  "Face used for less important mode-line elements."
  :group 'mood-line)

(defface mood-line-modified
  '((t (:inherit (error))))
  "Face used for the 'modified' indicator symbol in the mode-line."
  :group 'mood-line)

(defun mood-line--string-trim-left (string)
  "Remove whitespace at the beginning of STRING."
  (if (string-match "\\`[ \t\n\r]+" string)
      (replace-match "" t t string)
    string))

(defun mood-line--string-trim-right (string)
  "Remove whitespace at the end of STRING."
  (if (string-match "[ \t\n\r]+\\'" string)
      (replace-match "" t t string)
    string))

(defun mood-line--string-trim (string)
  "Remove whitespace at the beginning and end of STRING."
  (mood-line--string-trim-left (mood-line--string-trim-right string)))

(defun mood-line--format (left right)
  "Return a string of `window-width' length.
It containing LEFT and RIGHT, aligned respectively."
  (let ((reserve (length right)))
    (concat left
            " "
            (propertize " "
                        'display `((space :align-to (- right ,reserve))))
            right)))


(defvar-local mood-line--vc-text nil)
(defun mood-line--update-vc-segment (&rest _)
  "Update `mood-line--vc-text' against the current VCS state."
  (setq mood-line--vc-text
        (when (and vc-mode buffer-file-name)
          (let ((backend (vc-backend buffer-file-name))
                (state (vc-state buffer-file-name (vc-backend buffer-file-name))))
            (let ((face 'mode-line-neutral))
              (concat (cond ((memq state '(edited added))
                             (setq face 'mood-line-status-info)
                             (propertize "+ " 'face face))
                            ((eq state 'needs-merge)
                             (setq face 'mood-line-status-warning)
                             (propertize "⟷ " 'face face))
                            ((eq state 'needs-update)
                             (setq face 'mood-line-status-warning)
                             (propertize "↑ " 'face face))
                            ((memq state '(removed conflict unregistered))
                             (setq face 'mood-line-status-error)
                             (propertize "✖ " 'face face))
                            (t
                             (setq face 'mood-line-status-neutral)
                             (propertize "✔ " 'face face)))
                      (propertize (concat " " (substring vc-mode (+ (if (eq backend 'Hg) 2 3) 2)))
                                  'face face
                                  'mouse-face face)
                      "  "))))))

(defvar-local mood-line--flycheck-text nil)
(defun mood-line--update-flycheck-segment (&optional status)
  "Update `mood-line--flycheck-text' against the reported flycheck STATUS."
  (setq mood-line--flycheck-text
        (pcase status
          ('finished (if flycheck-current-errors
                         (let-alist (flycheck-count-errors flycheck-current-errors)
                           (let ((sum (+ (or .error 0) (or .warning 0))))
                             (propertize (concat "⚑ Issues: "
                                                 (number-to-string sum)
                                                 "  ")
                                         'face (if .error
                                                   'mood-line-status-error
                                                 'mood-line-status-warning))))
                       (propertize "✔ Good  " 'face 'mood-line-status-success)))
          ('running (propertize "Δ Checking  " 'face 'mood-line-status-info))
          ('errored (propertize "✖ Error  " 'face 'mood-line-status-error))
          ('interrupted (propertize "⏸ Paused  " 'face 'mood-line-status-neutral))
          ('no-checker ""))))

(defun mood-line-segment-vc ()
  "Displays color-coded version control information in the mode-line."
  mood-line--vc-text)

(defun mood-line-segment-modified ()
  "Displays a color-coded buffer modification/read-only indicator in the mode-line."
  (if (not (string-match-p "\\*.*\\*" (buffer-name)))
      (if (buffer-modified-p)
          (propertize "● " 'face 'mood-line-modified)
        (if (and buffer-read-only (buffer-file-name))
            (propertize "■ " 'face 'mood-line-unimportant)
          "  "))
    "  "))

(defun mood-line-segment-anzu ()
  "Displays color-coded anzu status information in the mode-line (if available)."
  (when (and (boundp 'anzu--state) anzu--state)
    (cond ((eq anzu--state 'replace-query)
           (format #("Replace: %d  " 0 11 (face mood-line-status-warning)) anzu--cached-count))
          (anzu--overflow-p
           (format #("%d/%d+  " 0 3 (face mood-line-status-info) 3 6 (face mood-line-status-error)) anzu--current-position anzu--total-matched))
          (t
           (format #("%d/%d  " 0 5 (face mood-line-status-info)) anzu--current-position anzu--total-matched)))))


(defun mood-line-segment-major-mode ()
  "Displays the current major mode in the mode-line."
  (concat (propertize " " 'face 'mood-line-major-mode)
          (format-mode-line mode-name 'mood-line-major-mode) "  "))


(defun mood-line-segment-flycheck ()
  "Displays color-coded flycheck information in the mode-line (if available)."
  mood-line--flycheck-text)

(defun mood-line-segment-flymake ()
  "Displays information about the current status.
It comming from flymake in the mode-line (if available)."
  (when (and (boundp 'flymake-mode) flymake-mode)
    (concat (mood-line--string-trim (format-mode-line flymake--mode-line-format)) "  ")))

(add-hook 'find-file-hook #'mood-line--update-vc-segment)
(add-hook 'after-save-hook #'mood-line--update-vc-segment)
(add-hook 'flycheck-status-changed-functions #'mood-line--update-flycheck-segment)
(add-hook 'flycheck-mode-hook #'mood-line--update-flycheck-segment)

(setq-default header-line-format
              '(:eval (mode-line-render
                       (format-mode-line
                        (list
                         (mood-line-segment-modified)
                         (propertize " " 'face 'mood-line-status-success)
                         (propertize "%b " 'face 'mood-line-buffer-name)
                         '(:eval (when (and buffer-file-name (buffer-modified-p))
                                   (propertize "(modified) "
                                               'face 'mood-line-status-warning)))
                         (mood-line-segment-anzu)
                         "- "
                         (propertize (concat " " (format-time-string current-time-format (current-time)))
                                     'face `(:weight light))))
                       (format-mode-line
                        (list
                         (mood-line-segment-flycheck)
                         (mood-line-segment-major-mode)
                         (mood-line-segment-flymake)
                         (mood-line-segment-vc)
                         "["
                         (propertize "%4l:" 'face 'mood-line-status-success)
                         (propertize "%3c"  'face (if (>= (current-column) 80)
                                                      'font-lock-warning-face
                                                    `(:weight light :foreground "#aaaaaa")))
                         "]    ")
                        ))))

(set-face-attribute 'header-line nil
                    :underline t
                    :weight 'bold)

;; doom-modeline disabled: the hand-rolled header-line above is now the single
;; statusline. Re-enable by uncommenting if you want the bottom mode-line back.
;; (use-package doom-modeline
;;   :ensure t
;;   :hook (after-init . doom-modeline-mode)
;;   :custom
;;   (doom-modeline-project-detection 'auto)
;;   (doom-modeline-window-width-limit 80)
;;   (doom-modeline-icon nil)
;;   (doom-modeline-major-mode-icon nil)
;;   (doom-modeline-major-mode-color-icon nil)
;;   (doom-modeline-buffer-file-name-style 'truncate-except-project)
;;   (doom-modeline-buffer-name t)
;;   (doom-modeline-highlight-modified-buffer-name t)
;;   (doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
;;   (doom-modeline-battery nil))

;; setup

(use-package olivetti :ensure t
  :custom
  (olivetti-body-width 120))

(defconst miguel/font "input 16")
(ignore-errors (set-frame-font miguel/font))
(setq-default column-number-mode t ;; Muestra la linea y la columna.
              frame-title-format "%b (%f)" ;; Path completo en la barra de títulos.
              ring-bell-function 'ignore)
(setq display-line-numbers-type t)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)
(show-paren-mode 1)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(defun remove-bars ()
  "Elimina la barra de menús, de scroll y de herramientas."
  (interactive)
  (menu-bar-mode 1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1))

(when window-system
  (remove-bars))

(defun update-font ()
  "Actualiza la fuente del frame."
  (interactive)
  (set-frame-font miguel/font))

(ignore-errors (update-font))

(defun fullscreen ()
  "Función para poner a Emacs en pantalla completa."
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(global-set-key (kbd "C-x <f3>") 'remove-bars)
(global-set-key (kbd "C-<f3>") 'update-font)
(global-set-key (kbd "<f11>") 'fullscreen)

(defun hide-lat-num ()
  (display-line-numbers-mode 0))

(global-prettify-symbols-mode 1)

(use-package rainbow-mode
  :ensure t
  :hook (text-mode prog-mode))

;;; --------------------------------------------------------------------------
;;; GUI vs TUI look and feel
;;;
;;; GUI frames get the rich graphical look (dracula theme, doom-modeline with
;;; icons, beacon). TUI frames (for example inside tmux) keep the lean,
;;; terminal-friendly look (modus-vivendi theme, the hand-rolled header-line
;;; above, no icons). Themes are global in Emacs, so under a daemon serving
;;; both GUI and terminal clients the most recently focused frame type wins for
;;; the theme; each frame otherwise gets its correct modeline/icons.
;;; --------------------------------------------------------------------------

(defun miguel/refresh-dashboard-if-visible ()
  "Re-render the *dashboard* buffer in its own window if it is currently shown.
Lets an appearance change (icons on/off) take effect without stealing focus."
  (when (and (fboundp 'dashboard-refresh-buffer)
             (get-buffer "*dashboard*"))
    (let ((win (get-buffer-window "*dashboard*" t)))
      (when win
        (with-selected-window win
          (dashboard-refresh-buffer))))))

(defun miguel/apply-gui-appearance ()
  "Apply the rich graphical look for GUI frames."
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'dracula t)
  (require 'all-the-icons nil t)
  (require 'nerd-icons nil t)
  (when (fboundp 'all-the-icons-dired-mode)
    (add-hook 'dired-mode-hook #'all-the-icons-dired-mode))
  (when (fboundp 'doom-modeline-mode) (doom-modeline-mode 1))
  (when (fboundp 'beacon-mode) (beacon-mode 1))
  ;; Dashboard icons (nerd-icons) only make sense in a graphical frame.
  (setq dashboard-set-file-icons t
        dashboard-set-heading-icons t
        dashboard-icon-type 'nerd-icons
        dashboard-heading-icons '((recents   . "nf-oct-file")
                                  (bookmarks . "nf-oct-bookmark")
                                  (agenda    . "nf-oct-calendar")
                                  (projects  . "nf-oct-file_directory")
                                  (registers . "nf-oct-database")))
  (miguel/refresh-dashboard-if-visible))

(defun miguel/apply-tui-appearance ()
  "Apply the lean, terminal-friendly look for TUI frames."
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'modus-vivendi t)
  (when (fboundp 'all-the-icons-dired-mode)
    (remove-hook 'dired-mode-hook #'all-the-icons-dired-mode))
  (when (fboundp 'doom-modeline-mode) (doom-modeline-mode -1))
  (when (fboundp 'beacon-mode) (beacon-mode -1))
  ;; No icons in the terminal dashboard (they render as boxes there).
  (setq dashboard-set-file-icons nil
        dashboard-set-heading-icons nil)
  (miguel/refresh-dashboard-if-visible))

(defun miguel/apply-appearance (&optional frame)
  "Apply GUI or TUI appearance based on FRAME's display type.
FRAME defaults to the selected frame.  Interactively, re-applies the look for
the current frame."
  (interactive)
  (with-selected-frame (or frame (selected-frame))
    (if (display-graphic-p)
        (miguel/apply-gui-appearance)
      (miguel/apply-tui-appearance))))

;; Apply immediately for the initial frame, and for every new frame under a
;; daemon so GUI and terminal clients each get the right look.
(if (daemonp)
    (add-hook 'after-make-frame-functions #'miguel/apply-appearance)
  (miguel/apply-appearance))

(provide 'ui)
;;; ui.el ends here
