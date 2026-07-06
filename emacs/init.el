;; -*- lexical-binding: t; -*-
;; Let Emacs write variables to custom.el instead of this file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(menu-bar-mode -1)
(tab-bar-mode 1)
(tool-bar-mode -1)
;; remove title bar
(add-to-list 'default-frame-alist '(undecorated . t))
;; font & size
(set-face-attribute 'default nil :family "FiraCode Nerd Font" :height 118)
(repeat-mode 1)
(which-key-mode 1)
(editorconfig-mode 1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(setq user-mail-address "hello@textyash.com")
(setq make-pointer-invisible nil)
(setq eshell-scroll-to-bottom-on-output nil)
(setq eshell-scroll-to-bottom-on-input nil)
(setq use-package-always-ensure t)
(use-package magit
  :bind ("C-x g" . magit)
  ;; Hook flyspell for autocorrect during commit messages.
  :hook (git-commit-mode . flyspell-mode))
(use-package ghostel
  :config
  (setq ghostel-shell "fish"))
(use-package claude-code-ide
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el" :rev :newest)
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (setq claude-code-ide-terminal-backend 'ghostel)
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	 (nix-mode . lsp-deferred)
         (go-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp lsp-deferred)
(use-package flycheck)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package nix-mode
  :mode "\\.nix\\'")
(use-package go-mode
  :hook (before-save . gofmt-before-save))
(use-package nix-mode)
(use-package nixfmt
  :hook (nix-mode . nixfmt-on-save-mode))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package dired-preview
  :hook (dired-mode . dired-preview-mode))
(use-package ef-themes :defer t)
(use-package doom-themes :defer t)
(use-package spacemacs-theme :defer t)
(use-package auto-dark
  :custom
  (auto-dark-themes '((doom-badger) (spacemacs-light)))
  :config
  (auto-dark-mode 1))
(use-package org-journal
  :defer t
  :custom
  (org-journal-dir "~/org/journal/")
  (org-journal-file-format "%Y%m%d.org")
  :init
  (with-eval-after-load 'org
    (add-to-list 'org-agenda-files "~/org/journal/")))
