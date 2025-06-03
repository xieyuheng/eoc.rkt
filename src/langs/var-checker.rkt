#lang racket

(require "../deps.rkt")
(require "int-evaluator.rkt")

(provide var-checker-class)

(define-class var-checker-class ()
  (define/public (operator-types)
    '((+ . ((Integer Integer) . Integer))
      (- . ((Integer Integer) . Integer))
      (read . (() . Integer))))

  (define/public (type-equal? t1 t2) (equal? t1 t2))

  (define/public (check-type-equal? t1 t2 e)
    (unless (type-equal? t1 t2)
      (error 'type-check "~a != ~a\nin ~v" t1 t2 e)))

  (define/public (type-check-op op arg-types e)
    (match (dict-ref (operator-types) op)
      [`(,param-types . ,return-type)
       (for ([at arg-types] [pt param-types])
         (check-type-equal? at pt e))
       return-type]))

  (define/public (type-check-exp env)
    (lambda (e)
      (match e
        [(Var x)  (values (Var x) (dict-ref env x))]
        [(Int n)  (values (Int n) 'Integer)]
        [(Prim op es)
         (define-values (new-es ts)
           (for/lists (exprs types) ([e es]) ((type-check-exp env) e)))
         (values (Prim op new-es) (type-check-op op ts e))]
        [(Let x e body)
         (define-values (e^ Te) ((type-check-exp env) e))
         (define-values (b Tb) ((type-check-exp (dict-set env x Te)) body))
         (values (Let x e^ b) Tb)])))

  (define/public (type-check-program e)
    (match e
      [(Program info body)
       (define-values (body^ Tb) ((type-check-exp '()) body))
       (check-type-equal? Tb 'Integer body)
       (Program info body^)])))
