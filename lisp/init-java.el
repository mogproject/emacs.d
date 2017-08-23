;;----------------------------------------------------------------------------
;; Java Settings
;;----------------------------------------------------------------------------

(require 'eclim)
(require 'eclimd)

;(global-eclim-mode)

(add-hook 'java-mode-hook 'eclim-mode)

;;----------------------------------------------------------------------------
;; auto complete
;;----------------------------------------------------------------------------
;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)
;; add the emacs-eclim source
(require 'ac-emacs-eclim)
(ac-emacs-eclim-config)

;; for company-mode
;; (require 'company-emacs-eclim)
;; (company-emacs-eclim-setup)


;(add-to-list 'ac-modes 'jde-mode)

;(global-flycheck-mode -1)

(provide 'init-java)

