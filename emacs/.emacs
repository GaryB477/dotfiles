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

;; Ensure that 'save-place' is enabled to remember the cursor position
(save-place-mode 1)

;; LSP
(unless (package-installed-p 'lsp-mode)
  (package-install 'lsp-mode))
(require 'lsp-mode)



;; -------------
;; Look and feel
;; -------------
(scroll-bar-mode -1) ;; Disable the ugly scoll, tool and menu bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(line-number-mode 1) ;; Enable line and column numbering in modeline
(column-number-mode 1)

(custom-set-variables
 '(package-selected-packages '(evil)))
(custom-set-faces
 )

;; Theme
(unless (package-installed-p 'catppuccin-theme)
  (package-install 'catppuccin-theme))
(load-theme 'catppuccin :no-confirm)
