;;; crow-ui.el --- The ui code for crow -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Evan Meek
;;
;; Author: Evan Meek <evanmeek@evanmeek>
;; Maintainer: Evan Meek <evanmeek@evanmeek>
;; Created: 四月 01, 2022
;; Modified: 四月 01, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/evanmeek/crow-ui
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  The ui code for crow
;;
;;; Code:

(defun crow--show-translated-text-by-posframe()
  (when (posframe-workable-p)
    (posframe-show "*crow-posframe*"
               :string crow--translated-text
               :poshandler 'posframe-poshandler-point-bottom-left-corner-upward
               :timeout 200
               :internal-border-width 10)
    (unwind-protect
        (push (read-event) unread-command-events)
      (posframe-hide "*crow-posframe*"))))

(provide 'crow-ui)
;;; crow-ui.el ends here
