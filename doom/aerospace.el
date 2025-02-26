;;; emacs-aerospace.el --- Integrate Emacs with Aerospace window manager -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025
;;
;; Author: Your Name <your.email@example.com>
;; Maintainer: Your Name <your.email@example.com>
;; Created: February 26, 2025
;; Modified: February 26, 2025
;; Version: 0.1.0
;; Keywords: tools
;; Homepage: https://github.com/yourusername/emacs-aerospace
;; Package-Requires: ((emacs "26.1") (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  This package provides integration between Emacs and the Aerospace window manager
;;  for macOS. It allows seamless navigation between Emacs windows and Aerospace-managed
;;  windows using the same keybindings.
;;
;;; Code:

(require 'cl-lib)

(defgroup emacs-aerospace nil
  "Integration between Emacs and Aerospace window manager for macOS."
  :group 'tools
  :prefix "emacs-aerospace-")

(defcustom emacs-aerospace-default-keymap-prefix "C-w"
  "Default keymap prefix for emacs-aerospace commands."
  :type 'string
  :group 'emacs-aerospace)

(defcustom emacs-aerospace-applescript-timeout 0.5
  "Timeout in seconds for AppleScript execution."
  :type 'number
  :group 'emacs-aerospace)

(defvar emacs-aerospace--direction-map
  '(("h" . "west")
    ("j" . "south")
    ("k" . "north")
    ("l" . "east"))
  "Mapping from vim-style direction keys to cardinal directions.")

;; Core functionality

(defun emacs-aerospace--window-exists-in-direction (direction)
  "Check if an Emacs window exists in DIRECTION from the current window."
  (let ((orig-window (selected-window))
        (result nil))
    (condition-case nil
        (progn
          (windmove-do-window-select direction nil)
          (setq result (not (eq orig-window (selected-window)))))
      (error nil))
    ;; Return to original window if we moved
    (when (and (not result) (not (eq orig-window (selected-window))))
      (select-window orig-window))
    result))

(defun emacs-aerospace--send-to-aerospace (direction)
  "Send a command to Aerospace to focus the window in the given DIRECTION."
  (let ((aerospace-dir (cdr (assoc direction emacs-aerospace--direction-map))))
    (when aerospace-dir
      (let ((script (format "
tell application \"System Events\"
  tell process \"Aerospace\"
    keystroke \"w\" using {control down}
    keystroke \"%s\"
  end tell
end tell
" aerospace-dir)))
        (with-timeout (emacs-aerospace-applescript-timeout nil)
          (call-process "osascript" nil nil nil "-e" script))))))

(defun emacs-aerospace-move-window (direction)
  "Move focus to window in DIRECTION, either within Emacs or to Aerospace if at edge."
  (interactive)
  (cond
   ;; If there's an Emacs window in that direction, move to it
   ((emacs-aerospace--window-exists-in-direction direction)
    (windmove-do-window-select direction nil))
   ;; Otherwise, delegate to Aerospace
   (t (emacs-aerospace--send-to-aerospace direction))))

;; Define interactive commands for each direction
(defun emacs-aerospace-move-left ()
  "Move to the window to the left, either in Emacs or Aerospace."
  (interactive)
  (emacs-aerospace-move-window "left"))

(defun emacs-aerospace-move-right ()
  "Move to the window to the right, either in Emacs or Aerospace."
  (interactive)
  (emacs-aerospace-move-window "right"))

(defun emacs-aerospace-move-up ()
  "Move to the window above, either in Emacs or Aerospace."
  (interactive)
  (emacs-aerospace-move-window "up"))

(defun emacs-aerospace-move-down ()
  "Move to the window below, either in Emacs or Aerospace."
  (interactive)
  (emacs-aerospace-move-window "down"))

;;;###autoload
(defun emacs-aerospace-setup ()
  "Set up keybindings for Emacs-Aerospace integration."
  (interactive)
  ;; For regular Emacs
  (global-set-key (kbd "C-w h") #'emacs-aerospace-move-left)
  (global-set-key (kbd "C-w j") #'emacs-aerospace-move-down)
  (global-set-key (kbd "C-w k") #'emacs-aerospace-move-up)
  (global-set-key (kbd "C-w l") #'emacs-aerospace-move-right)

  ;; For Doom Emacs specifically
  (when (and (boundp 'doom-version) doom-version)
    (map! :map global-map
          :leader
          (:prefix "w"
                   "h" #'emacs-aerospace-move-left
                   "j" #'emacs-aerospace-move-down
                   "k" #'emacs-aerospace-move-up
                   "l" #'emacs-aerospace-move-right)))

  (message "Emacs-Aerospace integration enabled."))

(provide 'emacs-aerospace)
