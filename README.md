# Emacs configuration

A portable Emacs setup. All shared configuration is tracked in git; anything
that is specific to a single machine (absolute paths, identity, private or
host-only packages) is kept out of git in `custom/local.el`.

## Layout

```
init.el              Entry point: bootstraps package managers, then loads modules
custom/              Feature modules, each loaded by init.el:
  setup-org.el         Org mode, agenda, capture, org-roam, babel
  ui.el                Theme, modeline, fonts, frame helpers
  edicion.el           Editing tweaks
  navegacion.el        Movement, tramp, projectile
  terminal.el          Terminal / shell
  lsp-support.el       LSP client configuration
  setup-js.el          JavaScript / TypeScript
  setup-cpp.el         C / C++
  setup-clj.el         Clojure
  latex-setup.el       LaTeX
  setup-md.el          Markdown
  setup-sql.el         SQL
  setup-py.el          Python
  local.el             Machine-local settings (NOT tracked -- see below)
snippets/            Yasnippet snippet definitions
```

`init.el` loads `custom/local.el` (when it exists) **before** the feature
modules, so local settings can define values the modules consume and can rely
on `use-package` being available.

## Machine-local configuration: `custom/local.el`

`custom/local.el` is **not** tracked by git (it is listed in `.gitignore`).
Each machine keeps its own copy. It is optional -- the tracked config loads
and runs without it -- but most machines will want at least an org root.

### Setting up a new machine

1. Create `custom/local.el`.
2. Add the settings this machine needs (see the template below).
3. Restart Emacs. Missing packages referenced from `local.el` install on
   first start like any other `use-package` declaration.

### What belongs in `local.el`

- **Host-specific paths.** The most important is the org root. `setup-org.el`
  declares `miguel/org-root` with a default of `~/org/`. Because it uses
  `defvar`, a value you `setq` in `local.el` (loaded first) takes precedence:

  ```elisp
  (setq miguel/org-root "~/path/to/your/org/")
  ```

  Everything in `setup-org.el` (agenda files, capture targets, org-roam
  directory) is derived from `miguel/org-root`.

- **Packages that only exist on, or only make sense for, this machine.**
  Declare them with `use-package` as usual.

- **Private / work configuration.** Load a separate untracked file so it is
  never committed:

  ```elisp
  (let ((private (expand-file-name "custom/private.el" user-emacs-directory)))
    (when (file-exists-p private)
      (load private nil 'nomessage)))
  ```

- **GUI preferences unique to this machine**, e.g. a maximized initial frame
  or a font that is only installed here.

### Template

```elisp
;;; local.el --- machine-local Emacs configuration (not tracked in git) -*- lexical-binding: t; -*-

;; Where org files live on this machine (consumed by setup-org.el).
(setq miguel/org-root "~/org/")

;; GUI preferences specific to this machine.
;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Host-only packages.
;; (use-package some-package
;;   :ensure t)

;; Private / work configuration, kept in its own untracked file.
;; (let ((private (expand-file-name "custom/private.el" user-emacs-directory)))
;;   (when (file-exists-p private)
;;     (load private nil 'nomessage)))

(provide 'local)
;;; local.el ends here
```

## `.gitignore`

The repository's `.gitignore` is itself intentionally untracked (it ignores
itself) so each clone can adjust what it excludes. It keeps out `custom/local.el`
and other private files, package-manager artifacts (`elpa/`, `straight/`,
`eln-cache/`), generated state and caches (databases, history, `recentf`,
compiled snippet caches), and editor noise (`*.elc`, backups). These all
regenerate automatically, so a fresh clone only needs the tracked source plus
a `custom/local.el`.
