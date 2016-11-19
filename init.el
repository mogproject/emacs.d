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
;; Initialize
;;----------------------------------------------------------------------------
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-common)
(require 'init-backup)
(require 'init-appearance)
(if *is-window* (require 'init-window))
(if *is-mac* (require 'init-mac))

(require 'init-package)
(require 'init-cc)


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

