
;; disable splash screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; don't store any backup files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(setq backup-directory-alist
          `(("." . ,(concat user-emacs-directory "backups"))))

;; maximize screen on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; turn off the annoying bell
(setq visible-bell 1)

;; delete section default
(delete-selection-mode 1)

;; usefull shortcuts
(global-set-key [f3] 'comment-region)
(global-set-key [f4] 'uncomment-region)

;; enable visual-line-mode
;(global-visual-line-mode t)

;; line and column numbering
(column-number-mode 1)
(line-number-mode 1)

;; faster to quit
(fset 'yes-or-no-p 'y-or-n-p)

;; disable extraneous bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; prettify all symbols
(global-prettify-symbols-mode 1)

;; indentation
(setq-default tab-width 4)
(setq standard-indent 4)

;; display matching parenthesis
(show-paren-mode 1)

;; refresh buffers when any file change
(global-auto-revert-mode t)

;; color identifiers mode
;(add-hook 'after-init-hook 'global-color-identifiers-mode)

;; rainbow delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; expand region keybinding
(global-set-key (kbd "C-=") 'er/expand-region)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; multi-term
(require 'multi-term)
(setq multi-term-program "/bin/bash")

;; log files to use json mode
(add-to-list 'auto-mode-alist '("\\.log\\'" . json-mode))

(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-word-1)

(global-set-key (kbd "C-x o") 'ace-window)

(defvar aw-dispatch-alist
  '((?x aw-delete-window "Delete Window")
        (?m aw-swap-window "Swap Windows")
        (?M aw-move-window "Move Window")
        (?j aw-switch-buffer-in-window "Select Buffer")
        (?n aw-flip-window)
        (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
        (?c aw-split-window-fair "Split Fair Window")
        (?v aw-split-window-vert "Split Vert Window")
        (?b aw-split-window-horz "Split Horz Window")
        (?o delete-other-windows "Delete Other Windows")
        (?? aw-show-dispatch-help))
  "List of actions for `aw-dispatch-default'.")

(setq-default c-basic-offset 4
                          tab-width 4
                          indent-tabs-mode t)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'company 
'(add-to-list 'company-backends '(company-irony-c-headers company-irony)))

(eval-after-load 'flycheck
   '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(eval-after-load
  'company
  '(add-to-list 'company-backends #'company-omnisharp))

(defun my-csharp-mode-setup ()
  (omnisharp-mode)
  (company-mode)
  (flycheck-mode)

  (setq indent-tabs-mode nil)
  (setq c-syntactic-indentation t)
  (c-set-style "ellemtel")
  (setq c-basic-offset 4)
  (setq truncate-lines t)
  (setq tab-width 4)
  (setq evil-shift-width 4)

  (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
  (local-set-key (kbd "C-c C-c") 'recompile))

(add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)

(add-hook 'web-mode-hook  'emmet-mode)
(add-hook 'web-mode-before-auto-complete-hooks
    '(lambda ()
     (let ((web-mode-cur-language
            (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "php")
           (yas-activate-extra-mode 'php-mode)
         (yas-deactivate-extra-mode 'php-mode))
               (if (string= web-mode-cur-language "css")
           (setq emmet-use-css-transform t)
         (setq emmet-use-css-transform nil)))))

;; require and turn on flycheck globally
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable flycheck for emacs lisp
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; the default value was '(save idle-change new-line mode-enabled)
;; having this enabled only checks syntax on SAVE
;(setq flycheck-check-syntax-automatically '(save mode-enable))

;; movement
(defhydra hydra-move
  (:body-pre (next-line))
  "move"
  ("n" next-line)
  ("p" previous-line)
  ("f" forward-char)
  ("b" backward-char)
  ("a" beginning-of-line)
  ("e" move-end-of-line)
  ("v" scroll-up-command)
  ("V" scroll-down-command)
  ("l" recenter-top-bottom)
  ("q" nil "quit" :color blue))
(global-set-key (kbd "C-b") #'hydra-move/backward-char)

;; zooming
(defhydra hydra-zoom ()
  "zoom"
  ("+" text-scale-increase "in")
  ("-" text-scale-decrease "out")
  ("0" (text-scale-adjust 0) "reset")
  ("q" nil "quit" :color blue))

(global-set-key (kbd "C-:") 'iedit-mode)

;; start js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist `(,(rx ".jsx" string-end) . js2-mode))

;; disable js2 mode errors, we have eslint
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

;; disable jshint because eslint > jshint prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
;;this is to avoid errors for incompatible versions in different projects
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))

(global-set-key (kbd "C-x g") 'magit-status)

;; set key for magit popup
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; neotree theme with all-the-icons
(require 'all-the-icons)
(setq neo-theme (if (display-graphic-p) 'nerd))

;; set f8 to toggle
(global-set-key [f8] 'neotree-toggle)

;; do not refresh
(setq neo-autorefresh nil)

;; auto re-read files on disk
;; NOTE: use case is for neotree
(global-auto-revert-mode t)

;; in case for slower performance
(setq inhibit-compacting-font-caches t)

(setq neo-window-width 20)

(add-hook 'python-mode-hook 'anaconda-mode)

;; enable eldoc
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

;; use company-anaconda
(eval-after-load "company"
 '(add-to-list 'company-backends 'company-anaconda))

(smartparens-global-mode t)

;; electric return with specified modes
(with-eval-after-load 'smartparens
  (sp-with-modes
      '(c++-mode objc-mode c-mode js-mode js2-mode typescript-mode css-mode web-mode json-mode python-mode)
        (sp-local-pair "(" nil :post-handlers '(:add ("||\n[i]" "RET")))
        (sp-local-pair "[" nil :post-handlers '(:add ("||\n[i]" "RET")))
    (sp-local-pair "{" nil :post-handlers '(:add ("||\n[i]" "RET")))))

(global-set-key (kbd "C-s") 'swiper)
(setq ivy-display-style 'fancy)

;;advise swiper to recenter on exit
(defun bjm-swiper-recenter (&rest args)
  "recenter display after swiper"
  (recenter)
  )
(advice-add 'swiper :after #'bjm-swiper-recenter)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; set up tide mode after web-mode tsx
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; set up tide mode after js2 mode 
(add-hook 'js2-mode-hook #'setup-tide-mode)

;; set up tide mode after web-mode for jsx
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

;; custom settings for web-mode
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-enable-current-element-highlight t)
  (set (make-local-variable 'company-backends) '(company-css company-web-html company-yasnippet company-files))
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

;;web-mode  for HTML
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;web-mode for EJS files (might change it to something better)
(add-to-list 'auto-mode-alist '("\\.ejs?\\'" . web-mode))

;; use web-mode for reactjs .jsx files
;(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;; use web-mode for .tsx files
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

;; use web-mode for .cshtml files
(add-to-list 'auto-mode-alist '("\\.cshtml\\'" . web-mode))

;; better jsx syntax-highlighting in web-mode
;; courtesy of Patrick @halbtuerke. DOPE AS FUCK!
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; enable typescript-tslint checker in web mode
(flycheck-add-mode 'typescript-tslint 'web-mode)

(yas-global-mode 1)

(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd ".") 'company--my-insert-dot)
  (define-key company-active-map (kbd "C-d") #'company-abort)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(company-quickhelp-mode)

;; hook projectile mode to programming modes
(add-hook 'prog-mode-hook 'projectile-mode)

;; use helm for projectile completion
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; use helm buffer list because it's better
(global-set-key (kbd "C-x b") 'helm-buffers-list)

;; additional ignored directories to be added to projectile globally ignored directories
(setq additional-ignored-directories '("node_modules" "elpa"
                                                                           ))
(setq projectile-globally-ignored-directories (append projectile-globally-ignored-directories additional-ignored-directories))

;; additional ignored files to be added to projectile globally ignored files
(setq additional-ignored-files '("*.png" "*.jpg" "*.md"
                                                                 "polyfills.js" "package.json" "package-lock.json"
                                 "*.dll" "*.targets" "*.props" "*.pdb" "*.deps.json" "*.exe"
                                 "*.linux-x86_64" "*.gz"
                                                                 ".gitignore"))
(setq projectile-globally-ignored-files (append projectile-globally-ignored-files additional-ignored-files))

;; caching projectile
(setq projectile-enable-caching t)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
