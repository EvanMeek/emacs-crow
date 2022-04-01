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
    (add-to-list 'cmd content t)
    (mapconcat #'identity cmd " ")))

(defun crow--gen-translated-text (content)
  (progn (set-buffer (get-buffer-create crow-data-buffer-name))
         (erase-buffer))
  (let (raw-data translated-text)
    (set-process-sentinel
     (start-process-shell-command "crow-gen-word" crow-data-buffer-name (crow--gen-cmd content))
     (lambda (p e)
       (let* ((json (json-parse-string (progn (set-buffer crow-data-buffer-name)
                                              (buffer-string))
                                       :object-type 'alist)))
         (progn (set-buffer (get-buffer-create crow-data-buffer-name))
                (erase-buffer))
         (setq jdata json)
         (setq crow--translated-text (crow--extract-json-to-translate-text json))
         (crow--show-translated-text-by-posframe))))))

(defun crow--tap ()
  (crow--gen-translated-text (thing-at-point 'word)))

(defun crow--extract-json-to-translate-text (json)
  (let (text
        (examples (cdr (assoc 'examples json)))
        (source (cdr (assoc 'source json)))
        (translit (cdr (assoc 'sourceTranslit json)))
        (translation (cdr (assoc 'translation json)))
        (options (cdr (assoc 'translationOptions json))))
    (let* (example-text options-text
                        (source-text (s-concat "源文: " source))
                        (translit-text (s-concat "音译: " translit))
                        (translation-text (s-concat "译文: " translation)))
      ;; set exmaples text
      (map-keys-apply
       (lambda (k)
         (let* ((v (aref (cdr (assoc k examples)) 0))
                (desc (s-trim (cdr (assoc 'description v))))
                (example (s-trim (cdr (assoc 'example v)))))
           (setq example-text (s-concat example-text (symbol-name k) "\n"
                                        "描述: " desc "\n"
                                        "例子: " example "\n")))) examples)
      (map-keys-apply
       (lambda (k)
         (let* ((opt (cdr (assoc k options))))
           (setq options-text (concat (symbol-name k) "\n"))
           (setq options-text (concat options-text
                                      (mapconcat (lambda (option)
                                                   (let (option-text
                                                         (word (cdr (assoc 'word option)))
                                                         (translations (cdr (assoc 'translations option))))
                                                     (setq trdata translations)
                                                     (setq option-text (concat word " [" (mapconcat #'identity translations ", ") "]\n"))
                                                     option-text))
                                                 opt nil)
                                      )))) options)
      (concat source-text "\t" translit-text "\n" translation-text "\n" options-text "\n" example-text))))

(provide 'crow-lib)
;;; crow-lib.el ends here
