#lang racket

(require "../deps.rkt")

(note explicate-tail (-> exp-t tail-t))
(define (explicate-tail exp)
  (match exp
    [(Var name)
     (Return (Var name))]
    [(Int n)
     (Return (Int n))]
    [(Let name rhs body)
     (explicate-assign name rhs (explicate-tail body))]
    [(Prim op args)
     ;; assume args are atoms.
     (Prim op args)]))

(note explicate-assign (-> name-t exp-t tail-t tail-t))
(define (explicate-assign name rhs tail)
  (match rhs
    [(Var name2)
     (Seq (Assign (Var name) (Var name2)) tail)]
    [(Int n)
     (Seq (Assign (Var name) (Int n)) tail)]
    [(Let name2 rhs2 body)
     (explicate-assign name2 rhs2 (Seq (Assign (Var name) body) tail))]
    [(Prim op args)
     (Seq (Assign (Var name) (Prim op args)) tail)]))

(provide explicate-control)

(note explicate-control (-> program-t c-program-t))
(define (explicate-control program)
  (match program
    [(Program info body)
     (CProgram info (explicate-tail body))]))
