#lang racket

(require "../deps.rkt")

(provide rco-program)

(define (rco-program program)
  (match program
    [(Program info body)
     (Program info (rco-exp body))]))

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

(define (freshen-tmp)
  (gensym "tmp."))

(note make-lets (-> (map-t name-t exp-t) exp-t exp-t))
(define (make-lets exp-map base-exp)
  (match exp-map
    ['() base-exp]
    [(cons (cons name exp) rest-map)
     (make-lets rest-map (Let name exp base-exp))]))

(note rco-atom (-> exp-t (pair-t exp-t (map-t name-t exp-t))))
(define (rco-atom exp)
  (match exp
    [(Var name) (cons (Var name) '())]
    [(Int n) (cons (Int n) '())]
    [(Let name rhs body)
     (define body-pair (rco-atom body))
     (define new-body (car body-pair))
     (define exp-map (cdr body-pair))
     (cons new-body (dict-set exp-map name (rco-exp rhs)))]
    [(Prim op args)
     (define pairs (map rco-atom args))
     (define new-args (map car pairs))
     (define exp-map (append* (map cdr pairs)))
     (define name (freshen-tmp))
     (cons (Var name) (dict-set exp-map name (Prim op new-args)))]))
