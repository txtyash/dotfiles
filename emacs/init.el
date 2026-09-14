;; -*- lexical-binding: t; -*-

;;; Package setup

;; Let Emacs write variables to custom.el instead of this file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(setq use-package-always-ensure t)

;;; UI

(menu-bar-mode -1)
(tab-bar-mode 1)
(tool-bar-mode -1)
;; remove title bar
(add-to-list 'default-frame-alist '(undecorated . t))
;; font & size
(set-face-attribute 'default nil :family "FiraCode Nerd Font" :height 118)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(setq make-pointer-invisible nil)

;;; Keybindings
(define-key minibuffer-local-map (kbd "C-p") #'previous-history-element)
(define-key minibuffer-local-map (kbd "C-n") #'next-history-element)

;;; Themes

(use-package ef-themes :defer t)
(use-package doom-themes :defer t)
(use-package spacemacs-theme :defer t)
(use-package auto-dark
  :custom
  (auto-dark-themes '((doom-badger) (spacemacs-light)))
  :config
  (auto-dark-mode 1))

;;; Editing & behavior

(repeat-mode 1)
(which-key-mode 1)
(editorconfig-mode 1)
(add-hook 'org-mode-hook #'visual-line-mode)
(setq user-mail-address "hello@textyash.com")
;; Auto-reread files changed on disk (e.g. by claude-code-ide)
(global-auto-revert-mode 1)
(setq auto-revert-avoid-polling t
      global-auto-revert-non-file-buffers t
      revert-without-query '(".*"))
;; Keep .#* lock files out of project dirs — their dangling symlinks
(make-directory "/tmp/emacs-lockfiles" t)
(setq lock-file-name-transforms
      '(("\\`/.*/\\([^/]+\\)\\'" "/tmp/emacs-lockfiles/\\1" t)))
;; Same for backup (*~) and auto-save (#*#) files — separate subsystems
(make-directory "/tmp/emacs-backups" t)
(make-directory "/tmp/emacs-autosaves" t)
(setq backup-directory-alist '((".*" . "/tmp/emacs-backups"))
      auto-save-file-name-transforms '((".*" "/tmp/emacs-autosaves/" t)))

;;; Eshell

(setq eshell-scroll-to-bottom-on-output nil)
(setq eshell-scroll-to-bottom-on-input nil)

;;; Git

(use-package magit
  :bind ("C-x g" . magit)
  ;; Hook flyspell for autocorrect during commit messages.
  :hook (git-commit-mode . flyspell-mode))

;;; Terminal & Claude Code

(use-package ghostel
  :config
  (setq ghostel-shell "fish"))
(use-package claude-code-ide
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el" :rev :newest)
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (setq claude-code-ide-terminal-backend 'ghostel
        claude-code-ide-show-claude-window-in-ediff nil
	claude-code-ide-switch-tab-on-ediff nil)
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

;;; LSP & languages

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-cycle t)
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(use-package yasnippet
  :init (yas-global-mode 1))

(use-package eglot
  :ensure nil
  :bind (:map eglot-mode-map
              ("C-c l i" . eglot-find-implementation)
              ("C-c l D" . eglot-find-declaration)
              ("C-c l t" . eglot-find-typeDefinition)
              ("C-c l r" . eglot-rename)
              ("C-c l a" . eglot-code-actions)
              ("C-c l f" . eglot-format))
  :config
  ;; svelteserver has no entry of its own in `eglot-server-programs'
  (add-to-list 'eglot-server-programs
               '(svelte-mode . ("svelteserver" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(yaml-mode . ("yaml-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(dockerfile-mode . ("docker-langserver" "--stdio"))))

(use-package consult-eglot
  :after eglot
  :bind (:map eglot-mode-map
              ("C-c l s" . consult-eglot-symbols)))

(use-package go-mode
  :hook ((go-mode . eglot-ensure)
         (before-save . gofmt-before-save)))

(use-package nix-mode
  :mode "\\.nix\\'"
  :hook (nix-mode . eglot-ensure))
(use-package nixfmt
  :hook (nix-mode . nixfmt-on-save-mode))

(use-package svelte-mode
  :mode "\\.svelte\\'"
  :hook (svelte-mode . eglot-ensure))

;; Tree-sitter grammars are not bundled with Emacs. `treesit-auto-install-grammar'
;; defaults to `ask', so the first .ts buffer offers to clone and compile these.
(setq treesit-language-source-alist
      '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx        "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")))

(use-package typescript-ts-mode
  :ensure nil
  :mode (("\\.ts\\'"  . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  :hook ((typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)))

(use-package css-mode
  :ensure nil
  :hook (css-mode . eglot-ensure))

(use-package yaml-mode
  :mode "\\.ya?ml\\'"
  :hook (yaml-mode . eglot-ensure))

(use-package dockerfile-mode
  :mode "Dockerfile\\(?:\\.[a-zA-Z0-9_-]+\\)?\\'"
  :hook (dockerfile-mode . eglot-ensure))

(use-package eldoc-box
  :bind ("C-c d" . eldoc-box-help-at-point))

;;; Tools

(use-package envrc
  :hook (after-init . envrc-global-mode))
(use-package dired-preview
  :hook (dired-mode . dired-preview-mode))

;;; Xref
(with-eval-after-load 'xref
  (add-hook 'xref--xref-buffer-mode-hook
            (lambda () (next-error-follow-minor-mode -1))))

;;; Org

(use-package org-journal
  :defer t
  :custom
  (org-journal-dir "~/org/journal/")
  (org-journal-file-format "%Y%m%d.org")
  :init
  (with-eval-after-load 'org
    (add-to-list 'org-agenda-files "~/org/journal/"))
  :bind
    (:map global-map
      ("C-c j" . org-journal-open-current-journal-file)))
