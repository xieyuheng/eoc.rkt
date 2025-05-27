#lang racket

(require "deps.rkt")
(require "lang-var.rkt")

(define lang-var (new lang-var-class))

;; (assert-equal?
;;  (send lang-int interpret-program
;;        (parse-program '(program () 1)))
;;  1)

;; (assert-equal?
;;  (send lang-int interpret-program
;;        (parse-program '(program () (- 8))))
;;  -8)

;; (assert-equal?
;;  (send lang-int interpret-program
;;        (parse-program '(program () (- 8 4))))
;;  4)
