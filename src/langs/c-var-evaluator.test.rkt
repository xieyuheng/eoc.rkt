#lang racket

(require "../deps.rkt")
(require "c-var-evaluator.rkt")

(define evaluator (new c-var-evaluator-class))

(assert-equal?
 (send evaluator evaluate-program
       (parse-c-program
        '(c-program
          ()
          ((start
            (return 1))))))
 1)


(assert-equal?
 (send evaluator evaluate-program
       (parse-c-program
        '(c-program
          ()
          ((start
            (assign x 1)
            (return x))))))
 1)

(assert-equal?
 (send evaluator evaluate-program
       (parse-c-program
        '(c-program
          ()
          ((start
            (return (+ 1 2)))))))
 3)

(assert-equal?
 (send evaluator evaluate-program
       (parse-c-program
        '(c-program
          ()
          ((start
            (assign x (+ 1 2))
            (return x))))))
 3)
