(defun lazygit-quit ()
  "Quit LazyGit: close the terminal window and kill it's buffer"
  (interactive)
  (let ((buf (current-buffer)))
    (quit-window t buf)
    (kill-buffer buf)))

(defun lazygit ()
  "Launch LazyGit"
  (interactive)
  (unless (executable-find "lazygit")
    (error "LazyGit executable not found"))
  (let* ((proj (if (and (fboundp 'projectile-project-root)
                        (projectile-project-root))
                   (projectile-project-root)
                 default-directory))
         (default-directory proj)
         (buf (term "lazygit")))
    (with-current-buffer buf
      (rename-buffer "*lazygit*")
      (term-char-mode)
      (local-set-key (kbd "q") 'lazygit-quit))
    (pop-to-buffer buf)))

(map! :leader
      :desc "Open LazyGit"
      "gg" #'lazygit)
