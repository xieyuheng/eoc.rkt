#lang racket

(require "../deps.rkt")
(require "lang-var.rkt")

(provide lang-c-var-mixin)

(define (lang-c-var-mixin super-class)
  (class super-class
    (super-new)

    (inherit interpret-exp)

    (note interpret-stmt (-> env-t stmt-t env-t))
    (define/public ((interpret-stmt env) stmt)
      (match stmt
        [(Assign (Var name) rhs)
         (dict-set env name ((interpret-exp env) rhs))]))

    (note interpret-tail (-> env-t stmt-t value-t))
    (define/public ((interpret-tail env) tail)
      (match tail
        [(Return exp)
         ((interpret-exp env) exp)]
        [(Seq stmt next-tail)
         (define new-env ((interpret-stmt env) stmt))
         ((interpret-tail new-env) next-tail)]))

    (note interp-c-program (-> program-t value-t))
    (define/override (interp-program program)
      (match program
        [(CProgram _ `((start . ,tail)))
         ((interpret-tail '()) tail)]))))

(provide lang-c-var-class)

(define lang-c-var-class (lang-c-var-mixin lang-var-class))
