#lang racket

(require "../deps.rkt")
(require "int-1-evaluator.rkt")

(assert-equal?
 (evaluate-program
  (parse-program '(program () 1)))
 1)

(assert-equal?
 (evaluate-program
  (parse-program '(program () (- 8))))
 -8)

(assert-equal?
 (evaluate-program
  (parse-program '(program () (- 8 4))))
 4)

(assert-equal?
 (pe-program
  (parse-program '(program () (- 8 4))))
 (parse-program '(program () 4)))

(assert-equal?
 (pe-program
  (parse-program '(program () (- 8 (read)))))
 (parse-program '(program () (- 8 (read)))))

(assert-equal?
 (evaluate-program
  (pe-program
   (parse-program '(program () (- 8 4)))))
 4)

(define (test-pe program)
  (assert-equal?
   (evaluate-program program)
   (evaluate-program (pe-program program))))

(test-pe (parse-program '(program () (+ 10 (- (+ 5 3))))))
(test-pe (parse-program '(program () (+ 1 (+ 3 1)))))
(test-pe (parse-program '(program () (- (+ 3 (- 5))))))
