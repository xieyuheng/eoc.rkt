#lang racket

(require "deps.rkt")

(provide (struct-out Int)
         (struct-out Prim)
         (struct-out Var)
         (struct-out Let)
         (struct-out Program))

;; <type> ::= Integer
;; <exp> ::= (Int <int>)
;;         | (Prim 'read ())
;;         | (Prim '- (<exp>))
;;         | (Prim '+ (<exp> <exp>))
;;         | (Prim '- (<exp> <exp>))
;; ------
;; <exp> ::= (Var <var>)
;;        | (Let <var> <exp> <exp>)
;; <LVar> ::= (Program ’() <exp>)

(define-data Int [value])
(define-data Prim [op args])
(define-data Var [name])
(define-data Let [name rhs body])
(define-data Program [info body])
