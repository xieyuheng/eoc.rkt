#lang racket

(require "../deps.rkt")
(require "../langs/var-evaluator.rkt")
(require "010-uniquify.rkt")
(require "020-remove-complex-operands.rkt")

(define (test-program program-sexp value)
  (let* ((program0 (parse-program program-sexp))
         (program1 (uniquify program0))
         (program2 (rco-program program1))
         (evaluator (new var-evaluator-class))
         (result (send evaluator evaluate-program program2)))
    (displayln (~a "000 " (format-program program0)))
    (displayln (~a "010 " (format-program program1)))
    (displayln (~a "020 " (format-program program2)))
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
