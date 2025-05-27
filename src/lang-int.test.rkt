#lang racket

(require "deps.rkt")
(require "lang-int.rkt")

(assert-equal?
 (interpret-lang-int
  (parse-program '(program () 1)))
 1)

(assert-equal?
 (interpret-lang-int
  (parse-program '(program () (- 8))))
 -8)

(assert-equal?
 (interpret-lang-int
  (parse-program '(program () (- 8 4))))
 4)

(assert-equal?
 (pe-lang-int
  (parse-program '(program () (- 8 4))))
 (parse-program '(program () 4)))

(assert-equal?
 (pe-lang-int
  (parse-program '(program () (- 8 (read)))))
 (parse-program '(program () (- 8 (read)))))

(assert-equal?
 (interpret-lang-int
  (pe-lang-int
   (parse-program '(program () (- 8 4)))))
 4)
