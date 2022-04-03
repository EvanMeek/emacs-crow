;;; crow-core.el --- The emacs crow code
;; -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Evan Meek
;;
;; Author: Evan Meek <evanmeek@evanmeek>
;; Maintainer: Evan Meek <evanmeek@evanmeek>
;; Created: 三月 29, 2022
;; Modified: 三月 29, 2022
;; Version: 0.0.1
;; Keywords: tools
;; Homepage: https://github.com/evanmeek/crow-core
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:
(defgroup crow-core nil
  "组合crow源码，以提供用户使用的命令.")

(defun crow-demo-start ()
  "startstartstartstartstartstartstartstartstartstart"
  (interactive)
  (add-hook 'post-command-hook 'crow--tap))

(defun crow-demo-stop ()
  "stopstopstopstopstopstopstopstopstopstopstopstopstop"
  (interactive)
  (remove-hook 'post-command-hook 'crow--tap))

(define-minor-mode crow-mode ()
  (interactive)
  (run-hooks crow-mode-hook)
  (message "crow-mode: %s" crow-mode)
  (cond (crow-mode (progn (add-hook 'post-command-hook 'crow--tap)
                          (message "run")))
        (t (progn (remove-hook 'post-command-hook 'crow--tap)
                  (message "stop")))))

(defun crow-next-translate-type ()
  (interactive)
  (setq crow-translate-type (-rotate -1 crow-translate-type)))
(defun crow-prev-translate-type ()
  (interactive)
  (setq crow-translate-type (-rotate 1 crow-translate-type)))

(provide 'crow-core)
;;; crow-core.el ends here
