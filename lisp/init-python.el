;; -*- coding: utf-8; lexical-binding: t; -*-
(setq interpreter-mode-alist
      (cons '("python" . python-mode) interpreter-mode-alist))

(use-package elpy
  :ensure t
  :init
  :config
    ;; run command `pip install jedi flake8 importmagic` in shell,
    ;; or just check https://github.com/jorgenschaefer/elpy
    (elpy-enable)

    ;; http://emacs.stackexchange.com/questions/3322/python-auto-indent-problem/3338#3338
    ;; emacs 24.4 only
    (setq electric-indent-chars (delq ?: electric-indent-chars))
  )

(provide 'init-python)
