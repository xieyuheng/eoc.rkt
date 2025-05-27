#lang racket

(require "deps.rkt")

(provide lang-int-class)

(define-class lang-int-class ()
  (define/public (interpret-program program)
    (match program
      [(Program (list) exp) (interpret-exp exp)]))

  (define/public (interpret-exp exp)
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
       (fx- (interpret-exp e1) (interpret-exp e2))])))
