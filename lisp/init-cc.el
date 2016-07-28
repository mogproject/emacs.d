;;----------------------------------------------------------------------------
;; C/C++ Settings
;;----------------------------------------------------------------------------

;; styles
(require 'cc-mode)
 
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-default-style "k&r")
            (setq indent-tabs-mode nil)
            (setq c-basic-offset 2)
            ))

;; load header files as C++ mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; irony-mode
(use-package irony
  :ensure t
  :defer t
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  :config
  ;; replace the `completion-at-point' and `complete-symbol' bindings in
  ;; irony-mode's buffers by irony-mode's function
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )

;; company-mode
(use-package company
  :ensure t
  :defer t
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (use-package company-irony :ensure t :defer t)
  (setq company-idle-delay              0
        company-minimum-prefix-length   2
        company-show-numbers            t
        company-tooltip-limit           20
        company-dabbrev-downcase        nil
        company-selection-wrap-around   t
        company-backends                '((company-irony company-gtags))
        )
  :bind ("C-;" . company-complete-common)
  )

;; flycheck
(use-package flycheck
  :ensure t
  :defer t
  :init
  (add-hook 'c-mode-common-hook 'flycheck-mode)
  :config
  (use-package flycheck-pos-tip)
  (use-package flycheck-irony)
;  (use-package flycheck-google-cpplint)
  (setq flycheck-display-errors-delay 0.5
        flycheck-display-errors-function #'flycheck-pos-tip-error-messages
        )
  (flycheck-irony-setup)
;  (flycheck-add-next-checker 'c/c++-cppcheck
;                             '(warning . c/c++-googlelint))
  :commands
  flycheck-mode
  :bind
  ("C-M-n" . flycheck-next-error)
  ("C-M-p" . flycheck-previous-error)
  )


(provide 'init-cc)

