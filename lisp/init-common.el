;;----------------------------------------------------------------------------
;; Common Editing Options
;;----------------------------------------------------------------------------

;; coding
;(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; C-h for delete
(keyboard-translate ?\C-h ?\C-?)

;; show line numbers
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d ")

;; highlight parenthes
(show-paren-mode 1)

;; disable final newline insertion
(setq require-final-newline nil)

;; tab settings
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; scroll settings
(setq scroll-error-top-bottom t)

;; electric indent mode (Emacs >=24.4)
;(electric-indent-mode -1)


(provide 'init-common)
