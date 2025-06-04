#lang racket

(require "deps.rkt")
(require "program.rkt")

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

(provide format-c-program)

(note format-c-program (-> c-program-t sexp-t))
(define (format-c-program c-program)
  (match c-program
    [(CProgram info tails)
     `(c-program info ,(alist-map-value tails format-tail))]))

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
