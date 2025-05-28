#lang racket

(require "../deps.rkt")
(require "lang-int-1.rkt")

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

(define (test-pe program)
  (assert-equal?
   (interpret-lang-int program)
   (interpret-lang-int (pe-lang-int program))))

(test-pe (parse-program '(program () (+ 10 (- (+ 5 3))))))
(test-pe (parse-program '(program () (+ 1 (+ 3 1)))))
(test-pe (parse-program '(program () (- (+ 3 (- 5))))))
