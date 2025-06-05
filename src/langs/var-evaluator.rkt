#lang racket

(require "../deps.rkt")
(require "int-evaluator.rkt")

(provide var-evaluator-class)

(define-class var-evaluator-class (int-evaluator-class)
  (define/override ((evaluate-exp env) exp)
    (match exp
      [(Var name) (alist-get-or-fail env name)]
      [(Let name rhs body)
       (define new-env (alist-set env name ((evaluate-exp env) rhs)))
       ((evaluate-exp new-env) body)]
      [else ((super evaluate-exp env) exp)])))
