;;; Compiled snippets and support files for `makefile-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'makefile-mode
		     '(("cl" "clean:\n	${1:rm -r ${2:\\$(${3:OUTDIR})}}\n$0\n" "clean" nil nil
			((yas-indent-line 'fixed))
			"/home/slispe/.emacs.d/elpa/yasnippet-snippets-20190316.1019/snippets/makefile-mode/clean" nil nil)
		       ("all" "all:\n        $0" "all" nil nil nil "/home/slispe/.emacs.d/elpa/yasnippet-snippets-20190316.1019/snippets/makefile-mode/all" nil nil)))


;;; Do not edit! File generated at Sun Apr 14 17:10:34 2019