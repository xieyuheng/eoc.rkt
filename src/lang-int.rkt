#lang racket

(require "deps.rkt")
(require "AST.rkt")

(define (interpret-exp exp)
  (match exp
    [(Int n) n]))

(define (interpret-lang-int program)
  (match program
    [(Program (list) exp) (interpret-exp exp)]))

(display
 (interpret-lang-int
  (Program (list) (Int 1))))

;; (list (Int 1)
;;       (Prim '- (list (Int 8)))
;;       (Int? (Int 1))
;;       (Int-value (Int 1))
;;       (fx+ 1 2)
;;       (assert (equal? (Int 1) (Int 1))))
