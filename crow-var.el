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

(defvar crow--translated-text nil
  "内部变量|翻译好的文本")
(defvar crow--translate-status nil
  "内部变量|子进程的翻译状态")
(defvar crow--last-content nil
  "内部变量|上一个获取的源数据")
(defvar crow--current-content nil
  "内部变量|当前已获取的源数据")
(defvar crow-mode-hook nil
  "TODO: 补全crow-mode-hook注释")
(defvar crow-data-buffer-name "*CROW-DATA*"
  "此变量控制着CROW与外部交互翻译元数据的Buffer名，不建议修改.")
(defvar crow-translate-delay 0.2
  "此变量控制每次翻译的间隔延迟.")
(defvar crow-posframe-hide-timeout 10
  "此变量控制posframe自动隐藏的时间.")
(defvar crow-posframe-position nil
  "此变量控制posframe显示的位置，可用值可以参造posframe-show的文档, 或者你自己写一个poshandler函数.
例子: (setq crow-posframe-position 'posframe-poshandler-frame-center).")
(defvar crow-translate-type (list 'sentence 'word)
  "此变量控制获取原文颗粒度的类型,默认使用第一个，是一个list可选项有sentence(句子)，word(单词)，line(单行)，page(单页).
参数基本就是thing-at-point的THING可选值，不过就上面的几个是比较推荐使用的.
例子: (setq crow-translate-type (list 'sentence 'word 'line))")
(defvar crow-enable-info '(:examples t
                           :source t
                           :translit t
                           :translation t
                           :options t)
  "Crow 开启的翻译信息.
是一个plist，可选keyword有exmaples(例句), source(原文),
translit(音译), translation(译文), options(其他), 将需要开启的信息对应值设置为非nil即可。
例如:
'(:exmaples t
   :source t
   :translit t
   :translation t
   :options t)")

(provide 'crow-var)
;;; crow-var.el ends here
