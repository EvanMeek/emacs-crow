;;; crow-posframe.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Evan Meek
;;
;; Author: Evan Meek <evanmeek@evanmeek>
;; Maintainer: Evan Meek <evanmeek@evanmeek>
;; Created: 四月 02, 2022
;; Modified: 四月 02, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/evanmeek/crow-posframe
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(require 'posframe)


(defun crow--posframe-hidehandler (_)
  (not crow--current-content))

(defun crow--show-translated-text-by-posframe()
  (when (posframe-workable-p)
    (setq crow--translate-status nil)
    (posframe-show "*crow-posframe*"
                   :string crow--translated-text
                   :poshandler crow-posframe-position
                   :internal-border-width 2
                   :timeout crow-posframe-hide-timeout
                   :hidehandler #'crow--posframe-hidehandler)))

(provide 'crow-posframe)
;;; crow-posframe.el ends here
