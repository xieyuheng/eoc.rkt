#lang racket

(require "../deps.rkt")

(provide int-evaluator-class)

(define-class int-evaluator-class ()
  (note evaluate-program (-> program-t value-t))
  (define/public (evaluate-program program)
    (match program
      ((Program info exp)
       ((evaluate-exp (list)) exp))))

  (note evaluate-exp (-> env-t exp-t value-t))
  (define/public ((evaluate-exp env) exp)
    (match exp
      ((Int n) n)
      ((Prim 'read (list))
       (define r (read))
       (cond ((fixnum? r) r)
             (else (error 'evaluate-exp "expected an integer" r))))
      ((Prim '- (list e))
       (fx- 0 ((evaluate-exp env) e)))
      ((Prim '+ (list e1 e2))
       (fx+ ((evaluate-exp env) e1) ((evaluate-exp env) e2)))
      ((Prim '- (list e1 e2))
       (fx- ((evaluate-exp env) e1) ((evaluate-exp env) e2))))))
