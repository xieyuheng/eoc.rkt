#lang racket

(require "lang-int.rkt")
(require "AST.rkt")

(display
 (interpret-lang-int
  (Program (list) (Int 1))))

;; (list (Int 1)
;;       (Prim '- (list (Int 8)))
;;       (Int? (Int 1))
;;       (Int-value (Int 1))
;;       (fx+ 1 2)
;;       (assert (equal? (Int 1) (Int 1))))
