#lang racket

(require "../deps.rkt")
(require "var-evaluator.rkt")
(require "var-checker.rkt")

(define (test-program program-sexp value)
  (let* ((evaluator (new var-evaluator-class))
         (checker (new var-checker-class))
         (program (parse-program program-sexp))
         (program (send checker type-check-program program))
         (result (send evaluator evaluate-program program)))
    (assert-equal? result value)))

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
