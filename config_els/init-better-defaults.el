(global-auto-revert-mode 1)
;;This configuration will delete the content that being selected,
;;when we paste something.
(delete-selection-mode 1)

(setq auto-save-default nil)
(setq make-backup-files nil)

;;This function only can be used on 25.1, it will cause 24.5 initing crash, so
;;just comment it now.

;;Highlighten parentheses whenever the cursor is.
;(define-advice show-paren-function (:around (fn) fix-show-paren-function)
;  "Highlight enclosing parentheses."
;  (cond ((looking-at-p "\\s(") (funcall fn))
;   (t (save-excursion
;        (ignore-errors (backward-up-list))
;        (funcall fn)))))

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;Insert 4 spaces instead of TAB.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-stop-list (number-sequence 4 120 4))
(defvaralias 'c-basic-offset 'tab-width)

(defun indent-buffer ()
  "Indent all lines of current buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
    (progn
      (indent-region (region-beginning) (region-end))
      (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))


(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                     try-expand-dabbrev-all-buffers
                     try-expand-dabbrev-from-kill
                     try-complete-file-name-partially
                     try-complete-file-name
                     try-expand-all-abbrevs
                     try-expand-list
                     try-expand-line
                     try-complete-lisp-symbol-partially
                     try-complete-lisp-symbol))

;;Used for dired-mode
(fset 'yes-or-no-p 'y-or-n-p)
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

;;Prevent dired-mode to create so many different temporary buffers.
(put 'dired-find-alternate-file 'disabled nil)

;;Open dired-mode with current file's path.
(require 'dired-x)

;;Copy files between two dired-mode.
(setq dired-dwim-target 1)

;;Set default font type and size.
(set-default-font "-*-DejaVu Sans Mono-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")

;;Remove Windows' end mark of line.
;;Just use "C-x RET f unix" to set the file encoding can make sense.

;;Enable mouse operation when emacs is used in a terminal.
(xterm-mouse-mode 1)

;;Smooth Scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;;Modify line wrapping character from '\' to '↩'
(set-display-table-slot standard-display-table 'wrap ?\↩)

;;Whitespace minor mode use buffer-display-table directly, so we need to add a hook.
(defun modify-line-wrap ()
  (set-display-table-slot buffer-display-table 'wrap ?\↩))

(add-hook 'find-file-hook 'modify-line-wrap)

;;Make whitespaces visible.
(global-whitespace-mode)
;;All numbers are Unicode codepoint in decimal. try (insert-char 182 ) to see it.
(setq whitespace-display-mappings
      '(
        (space-mark 32 [183]) ; 32 SPACE, 183 MIDDLE DOT 「·」
        (newline-mark 10 [182 10]) ; 10 LINE FEED
        (tab-mark 9 [8677 9]) ; 9 TAB, 9677 RIGHTWARDS ARROW TO BAR 「⇥」
        ))

(provide 'init-better-defaults)
