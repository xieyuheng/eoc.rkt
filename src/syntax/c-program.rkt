#lang racket

(require "deps.rkt")

(provide (struct-out Assign)
         (struct-out Return)
         (struct-out Seq)
         (struct-out CProgram))

;; <atm> ::= (Int <int>)
;;         | (Var <var>)
;; <exp> ::= <atm>
;;         | (Prim 'read ())
;;         | (Prim '- (<atm>))
;;         | (Prim '+ (<atm> <atm>))
;;         | (Prim '- (<atm> <atm>))
;; <stmt> ::= (Assign (Var <var>) <exp>)
;; <tail> ::= (Return <exp>)
;;          | (Seq <stmt> <tail>)
;; <CVar> ::= (CProgram <info> ((<label> . <tail>) … ))

(define-data Assign [var rhs])
(define-data Return [exp])
(define-data Seq [stmt tail])
(define-data CProgram [info tails])
