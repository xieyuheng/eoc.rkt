#lang racket

(require "AST.rkt")

(display
 (list (Int 1)
       (Int? (Int 1))
       (Int-value (Int 1))))
