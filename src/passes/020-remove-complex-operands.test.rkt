#lang racket

(require "../deps.rkt")
(require "../langs/var-evaluator.rkt")
(require "010-uniquify.rkt")
(require "020-remove-complex-operands.rkt")

(define (test-program program-sexp value)
  (let* ((evaluator (new var-evaluator-class))
         (program (parse-program program-sexp))
         (program (uniquify program))
         (program (rco-program program))
         (result (send evaluator evaluate-program program)))
    (write program-sexp) (newline)
    (write (format-program program)) (newline)
    (assert-equal? result value)))

(test-program
 '(program
   ()
   (let ((x (+ 42 (- 10))))
     (+ x 10)))
 42)

(test-program
 '(program
   ()
   (+ (+ 1 2) (+ 3 (+ 4 5))))
 15)

(test-program
 '(program
   ()
   (let ((a 42))
     (let ((b a))
       b)))
 42)
