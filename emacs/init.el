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
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(set-frame-font "Iosevka Term 14" nil t)
;; (load-theme 'wombat t)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(setq-default indicate-empty-lines t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq js-indent-level 2)

(electric-pair-mode 1)

;; (global-display-line-numbers-mode)
;;
;; (dolist (mode '(help-mode-hook
;;                 messages-buffer-mode-hook
;;                 dired-mode-hook
;;                 ement-room-mode-hook
;;                 treemacs-mode-hook
;;                 eshell-mode-hook
;;                 term-mode-hook
;;                 vterm-mode-hook))
;;   (add-hook mode (lambda () (display-line-numbers-mode 0))))
;;
(dolist (mode '(prog-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; (setq-default show-trailing-whitespace t)
;;
;; (dolist (mode '(vterm-mode-hook
;;                 Buffer-menu-mode-hook
;;                 calendar-mode-hook))
;;   (add-hook mode (lambda () (setq show-trailing-whitespace nil))))
;;
(add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))

;(global-hl-line-mode +1)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(global-auto-revert-mode t)

(set-default 'imenu-auto-rescan t)

(setq dired-use-ls-dired t
      ;; consider --group-directories-first
      dired-listing-switches "-ahl"
      dired-dwim-target t)

(setq tramp-default-method "ssh")

;; consider underscore character a part of word
;; can't use superword-mode due to a bug in evil-mode: https://github.com/emacs-evil/evil/issues/721
(add-hook 'prog-mode-hook
          (lambda ()
            (modify-syntax-entry ?_ "w")))

;; (unless (display-graphic-p)
;;   (xterm-mouse-mode 1))
(xterm-mouse-mode 1)

(when (string= system-type "darwin")
  (setq insert-directory-program "/opt/homebrew/bin/gls"))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

(use-package diminish)

(use-package all-the-icons)

(use-package doom-themes
  :config
  (load-theme 'doom-solarized-light t))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))

(use-package which-key
  :diminish which-key-mode
  :init
  (setq which-key-idle-delay 0.3)
  :config
  (which-key-mode +1))

(use-package hl-todo
  :config
  (global-hl-todo-mode 1))

(use-package flycheck
  :init
  (setq flycheck-checker-error-threshold 1000)
  :config
  (global-flycheck-mode +1))

;; (use-package smartparens
;;   :diminish smartparens-mode
;;   :hook (prog-mode . smartparens-mode)
;;   :init
;;   (require 'smartparens-config))

;; ;; (use-package smartparens-config
;; ;;  :hook (prog-mode . smartparens-mode))

(use-package recentf
  :init
  (setq recentf-save-file (expand-file-name "recentf" savefile-dir)
	recentf-max-saved-items 500
	recentf-max-menu-items 15
	recentf-auto-cleanup 'never)
  :config
  (recentf-mode +1))

(use-package saveplace
  :init
  (setq save-place-file (expand-file-name "saveplace" savefile-dir))
  :config
  (save-place-mode 1))

(use-package flyspell
  :hook (text-mode . flyspell-mode))

(setq ispell-program-name "aspell"
	  ispell-extra-args '("--sug-mode=ultra"))

(use-package bookmark
  :init
  (setq bookmark-default-file (expand-file-name "bookmarks" savefile-dir)
	bookmark-save-flag 1))

(use-package editorconfig
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

(use-package typescript-mode)

(use-package rustic
  :config
  (setq rustic-format-trigger 'on-save)
  (push 'rustic-clippy flycheck-checkers)
  (setq rustic-lsp-client 'eglot))

(use-package lsp-mode
  :hook ((typescript-mode . lsp)
		 ;;(rust-mode       . lsp)
		 (lsp-mode        . lsp-enable-which-key-integration)))

(use-package lsp-ivy)

(use-package lsp-ui)

(add-to-list 'load-path "~/.emacs.d/emacs-prisma-mode")
(require 'prisma-mode)

(use-package eglot
  :hook ((prisma-mode . eglot-ensure)
         (rust-mode   . eglot-ensure)
         (nix-mode    . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(prisma-mode . ("prisma-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(nix-mode . ("nil"))))

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))

(use-package treemacs)

(use-package rg
  :config
  (rg-enable-default-bindings))

;; (use-package undo-fu
;;   :config
;;   (evil-set-undo-system 'undo-fu))

(use-package undo-tree
  :diminish
  :init
  (setq undo-tree-auto-save-history nil)
  :config
  (global-undo-tree-mode))

(use-package avy
  :bind (("C-:" . avy-goto-char)
		 ("C-'" . avy-goto-char-2)
		 ("C-c C-j" . avy-resume))
  :config
  (avy-setup-default))

(use-package ivy
  :diminish
  :bind (("C-c C-r" . ivy-resume)
		 :map ivy-mode-map
		 ("C-'" . ivy-avy)
		 :map ivy-switch-buffer-map
		 ("C-d" . ivy-switch-buffer-kill))
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :config
  (ivy-rich-mode 1))

(use-package swiper
  :bind (("C-s" . swiper)))

(use-package counsel
  :diminish counsel-mode
  :config
  (counsel-mode))

(use-package company
  :diminish
  :bind (:map company-active-map
			  ("C-n" . company-select-next)
			  ("C-p" . company-select-previous))
  :init
  (setq company-idle-delay 0.3)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (setq company-format-margin-function #'company-text-icons-margin)
  ;(setq company-text-icons-add-background t)
  :config
  (global-company-mode t))

(use-package projectile
  :diminish projectile-mode
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  ("s-p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired)
  :config
  (projectile-mode))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit)

(use-package forge
  :after magit
  :init
  (setq auth-sources '("~/.authinfo")))

(use-package goto-chg)

(use-package evil
  :init
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-tree))

(add-hook 'calculator-mode-hook (lambda () (evil-emacs-state)))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :after evil
  :diminish
  :config
  (evil-commentary-mode))

(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))

(use-package evil-visualstar
  :after evil
  :config
  (global-evil-visualstar-mode))

(use-package evil-collection
  :after evil
  :diminish evil-collection-unimpaired-mode
  :config
  (evil-collection-init))

(use-package tree-sitter
  :hook (tree-sitter-after-on . tree-sitter-hl-mode)
  :config
  (global-tree-sitter-mode))

(use-package tree-sitter-langs)

(use-package direnv
  :config
  (direnv-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package vterm
  :hook (vterm-mode . (lambda ()
                        (setq-local evil-insert-state-cursor 'box)
                        (setq-local evil-normal-state-cursor 'hollow)
                        (evil-insert-state))))

(use-package multi-vterm)

(use-package prettier
  :hook (prisma-mode . (lambda () (prettier-mode -1)))
  :config
  (global-prettier-mode))

(use-package adaptive-wrap
  :custom
  (adaptive-wrap-extra-indent 4))

;; (use-package all-the-icons-dired
;;   :hook (dired-mode . all-the-icons-dired-mode))

(use-package ement
  :hook (ement-room-mode . (lambda ()
                             (evil-emacs-state))))

(use-package golden-ratio
  :init
  ;; (setq golden-ratio-auto-scale t)
  (setq golden-ratio-extra-commands
		'(windmove-left windmove-right windmove-down windmove-up
          evil-window-left evil-window-right evil-window-down evil-window-up)))

(use-package aggressive-indent)

(use-package mastodon
  :hook (mastodon-mode . (lambda () (evil-emacs-state)))
  :init
  (setq mastodon-instance-url "https://hachyderm.io"
        mastodon-active-user "aqrln"))

(use-package yaml-mode)

(use-package org
  :hook (org-mode . (lambda ()
                      (org-indent-mode)
                      (visual-line-mode 1))))

(use-package org-bullets
  :after org
  :hook (org-mode . (lambda ()
                      (org-bullets-mode 1))))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package dockerfile-mode)

(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))

(use-package general
  :config
  (general-create-definer my-leader-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-define-key
   "s-{" 'tab-bar-switch-to-prev-tab
   "s-}" 'tab-bar-switch-to-next-tab)

  (general-define-key
   "s-H" 'evil-window-left
   "s-J" 'evil-window-down
   "s-K" 'evil-window-up
   "s-L" 'evil-window-right
   "s-w" 'evil-window-delete)

  (general-define-key
   "s-b" 'ivy-switch-buffer)

  (general-define-key
   "M-<tab>" 'company-complete)

  (my-leader-def
	"ff" 'counsel-find-file
	"fd" 'dired

    "bb" 'ivy-switch-buffer
    "bi" 'ibuffer

	"gg" 'magit-status
	"gr" 'golden-ratio-mode

	;; "l" 'lsp-command-map
	"p" 'projectile-command-map

    ;; "ls" 'eglot-server-menu
    "lf" 'eglot-format
    "aa" 'eglot-code-actions
    "ao" 'eglot-code-action-organize-imports
    "af" 'eglot-code-action-quickfix
    "ae" 'eglot-code-action-extract
    "ai" 'eglot-code-action-inline
    "ar" 'eglot-code-action-rewrite
    "lF" 'lsp-ui-flycheck-list

	"vv" 'multi-vterm
	"vp" 'multi-vterm-project
	"vP" 'multi-vterm-prev
	"vN" 'multi-vterm-next
    "v ESC" 'vterm-send-escape)

  ;; (my-leader-def
  ;;  :keymaps 'eglot-mode-map
  ;;  :states '(normal visual)
  ;;  "aa" 'eglot-code-actions
  ;;  "ao" 'eglot-code-action-organize-imports
  ;;  "af" 'eglot-code-action-quickfix
  ;;  "ae" 'eglot-code-action-extract
  ;;  "ai" 'eglot-code-action-inline
  ;;  "ar" 'eglot-code-action-rewrite)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2f8eadc12bf60b581674a41ddc319a40ed373dd4a7c577933acaff15d2bf7cc6" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "443e2c3c4dd44510f0ea8247b438e834188dc1c6fb80785d83ad3628eadf9294" "680f62b751481cc5b5b44aeab824e5683cf13792c006aeba1c25ce2d89826426" "51c71bb27bdab69b505d9bf71c99864051b37ac3de531d91fdad1598ad247138" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "016f665c0dd5f76f8404124482a0b13a573d17e92ff4eb36a66b409f4d1da410" "512ce140ea9c1521ccaceaa0e73e2487e2d3826cc9d287275550b47c04072bc4" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "2dd4951e967990396142ec54d376cced3f135810b2b69920e77103e0bcedfba9" "570263442ce6735821600ec74a9b032bc5512ed4539faf61168f2fdf747e0668" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "0c83e0b50946e39e237769ad368a08f2cd1c854ccbcd1a01d39fdce4d6f86478" "1cae4424345f7fe5225724301ef1a793e610ae5a4e23c023076dc334a9eb940a" "be84a2e5c70f991051d4aaf0f049fa11c172e5d784727e0b525565bb1533ec78" "f458b92de1f6cf0bdda6bce23433877e94816c3364b821eb4ea9852112f5d7dc" "944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "0c08a5c3c2a72e3ca806a29302ef942335292a80c2934c1123e8c732bb2ddd77" "631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "6945dadc749ac5cbd47012cad836f92aea9ebec9f504d32fe89a956260773ca4" "9040edb21d65cef8a4a4763944304c1a6655e85aabb6e164db6d5ba4fc494a04" "1436985fac77baf06193993d88fa7d6b358ad7d600c1e52d12e64a2f07f07176" "3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "4eb6fa2ee436e943b168a0cd8eab11afc0752aebb5d974bba2b2ddc8910fca8f" "6bdcff29f32f85a2d99f48377d6bfa362768e86189656f63adbf715ac5c1340b" "78c4238956c3000f977300c8a079a3a8a8d4d9fee2e68bad91123b58a4aa8588" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "18bec4c258b4b4fb261671cf59197c1c3ba2a7a47cc776915c3e8db3334a0d25" "bf798e9e8ff00d4bf2512597f36e5a135ce48e477ce88a0764cfb5d8104e8163" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" default))
 '(package-selected-packages
   '(dockerfile-mode docker-mode nix-mode org-tempo org-bullets yaml-mode mastodon aggressive-indent aggressive-indent-mode golden-ratio lsp-ivy ement all-the-icons-dired all-the-icons adaptive-wrap prettier undo-tree multi-vterm general rustic rainbow-delimiters counsel-projectile direnv tree-sitter-langs tree-sitter evil-commentary doom-themes ivy-rich undo-fu evil-surround swiper-helm counsel ivy evil rg vterm zenburn-theme which-key use-package typescript-mode smartparens projectile magit lsp-ui lsp-treemacs hl-todo gruvbox-theme flycheck exec-path-from-shell editorconfig dracula-theme diminish company color-theme-sanityinc-tomorrow)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
