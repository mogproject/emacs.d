;;============================================================================
;; init.el
;;============================================================================

;;----------------------------------------------------------------------------
;; Check version
;;----------------------------------------------------------------------------

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))

(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

;;----------------------------------------------------------------------------
;; Constants
;;----------------------------------------------------------------------------
(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-window* (boundp 'window-system))

;;----------------------------------------------------------------------------
;; Colors
;;----------------------------------------------------------------------------
(set-face-attribute 'region nil :foreground "#ffffff" :background "#006600")

;;----------------------------------------------------------------------------
;; Initialize
;;----------------------------------------------------------------------------
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-common)
(require 'init-backup)
(require 'init-appearance)
(if *is-window* (require 'init-window))
(if *is-mac* (require 'init-mac))

(require 'init-package)
;(require 'init-cc)


(provide 'init)

;;----------------------------------------------------------------------------
;; JavaScript
;;----------------------------------------------------------------------------
(setq js-indent-level 2)

;;----------------------------------------------------------------------------
;; Disable electric-indent-mode
;;----------------------------------------------------------------------------
(electric-indent-mode 0)

;;----------------------------------------------------------------------------
;; Clipboard access
;;----------------------------------------------------------------------------

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; '(package-selected-packages
;   (quote
;    (jedi flycheck-pos-tip flycheck-irony use-package flycheck company-irony))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fa-face-hint ((t (:background "#3f3f3f" :foreground "#ffffff"))))
 '(fa-face-hint-bold ((t (:background "#3f3f3f" :weight bold))))
 '(fa-face-semi ((t (:background "#3f3f3f" :foreground "#ffffff" :weight bold))))
 '(fa-face-type ((t (:inherit (quote font-lock-type-face) :background "#3f3f3f"))))
 '(fa-face-type-bold ((t (:inherit (quote font-lock-type-face) :background "#999999" :bold t)))))
