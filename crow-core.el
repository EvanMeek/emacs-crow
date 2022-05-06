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
(define-minor-mode crow-mode
  "crow mode"
  :lighter "Crow"
  ;; (run-hooks crow-mode-hooks)
  (if (crow--check-crow-bin-path)
      (cond (crow-mode (add-hook 'post-command-hook 'crow--tap nil t))
            (t (remove-hook 'post-command-hook 'crow--tap t)))
    (message "无法找到crow二进制程序")))

(defun crow-next-translate-type ()
  "切换到下一种翻译单位."
  (interactive)
  (setq crow-translate-type (-rotate -1 crow-translate-type))
  (message "> CROW 已切换至 %s 模式" (car crow-translate-type)))

(defun crow-prev-translate-type ()
  "切换到上一种翻译单位."
  (interactive)
  (setq crow-translate-type (-rotate 1 crow-translate-type))
  (message "> CROW 已切换至 %s 模式" (car crow-translate-type)))

(defun crow-next-ui-type ()
  (interactive)
  "切换到下一种翻译UI."
  (setq crow-ui-type (-rotate -1 crow-ui-type))
  (message "> CROW 已切换显示方式为 %s" (car crow-ui-type)))

(defun crow-prev-ui-type ()
  "切换到下一种翻译UI."
  (interactive)
  (setq crow-ui-type (-rotate 1 crow-ui-type)
  (message "> CROW 已切换显示方式为 %s" (car crow-ui-type)))

(provide 'crow-core)
;;; crow-core.el ends here
