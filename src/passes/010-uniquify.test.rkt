#lang racket

(require "../deps.rkt")
(require "../langs/var-evaluator.rkt")
(require "010-uniquify.rkt")

(define (test-program program-sexp value)
  (let* ((evaluator (new var-evaluator-class))
         (program (parse-program program-sexp))
         (program (uniquify program))
         (result (send evaluator evaluate-program program)))
    (assert-equal? result value)))

(test-program
 '(program () (let ((x 4)) (- 8 x)))
 4)

(test-program
 '(program () (let ((x 32)) (+ (let ((x 10)) x) x)))
 42)

(test-program
 '(program () (let ((x (let ((x 4)) (+ x 1)))) (+ x 2)))
 7)
