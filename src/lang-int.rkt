#lang racket

(require "deps.rkt")
(require "AST.rkt")

(provide interpret-lang-int)

(define (interpret-exp exp)
  (match exp
    [(Int n) n]))

(define (interpret-lang-int program)
  (match program
    [(Program (list) exp) (interpret-exp exp)]))
