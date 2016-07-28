;;----------------------------------------------------------------------------
;; Auto Completion
;;----------------------------------------------------------------------------

(use-package auto-complete
  :diminish auto-complete-mode
  :config
  (progn
    (setq ac-use-fuzzy t
          ac-disable-inline t
          ac-use-menu-map t
          ac-auto-show-menu t
          ac-auto-start t
          ac-ignore-case t
          ac-candidate-menu-min 0)
    )
  )


(provide 'init-completion)

