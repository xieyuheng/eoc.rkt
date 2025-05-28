#lang racket

(require "deps.rkt")

(provide (struct-out Int)
         (struct-out Prim)
         (struct-out Var)
         (struct-out Let)
         (struct-out Program))

(define-data Int [value])
(define-data Prim [op args])
(define-data Var [name])
(define-data Let [name rhs body])
(define-data Program [info body])

(provide (struct-out Assign)
         (struct-out Return)
         (struct-out Seq)
         (struct-out CProgram))

(define-data Assign [lhs rhs])
(define-data Return [exp])
(define-data Seq [stmt tail])
(define-data CProgram [info tails])
