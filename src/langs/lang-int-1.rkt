#lang racket

(require "../deps.rkt")

(provide interpret-lang-int)

(define (interpret-lang-int program)
  (match program
    [(Program (list) exp) (interpret-exp exp)]))

(define (interpret-exp exp)
  (match exp
    [(Int n) n]
    [(Prim 'read (list))
     (define r (read))
     (cond [(fixnum? r) r]
           [else (error 'interpret-exp "expected an integer" r)])]
    [(Prim '- (list e))
     (fx- 0 (interpret-exp e))]
    [(Prim '+ (list e1 e2))
     (fx+ (interpret-exp e1) (interpret-exp e2))]
    [(Prim '- (list e1 e2))
     (fx- (interpret-exp e1) (interpret-exp e2))]))

;; partial evaluation

(provide pe-lang-int)

(define (pe-lang-int program)
  (match program
    [(Program (list) exp)
     (Program (list) (pe-exp exp))]))

(define (pe-exp exp)
  (match exp
    [(Int n) (Int n)]
    [(Prim 'read (list)) (Prim 'read (list))]
    [(Prim '- (list e)) (pe-neg (pe-exp e))]
    [(Prim '+ (list e1 e2)) (pe-add (pe-exp e1) (pe-exp e2))]
    [(Prim '- (list e1 e2)) (pe-sub (pe-exp e1) (pe-exp e2))]))

(define (pe-neg r)
  (match r
    [(Int n) (Int (fx- 0 n))]
    [_ (Prim '- (list r))]))

(define (pe-add r1 r2)
  (match* (r1 r2)
    [((Int n1) (Int n2)) (Int (fx+ n1 n2))]
    [(_ _) (Prim '+ (list r1 r2))]))

(define (pe-sub r1 r2)
  (match* (r1 r2)
    [((Int n1) (Int n2)) (Int (fx- n1 n2))]
    [(_ _) (Prim '- (list r1 r2))]))
