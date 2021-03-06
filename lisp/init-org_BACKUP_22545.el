;; -*- coding: utf-8; lexical-biding: t; -*-

;; some cool org tricks
;; @see http://emacs.stackexchange.com/questions/13820/inline-verbatim-and-code-with-quotes-in-org-mode

;; {{ NO spell check for embedded snippets
(defun org-mode-is-code-snippet ()
  (let* (rlt
         (begin-regexp "^[ \t]*#\\+begin_\\(src\\|html\\|latex\\|example\\)")
         (end-regexp "^[ \t]*#\\+end_\\(src\\|html\\|latex\\|example\\)")
         (case-fold-search t)
         b e)
    (save-excursion
      (if (setq b (re-search-backward begin-regexp nil t))
          (setq e (re-search-forward end-regexp nil t))))
    (if (and b e (< (point) e)) (setq rlt t))
    rlt))

;; no spell check for property
(defun org-mode-current-line-is-property ()
  (string-match-p "^[ \t]+:[A-Z]+:[ \t]+" (my-line-str)))

;; Various preferences
(setq org-log-done t
      org-completion-use-ido t
      org-edit-src-content-indentation 0
      org-edit-timestamp-down-means-later t
      org-agenda-start-on-weekday nil
      org-agenda-span 14
      org-agenda-include-diary t
      org-agenda-window-setup 'current-window
      org-fast-tag-selection-single-key 'expert
      org-export-kill-product-buffer-when-displayed t
      ;; org v7
      org-export-odt-preferred-output-format "doc"
      ;; org v8
      org-odt-preferred-output-format "doc"
      org-tags-column 80
      ;; org-startup-indented t
      ;; {{ org 8.2.6 has some performance issue. Here is the workaround.
      ;; @see http://punchagan.muse-amuse.in/posts/how-i-learnt-to-use-emacs-profiler.html
      org-agenda-inhibit-startup t ;; ~50x speedup
      org-agenda-use-tag-inheritance nil ;; 3-4x speedup
      ;; }}
      )

;; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets '((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5)))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(defadvice org-refile (around org-refile-hack activate)
  ;; when `org-refile' scanning org files, disable user's org-mode hooks
  (let* ((force-buffer-file-temp-p t))
    ad-do-it))


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)"))))

;; -------------------------------------------
;; Org package
;; -------------------------------------------
(use-package org
  :ensure t
  :config
<<<<<<< HEAD
    (add-hook 'org-mode-hook 'org-mode-hook-setup)
=======
    (global-set-key (kbd "C-c l") 'org-store-link)
    (global-set-key (kbd "C-c a") 'org-agenda)
    (when (fboundp 'org-iswitchb)
	(global-set-key (kbd "C-c b") 'org-iswitchb))
    (when (fboundp 'org-switchb)
	(global-set-key (kbd "C-c b") 'org-switchb))
    (global-set-key (kbd "C-c c") 'org-capture)
    ;; subtree editing
    (global-set-key (kbd "C-c i") 'org-insert-heading)
    (global-set-key (kbd "C-c d") 'org-do-demote)
    (global-set-key (kbd "C-c u") 'org-do-promote)
    (setq org-imenu-depth 9)
    ;; @see http://irreal.org/blog/1
    (setq org-src-fontify-natively t)
    ;; Org mode default directory and files
    (setq org-directory (expand-file-name "~/Dropbox/org_notes"))
	;; Set default notes capture path
    (setq org-default-notes-file (concat org-directory "/inbox.org"))
    ;; set default org-agenda-files location
    (setq org-agenda-files (list "~/Dropbox/org_notes/work.org"
				 "~/Dropbox/org_notes/inbox.org"
				 "~/Dropbox/org_notes/notes.org"))

    (setq org-capture-templates '(("t" "Todo [inbox]" entry
				(file+headline "~/Dropbox/org_notes/inbox.org" "Tasks")
				"* TODO %i%?")
				("n" "Note [notes]" entry
				(file+headline "~/Dropbox/org_notes/notes.org" "Notes")
				"* NOTE %i%?")
				("d" "Daily review [review]" plain
				(file+datetree "~/Dropbox/daily_review.org")
				"%K - %a\n%i\n%?\n"
				:unnarrowed t)
				("w" "Weekly review [review]" plain
				(file+datetree "~/Dropbox/weekly_review.org")
				"%K - %a\n%i\n%?\n"
				:unnarrowed t)
				  ))
>>>>>>> 1eb04b98f1ca4e655504c3ada7ad76dd036ae656
    )

(defun org-mode-hook-setup ()
  (unless (is-buffer-file-temp)
    (setq evil-auto-indent nil)
    ;; org-mode's own flycheck will be loaded
    ;; (enable-flyspell-mode-conditionally)

    ;; No auto spell check during Emacs startup
    ;; please comment out `(flyspell-mode -1)` if you prefer auto spell check
    ;; (flyspell-mode -1)

    ;; for some reason, org8 disable odt export by default
    (add-to-list 'org-export-backends 'odt)
    ;; (add-to-list 'org-export-backends 'org) ; for org-mime

    ;; org-mime setup, run this command in org-file, than yank in `message-mode'
    (local-set-key (kbd "C-c M-o") 'org-mime-org-buffer-htmlize)

    ;; don't spell check double words
    (setq flyspell-check-doublon nil)

    ;; create updated table of contents of org file
    ;; @see https://github.com/snosov1/toc-org
    (toc-org-enable)

    ;; display wrapped lines instead of truncated lines
    (setq truncate-lines nil)
    (setq word-wrap t))

    ;; Org mode configs for human
    (global-set-key (kbd "C-c l") 'org-store-link)
    (global-set-key (kbd "C-c a") 'org-agenda)
    (when (fboundp 'org-iswitchb)
	(global-set-key (kbd "C-c b") 'org-iswitchb))
    (when (fboundp 'org-switchb)
	(global-set-key (kbd "C-c b") 'org-switchb))
    (global-set-key (kbd "C-c c") 'org-capture)
    ;; subtree editing
    (global-set-key (kbd "C-c i") 'org-insert-heading)
    (global-set-key (kbd "C-c d") 'org-do-demote)
    (global-set-key (kbd "C-c u") 'org-do-promote)
    (setq org-imenu-depth 9)
    ;; @see http://irreal.org/blog/1
    (setq org-src-fontify-natively t)
    ;; Org mode default directory and files
    (setq org-directory (expand-file-name "~/Dropbox/org_notes"))
	;; Set default notes capture path
    (setq org-default-notes-file (concat org-directory "/inbox.org"))
    ;; set default org-agenda-files location
    (setq org-agenda-files (list "~/Dropbox/org_notes/work.org"
				 "~/Dropbox/org_notes/inbox.org"
				 "~/Dropbox/org_notes/notes.org"))

    (setq org-capture-templates '(("t" "Todo [inbox]" entry
				(file+headline "~/Dropbox/org_notes/inbox.org" "Tasks")
				"* TODO %i%?")
				("n" "Note [notes]" entry
				(file+datetree "~/Dropbox/org_notes/notes.org")
				"* NOTE %i%?")
				("d" "Daily review [review]" plain
				(file+datetree "~/Dropbox/daily_review.org")
				"%K - %a\n%i\n%?\n"
				:unnarrowed t)
				("w" "Weekly review [review]" plain
				(file+datetree "~/Dropbox/weekly_review.org")
				"%K - %a\n%i\n%?\n"
				:unnarrowed t)
				  ))
  )

(defadvice org-open-at-point (around org-open-at-point-choose-browser activate)
  "`C-u M-x org-open-at-point` open link with `browse-url-generic-program'"
  (let* ((browse-url-browser-function
          (cond
           ;; open with `browse-url-generic-program'
           ((equal (ad-get-arg 0) '(4)) 'browse-url-generic)
           ;; open with w3m
           (t 'w3m-browse-url))))
    ad-do-it))

(defadvice org-publish (around org-publish-advice activate)
  "Stop running `major-mode' hook when org-publish."
  (let* ((load-user-customized-major-mode-hook nil))
    ad-do-it))

;; {{ @see http://orgmode.org/worg/org-contrib/org-mime.html
(defun org-mime-html-hook-setup ()
  (org-mime-change-element-style "pre"
                                 "color:#E6E1DC; background-color:#232323; padding:0.5em;")
  (org-mime-change-element-style "blockquote"
                                 "border-left: 2px solid gray; padding-left: 4px;"))

(eval-after-load 'org-mime
  '(progn
     (setq org-mime-export-options '(:section-numbers nil :with-author nil :with-toc nil))
     (add-hook 'org-mime-html-hook 'org-mime-html-hook-setup)))

(defun org-agenda-show-agenda-and-todo (&optional arg)
  "Better org-mode agenda view."
  (interactive "P")
  (org-agenda arg "n"))

(provide 'init-org)
