;;; crow-lib.el --- Emacs Crow Libray -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Evan Meek
;;
;; Author: Evan Meek <evanmeek@evanmeek>
;; Maintainer: Evan Meek <evanmeek@evanmeek>
;; Created: 三月 29, 2022
;; Modified: 三月 29, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/evanmeek/crow-lib
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Emacs Crow Libray
;;
;;; Code:

(defun crow--tap()
  (let ((word (thing-at-point (car crow-translate-type) t)))
    (setq crow--current-content word)
    (when crow--current-content
      (ignore-errors
          (crow--gen-translated-text word)   )
      )))
(defun crow--gen-cmd (content)
  (let ((cmd (list "crow -j")))
    (when crow-speaker-source-p
      (add-to-list 'cmd "-p" t))
    (when crow-speaker-target-p
      (add-to-list 'cmd "-u" t))
    (when crow-target-language
      (add-to-list 'cmd (concat "-t" " " crow-target-language) t))
    (when crow-translate-engine
      (add-to-list 'cmd (concat "-e" " " crow-translate-engine) t))
    (add-to-list 'cmd (concat "'" content "'") t)
    (mapconcat #'identity cmd " ")))

(defun crow--gen-translated-text (content)
  (progn (set-buffer (get-buffer-create crow-data-buffer-name))
         (erase-buffer))
  (set-process-sentinel
   (start-process-shell-command "crow-gen-word" crow-data-buffer-name (crow--gen-cmd content))
   (lambda (p e)
     (let* ((json (json-parse-string (progn (set-buffer crow-data-buffer-name)
                                            (buffer-string))
                                     :object-type 'alist)))
       (progn (set-buffer (get-buffer-create crow-data-buffer-name))
              (erase-buffer))
       (setq crow--translated-text (crow--extract-json-to-translate-text json))
       (crow--show-translated-text-by-posframe)))))


(defun crow--extract-json-to-translate-text (json)
  (let (text
        (examples (cdr (assoc 'examples json)))
        (source (cdr (assoc 'source json)))
        (translit (cdr (assoc 'sourceTranslit json)))
        (translation (cdr (assoc 'translation json)))
        (options (cdr (assoc 'translationOptions json))))
    (crow--parser (list :examples examples
                        :source source
                        :translit translit
                        :translation translation
                        :options options))))

(defun crow--parser (content-obj)
  "解析content元数据为格式化好的字符串."
  (let (content-text
        example-text
        source-text
        translit-text
        translation-text
        options-text)

    (when (plist-get crow-enable-info :source)
      (setq source-text (crow--parse-source (plist-get content-obj :source)))
      (setq content-text (concat content-text source-text "\t")))
    (when (plist-get content-obj :translit)
      (setq content-text (concat content-text "[" (crow--parse-translit (plist-get content-obj :translit)) "]" "")))

    (when (plist-get crow-enable-info :translation)
      (setq translation-text (crow--parse-translation (plist-get content-obj :translation)))
      (setq content-text (concat content-text "\n" translation-text "")))
    (when (plist-get crow-enable-info :examples)
      (setq example-text (crow--parse-examples (plist-get content-obj :examples)))
      (setq content-text (concat content-text "\n例句解释:"))
      (setq content-text (concat content-text example-text "")))
    (when (plist-get crow-enable-info :options)
      (setq options-text (crow--parse-options (plist-get content-obj :options)))
      (setq content-text (concat content-text "\n常用用例:"))
      (setq content-text (concat content-text options-text "")))
    content-text))

(defun crow--parse-examples (obj)
  "解析并格式化content中的examples元数据"
  (let (text)
    (map-keys-apply
     (lambda (k)
       (let* ((v (aref (cdr (assoc k obj)) 0))
              (desc (s-trim (cdr (assoc 'description v))))
              (example (s-trim (cdr (assoc 'example v)))))
         (setq text (concat text "\n" (symbol-name k) "\t" "例句: [" example "]" "\t" "解释: [" desc "]")))) obj)
    text))

(defun crow--parse-source (obj) "解析并格式化content中的source元数据" obj)
(defun crow--parse-translit (obj) "解析并格式化content中的translit元数据" obj)
(defun crow--parse-translation (obj) "解析并格式化content中的translation元数据" obj)
(defun crow--parse-options (obj)
  "解析并格式化shift中的options元数据"
  (let (text)
    (map-keys-apply
     (lambda (k)
       (let* ((opt (cdr (assoc k obj))))
         (setq text (concat "\n" (symbol-name k) "\t"))
         (setq text (concat text
                            (mapconcat (lambda (option)
                                         (let (option-text
                                               (word (cdr (assoc 'word option)))
                                               (translations (cdr (assoc 'translations option))))
                                           (setq trdata translations)
                                           (setq option-text (concat word " [" (mapconcat #'identity translations ", ") "]  "))
                                           option-text))
                                       opt nil))))) obj)
    text))
(provide 'crow-lib)
;;; crow-lib.el ends here
