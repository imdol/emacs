;; enable company mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; remap the keys for company active maps
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd ".") 'company--my-insert-dot)
  (define-key company-active-map (kbd "C-d") #'company-abort)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))
