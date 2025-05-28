#lang racket

(require "../deps.rkt")
(require "lang-int.rkt")

(define lang (new lang-int-class))

(assert-equal?
 (send lang interpret-program
       (parse-program '(program () 1)))
 1)

(assert-equal?
 (send lang interpret-program
       (parse-program '(program () (- 8))))
 -8)

(assert-equal?
 (send lang interpret-program
       (parse-program '(program () (- 8 4))))
 4)
