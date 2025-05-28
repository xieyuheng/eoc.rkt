#lang racket

(require "../deps.rkt")

(define (freshen name)
  (gensym (string-append (symbol->string name) ".")))

(define ((uniquify-exp env) exp)
  (match exp
    [(Var name) (dict-ref env name)]
    [(Int n) (Int n)]
    [(Let name rhs body)
     (define fresh-name (freshen name))
     (define new-env (dict-set env name (freshen name)))
     (Let fresh-name
          ((uniquify-exp new-env) rhs)
          ((uniquify-exp new-env) body))]
    [(Prim op args)
     (Prim op (map (uniquify-exp env) args))]))

(provide uniquify)

(define (uniquify program)
  (match program
    [(Program info body)
     (Program info ((uniquify-exp (list)) body))]))
