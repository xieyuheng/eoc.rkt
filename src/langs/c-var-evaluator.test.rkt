#lang racket

(require "../deps.rkt")
(require "c-var-evaluator.rkt")

(define (test-c-program c-program-sexp value)
  (define evaluator (new c-var-evaluator-class))
  (define c-program (parse-c-program c-program-sexp))
  (define result (send evaluator evaluate-program c-program))
  (assert-equal? result value))

(test-c-program
 '(c-program
   ()
   ((start
     (return 1))))
 1)


(test-c-program
 '(c-program
   ()
   ((start
     (assign x 1)
     (return x))))
 1)

(test-c-program
 '(c-program
   ()
   ((start
     (return (+ 1 2)))))
 3)

(test-c-program
 '(c-program
   ()
   ((start
     (assign x (+ 1 2))
     (return x))))
 3)
