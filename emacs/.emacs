;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)



;; -------------
;; Plugins
;; -------------

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)

;; Enably system clipboard is tty mode
(unless (package-installed-p 'clipetty)
  (package-install 'clipetty))
(require 'clipetty)
(global-clipetty-mode)


;; Add file explorer
(unless (package-installed-p 'ranger)
  (package-install 'ranger))
(require 'ranger)
(setq ranger-show-hidden t)

;; Ensure that 'save-place' is enabled to remember the cursor position
(save-place-mode 1)

(use-package nix-mode
  :ensure t
  :mode (("\\.nix\\'" . nix-mode)))




;; -------------
;; Look and feel
;; -------------
(scroll-bar-mode -1) ;; Disable the ugly scoll, tool and menu bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(line-number-mode 1) ;; Enable line and column numbering in modeline
(column-number-mode 1)

;; Follow symlinks
(setq vc-follow-symlinks t)

;; Syntax highlighting
(setq font-lock-maximum-decoration t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(format-all ranger evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Theme
(unless (package-installed-p 'catppuccin-theme)
  (package-install 'catppuccin-theme))
(load-theme 'catppuccin :no-confirm)
