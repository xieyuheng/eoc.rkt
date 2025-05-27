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
