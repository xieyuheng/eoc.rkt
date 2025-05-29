#lang racket

(require "../deps.rkt")

(define (freshen name)
  (gensym (string-append (symbol->string name) ".")))

(define ((uniquify-exp name-table) exp)
  (match exp
    [(Var name)
     (define found-name (dict-ref name-table name #f))
     (Var (or found-name name))]
    [(Int n)
     (Int n)]
    [(Let name rhs body)
     (define fresh-name (freshen name))
     (define new-name-table (dict-set name-table name fresh-name))
     (Let fresh-name
          ((uniquify-exp name-table) rhs)
          ((uniquify-exp new-name-table) body))]
    [(Prim op args)
     (Prim op (map (uniquify-exp name-table) args))]))

(provide uniquify)

(define (uniquify program)
  (match program
    [(Program info body)
     (Program info ((uniquify-exp (list)) body))]))
