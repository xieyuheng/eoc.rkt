#lang racket

(require "../deps.rkt")
(require "var-evaluator.rkt")

(define evaluator (new var-evaluator-class))

(assert-equal?
 (send evaluator evaluate-program
       (parse-program '(program () 1)))
 1)

(assert-equal?
 (send evaluator evaluate-program
       (parse-program '(program () (- 8))))
 -8)

(assert-equal?
 (send evaluator evaluate-program
       (parse-program '(program () (- 8 4))))
 4)

(assert-equal?
 (send evaluator evaluate-program
       (parse-program '(program () (let ([x 4]) (- 8 x)))))
 4)

;; (assert-equal?
;;  (send evaluator evaluate-program
;;        (parse-program '(program ([x 4]) (- 8 x))))
;;  4)
