#lang racket

(require "../deps.rkt")
(require "../langs/var-evaluator.rkt")
(require "010-uniquify.rkt")

(define lang (new var-evaluator-class))

(assert-equal?
 (send lang evaluate-program
       (uniquify
        (parse-program
         '(program () (let ((x 4)) (- 8 x))))))
 4)


(assert-equal?
 (send lang evaluate-program
       (uniquify
        (parse-program
         '(program () (let ((x 32)) (+ (let ((x 10)) x) x))))))
 42)

(assert-equal?
 (send lang evaluate-program
       (uniquify
        (parse-program
         '(program () (let ((x (let ((x 4)) (+ x 1)))) (+ x 2))))))
 7)
