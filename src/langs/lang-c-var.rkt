#lang racket

(require "../deps.rkt")
(require "lang-var.rkt")

(provide lang-c-var-mixin)

(define (lang-c-var-mixin super-class)
  (class super-class
    (super-new)

    (inherit evaluate-exp)

    (note evaluate-stmt (-> env-t stmt-t env-t))
    (define/public ((evaluate-stmt env) stmt)
      (match stmt
        [(Assign (Var name) rhs)
         (dict-set env name ((evaluate-exp env) rhs))]))

    (note evaluate-tail (-> env-t stmt-t value-t))
    (define/public ((evaluate-tail env) tail)
      (match tail
        [(Return exp)
         ((evaluate-exp env) exp)]
        [(Seq stmt next-tail)
         (define new-env ((evaluate-stmt env) stmt))
         ((evaluate-tail new-env) next-tail)]))

    (note interp-c-program (-> program-t value-t))
    (define/override (interp-program program)
      (match program
        [(CProgram _ `((start . ,tail)))
         ((evaluate-tail '()) tail)]))))

(provide lang-c-var-class)

(define lang-c-var-class (lang-c-var-mixin lang-var-class))
