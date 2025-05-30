#lang racket

(require "deps.rkt")
(require "ast.rkt")

(provide format-program)

(note format-program (-> program-t sexp-t))
(define (format-program program)
  (match program
    [(Program (list) body)
     `(program () ,(format-exp body))]))

(provide format-exp)

(note format-exp (-> exp-t sexp-t))
(define (format-exp exp)
  (match exp
    [(Var name) name]
    [(Int n) n]
    [(Let name rhs body)
     `(let ([,name ,(format-exp rhs)])
        ,(format-exp body))]
    [(Prim op args)
     (cons op (map format-exp args))]))

(provide format-c-program)

(note format-c-program (-> c-program-t sexp-t))
(define (format-c-program c-program)
  (match c-program
    [(CProgram (list) tail)
     `(c-program () ,(format-tail tail))]))

(define (format-tail tail)
  (match tail
    [(Return exp)
     `((return ,(format-exp exp)))]
    [(Seq stmt next-tail)
     (cons (format-stmt stmt)
           (format-tail next-tail))]))

(define (format-stmt stmt)
  (match stmt
    [(Assign (Var name) rhs)
     `(assign ,name ,(format-exp rhs))]))
