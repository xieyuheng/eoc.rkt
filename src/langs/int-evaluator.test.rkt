#lang racket

(require "../deps.rkt")
(require "int-evaluator.rkt")

(define (test-program program-sexp value)
  (let* ((program (parse-program program-sexp))
         (evaluator (new int-evaluator-class))
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
