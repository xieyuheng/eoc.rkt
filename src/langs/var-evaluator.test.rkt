#lang racket

(require "../deps.rkt")
(require "var-evaluator.rkt")
(require "var-checker.rkt")


(define (test-program program-sexp value)
  (define evaluator (new var-evaluator-class))
  (define checker (new var-checker-class))
  (define program (parse-program program-sexp))
  (define checked-program (send checker type-check-program program))
  (define result (send evaluator evaluate-program checked-program))
  (assert-equal? result value))

(test-program
 '(program () 1)
 1)

(test-program
 '(program () (- 8))
 -8)

(test-program
 '(program () (- 8 4))
 4)

(test-program
 '(program () (let ((x 4)) (- 8 x)))
 4)
