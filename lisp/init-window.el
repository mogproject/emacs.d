;;----------------------------------------------------------------------------
;; Window Options
;;----------------------------------------------------------------------------

;; window size
(setq default-frame-alist
      (append (list
               '(top . 0)
               '(left . 0)
               '(width . 232)
               '(height . 60)
               ) default-frame-alist))

;; themes
(custom-set-faces
 '(fa-face-hint ((t (:background "#3f3f3f" :foreground "#ffffff"))))
 '(fa-face-hint-bold ((t (:background "#3f3f3f" :weight bold))))
 '(fa-face-semi ((t (:background "#3f3f3f" :foreground "#ffffff" :weight bold))))
 '(fa-face-type ((t (:inherit (quote font-lock-type-face) :background "#3f3f3f"))))
 '(fa-face-type-bold ((t (:inherit (quote font-lock-type-face) :background "#999999" :bold t)))))

'(custom-enabled-themes (quote (wombat)))

;; colors
(setq default-frame-alist
      (append (list
               '(foreground-color . "azure1")
               '(background-color . "black")
               ) default-frame-alist))



;; fonts
(add-to-list 'default-frame-alist '(font . "Essential PragmataPro"))


(provide 'init-window)

