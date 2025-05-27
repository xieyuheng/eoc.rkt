#lang racket

(require "deps.rkt")
(require "ast.rkt")

(provide parse-program)

(define (parse-program sexp)
  (match sexp
    [`(program () ,body)
     (Program (list) (parse-exp body))]))

(define (parse-exp sexp)
  (match sexp
    [`(let ([,name ,rhs]) ,body)
     (Let name (parse-exp rhs) (parse-exp body))]
    [(cons op args)
     (Prim op (map parse-exp args))]
    [x
     (cond [(fixnum? x) (Int x)]
           [(symbol? x) (Var x)]
           [else (error 'parse-exp "expected an integer" x)])]))
