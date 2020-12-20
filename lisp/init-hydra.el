;; fixes hydra interaction with modeline and cursors
(setq hydra--work-around-dedicated nil)

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
(global-set-key (kbd "C-f") #'hydra-move/forward-char)
(global-set-key (kbd "C-b") #'hydra-move/backward-char)

;; multi-cursors
(defhydra hydra-multi-cursors (:hint nil)
  "
     ^Up^            ^Down^        ^Miscellaneous^
----------------------------------------------
[_p_]   Next    [_n_]   Next    [_l_] Edit lines
[_P_]   Skip    [_N_]   Skip    [_a_] Mark all
[_M-p_] Unmark  [_M-n_] Unmark  [_q_] Quit"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("q" nil))
(global-set-key (kbd "C->") #'hydra-multi-cursors/body)


;; window switching and editing
(defhydra hydra-set-window ()
  ("<tab>" other-window "switch")
  ("p" other-frame "other frame")
  ("0" delete-window "delete window")
  ("1" delete-other-windows "single window")
  ("2" split-window-below "split bottom")
  ("3" split-window-right "split right")
  ("5" make-frame-command "new frame")
  ("q" nil "quit" :color red)
  )
(global-set-key (kbd "C-x 3") #'hydra-set-window/split-window-right)
(global-set-key (kbd "C-x 2") #'hydra-set-window/split-window-below)

(provide 'init-hydra)
