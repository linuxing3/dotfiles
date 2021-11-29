; Erase all reminders and rebuilt reminders for today from the agenda
(defun linuxing3/org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

; Rebuild the reminders everytime the agenda is displayed
(add-hook 'org-finalize-agenda-hook 'linuxing3/org-agenda-to-appt 'append)

; This is at the end of .emacs - so appointments are set up when Emacs starts
(linuxing3/org-agenda-to-appt)

; Activate appointments so we get notifications
(appt-activate t)

; If we leave Emacs running overnight - reset the appointments one minute after midnight
(run-at-time "24:01" nil 'linuxing3/org-agenda-to-appt)

(provide 'org+reminder)
