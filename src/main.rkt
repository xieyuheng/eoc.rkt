#lang racket

(require "AST.rkt")
(require rackunit)

(display
 (list (Int 1)
       (Int? (Int 1))
       (Int-value (Int 1))
       (check-equal? (Int 1) (Int 1))))
