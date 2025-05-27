#lang racket

(require "deps.rkt")
(require "AST.rkt")

(display
 (list (Int 1)
       (Prim '- (list (Int 8)))
       (Int? (Int 1))
       (Int-value (Int 1))
       (fx+ 1 2)
       (assert (equal? (Int 1) (Int 1)))))
