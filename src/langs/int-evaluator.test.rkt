#lang racket

(require "../deps.rkt")
(require "int-evaluator.rkt")

(define evaluator (new int-evaluator-class))

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
