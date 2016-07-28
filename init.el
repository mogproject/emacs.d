;;============================================================================
;; init.el
;;============================================================================

;;----------------------------------------------------------------------------
;; Check version
;;----------------------------------------------------------------------------
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
