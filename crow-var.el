;;; crow-var.el --- Emacs Crow variable -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Evan Meek
;;
;; Author: Evan Meek <evanmeek@evanmeek>
;; Maintainer: Evan Meek <evanmeek@evanmeek>
;; Created: 三月 29, 2022
;; Modified: 三月 29, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/evanmeek/crow-var
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Emacs Crow variable
;;
;;; Code:
(defcustom crow-translate-engine nil
  "指定翻译引擎，如果为nil，则默认使用google.
可选项有: (google, yandex, bing, libretranslation, lingva)"
  :type 'string
  :group 'crow-core)
(defcustom crow-target-language "zh-CN"
  "指定目标语言，可使用+分割多个不同的语言(默认使用系统语言)."
  :type 'string
  :group 'crow-core)

(defcustom crow-speaker-target-p nil
  "是否需要朗读翻译结果."
  :type 'boolean
  :group 'crow-core)

(defcustom crow-speaker-source-p nil
  "是否需要朗读源文."
  :type 'boolean
  :group 'crow-core)


(defvar crow-data-buffer-name "*CROW-DATA*"
  "Crow 数据缓冲区名")

(defvar crow--translated-text nil
  "Crow 翻译好的文本")

(provide 'crow-var)
;;; crow-var.el ends here
