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
    [(cons op args) (Prim op (map parse-exp args))]
    [n
     (cond [(fixnum? n) (Int n)]
           [else (error 'parse-exp "expected an integer" n)])]))
