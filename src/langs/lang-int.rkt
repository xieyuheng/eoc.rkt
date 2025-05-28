#lang racket

(require "../deps.rkt")

(provide lang-int-class)

(define-class lang-int-class ()
  (note interpret-program (-> program-t value-t))
  (define/public (interpret-program program)
    (match program
      [(Program (list) exp)
       ((interpret-exp (list)) exp)]))

  (note interpret-exp (-> env-t exp-t value-t))
  (define/public ((interpret-exp env) exp)
    (match exp
      [(Int n) n]
      [(Prim 'read (list))
       (define r (read))
       (cond [(fixnum? r) r]
             [else (error 'interpret-exp "expected an integer" r)])]
      [(Prim '- (list e))
       (fx- 0 ((interpret-exp env) e))]
      [(Prim '+ (list e1 e2))
       (fx+ ((interpret-exp env) e1) ((interpret-exp env) e2))]
      [(Prim '- (list e1 e2))
       (fx- ((interpret-exp env) e1) ((interpret-exp env) e2))])))
