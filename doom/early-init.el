;; Set PATH from Fish shell
(let ((path (shell-command-to-string "fish -c 'echo $PATH'")))
  (setenv "PATH" path)
  (setq exec-path (append (split-string path ":") exec-path)))
