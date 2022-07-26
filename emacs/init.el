;;; init.el --- Emacs Config -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; Don't load stale bytecode
(setq load-prefer-newer t)

;; Performance settings
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(defvar savefile-dir (expand-file-name "savefile" user-emacs-directory))

(setq visible-bell t)
(setq ring-bell-function 'ignore)

(set-frame-font "Fira Mono 14" nil t)
(load-theme 'adwaita t)

(tool-bar-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(global-display-line-numbers-mode)

;(global-hl-line-mode +1)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(global-auto-revert-mode t)

(set-default 'imenu-auto-rescan t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode +1))

(require 'hl-todo)
(global-hl-todo-mode 1)

(require 'flycheck)
(global-flycheck-mode +1)
(setq flycheck-checker-error-threshold 1000)

(require 'smartparens-config)
(add-hook 'prog-mode-hook #'smartparens-mode)

(require 'recentf)
(setq recentf-save-file (expand-file-name "recentf" savefile-dir)
      recentf-max-saved-items 500
      recentf-max-menu-items 15
      recentf-auto-cleanup 'never)
(recentf-mode +1)

(require 'saveplace)
(setq save-place-file (expand-file-name "saveplace" savefile-dir))
(save-place-mode 1)

(use-package flyspell
  :hook (text-mode . flyspell-mode))

(setq ispell-program-name "aspell"
	  ispell-extra-args '("--sug-mode=ultra"))

(require 'bookmark)
(setq bookmark-default-file (expand-file-name "bookmarks" savefile-dir)
      bookmark-save-flag 1)

(use-package editorconfig
  :diminish editorconfig-mode
  :init
  (editorconfig-mode 1))

(use-package lsp-mode
  :hook ((typescript-mode . lsp)
		 (rust-mode . lsp)))

(use-package projectile
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package treemacs
  :config
  (add-hook 'treemacs-mode-hook (lambda () (display-line-numbers-mode -1))))

(use-package rg
  :config
  (rg-enable-default-bindings))

(use-package smartparens-config
  :hook (prog-mode . smartparens-mode))

(use-package evil
  :ensure t
  :init
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package undo-fu
  :ensure t
  :config
  (evil-set-undo-system 'undo-fu))

(use-package avy
  :ensure t
  :bind (("C-:" . avy-goto-char)
		 ("C-'" . avy-goto-char-2)
		 ("C-c C-j" . avy-resume))
  :config
  (avy-setup-default))

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :bind (("C-c C-r" . ivy-resume)
		 :map ivy-mode-map
		 ("C-'" . ivy-avy))
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)))

(use-package counsel
  :ensure t
  :diminish counsel-mode
  :config
  (counsel-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9040edb21d65cef8a4a4763944304c1a6655e85aabb6e164db6d5ba4fc494a04" "1436985fac77baf06193993d88fa7d6b358ad7d600c1e52d12e64a2f07f07176" "3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "4eb6fa2ee436e943b168a0cd8eab11afc0752aebb5d974bba2b2ddc8910fca8f" "6bdcff29f32f85a2d99f48377d6bfa362768e86189656f63adbf715ac5c1340b" "78c4238956c3000f977300c8a079a3a8a8d4d9fee2e68bad91123b58a4aa8588" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "18bec4c258b4b4fb261671cf59197c1c3ba2a7a47cc776915c3e8db3334a0d25" "bf798e9e8ff00d4bf2512597f36e5a135ce48e477ce88a0764cfb5d8104e8163" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" default))
 '(package-selected-packages
   '(undo-fu evil-surround swiper-helm counsel ivy evil rg vterm zenburn-theme which-key use-package typescript-mode smartparens projectile magit lsp-ui lsp-treemacs hl-todo gruvbox-theme flycheck exec-path-from-shell editorconfig dracula-theme diminish company color-theme-sanityinc-tomorrow)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
