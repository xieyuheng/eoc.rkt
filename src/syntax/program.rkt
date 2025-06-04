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
