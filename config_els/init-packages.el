(require 'cl)

(when (>= emacs-major-version 24)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  )

;;Add whatever packages you want here
(defvar johnson/packages '(
               company
               monokai-theme
               swiper
               counsel
               smartparens
               popwin
               xcscope
               undo-tree
               origami
               expand-region
               tabbar
               yasnippet
               auto-yasnippet
               elpy
               flycheck
               py-autopep8
               mwim
               ) "Default packages")

(defun johnson/packages-installed-p ()
  (loop for pkg in johnson/packages
    when (not (package-installed-p pkg)) do (return nil)
    finally (return t)))

(unless (johnson/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg johnson/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;;Config for swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-ignore-buffers '("\\` " "\\`\\*"))

;;Config for smartparens
(smartparens-global-mode 1)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

;;Config for popwin
(require 'popwin)
(popwin-mode 1)

;;Config for xcscope
(require 'xcscope)
(cscope-setup)

;;Config for undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;;Config for origami
(require 'origami)
(global-origami-mode)

;;Config for xclip
(xclip-mode 1)

;;Config for expand-region
(require 'expand-region)

;;Config for tabbar
(tabbar-mode 1)

;;Config for Emacs Lisp Python Environment
(elpy-enable)

;;Use flycheck instead of flymake in elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;;Formatting python files by PEP8 rules on saving
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;Use YASnippet as a non-global minor mode, call yas-reload-all to load the snippet tables and then call yas-minor-mode
;;from the hooks of major-modes where we want YASnippet enabled.
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

(load-theme 'monokai t)

(global-company-mode 1)

;;Cycling file buffers.
(defun switch-file-buffer (switch-buffer)
  "Call switch-buffer until current buffer is not non-file associated buffer."
  (interactive)
  (let ((bread-crumb (buffer-name)))
    (funcall switch-buffer)
    (while
        (and
         (string-match-p "^\*" (buffer-name))
         (not (equal bread-crumb (buffer-name))))
      (funcall switch-buffer))))

(defun next-file-buffer ()
  "Switch to next file associated buffer."
  (interactive)
  (switch-file-buffer 'next-buffer))

(defun previous-file-buffer ()
  "Switch to previous file associated buffer."
  (interactive)
  (switch-file-buffer 'previous-buffer))

(provide 'init-packages)
