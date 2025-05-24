#lang racket

(require "utils.rkt")
(require "AST.rkt")

(display
 (list (Int 1)
       (Int? (Int 1))
       (Int-value (Int 1))
       (assert (equal? (Int 1) (Int 1)))))
