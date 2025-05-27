#lang racket

(require "deps.rkt")
(require "lang-int.rkt")

(assert-equal?
 (interpret-lang-int
  (Program (list) (Int 1)))
 1)

(assert-equal?
 (interpret-lang-int
  (Program (list) (Prim '- (list (Int 8)))))
 -8)

(assert-equal?
 (interpret-lang-int
  (Program (list) (Prim '- (list (Int 8) (Int 4)))))
 4)
