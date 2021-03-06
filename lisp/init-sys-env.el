;; beacon mode
(setq-default
 blink-cursor-interval 0.5
 beacon-color "#ffb6c1"
 beacon-blink-duration 0.5
 beacon-size 50)
(beacon-mode)

;; toggle scroll bar here
(toggle-scroll-bar -1)

;; doom mode-line
(use-package doom-modeline
  :config
  (setq-default doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (doom-modeline-mode)
  )

;; zone/idle
(use-package zone
  :defer t
  :config
  (zone-when-idle 6000)
  )

;; no font caches during GC
;;(setq-default inhibit-compacting-font-caches t)

(provide 'init-sys-env)
