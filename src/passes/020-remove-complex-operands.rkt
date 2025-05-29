#lang racket

(require "../deps.rkt")

(note rco-atom (-> exp-t (pair-t exp-t (map-t name-t exp-t))))
(define (rco-atom exp)
  (match exp
    [(Var name) (cons (Var name) '())]
    [(Int n) (cons (Int n) '())]
    [(Let name rhs body)
     (define rhs-pair (rco-atom rhs))
     (define body-pair (rco-atom body))
     (cons (Let name (car rhs-pair) (car body-pair))
           (append (cdr rhs-pair)
                   (cdr body-pair)))]
    [(Prim op args)
     (define name (freshen-tmp))
     (cons (Var name)
           (list (cons name (Prim op (map rco-exp args)))))]))

(define (freshen-tmp)
  (gensym "tmp."))

(note make-lets (-> (map-t name-t exp-t) exp-t exp-t))
(define (make-lets exp-map base-exp)
  (match exp-map
    ['() base-exp]
    [(cons (cons name exp) rest-map)
     (make-lets rest-map (Let name exp base-exp))]))

(provide rco-exp)

(note rco-exp (-> exp-t exp-t))
(define (rco-exp exp)
  (match exp
    [(Var name) (Var name)]
    [(Int n) (Int n)]
    [(Let name rhs body)
     (Let name (rco-exp rhs) (rco-exp body))]
    [(Prim op args)
     (define pairs (map rco-atom args))
     (define new-args (map car pairs))
     (define exp-map (append* (map cdr pairs)))
     (make-lets exp-map (Prim op new-args))]))

(provide rco-program)
(define (rco-program program)
  (match program
    [(Program info body)
     (Program info (rco-exp body))]))
