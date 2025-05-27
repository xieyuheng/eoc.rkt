#lang racket

(require "deps.rkt")
(require "lang-int.rkt")

(define lang-int (new lang-int-class))

(assert-equal?
 (send lang-int interpret-program
       (parse-program '(program () 1)))
 1)

(assert-equal?
 (send lang-int interpret-program
       (parse-program '(program () (- 8))))
 -8)

(assert-equal?
 (send lang-int interpret-program
       (parse-program '(program () (- 8 4))))
 4)
