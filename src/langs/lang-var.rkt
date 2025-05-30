#lang racket

(require "../deps.rkt")
(require "lang-int.rkt")

(provide lang-var-class)

(define-class lang-var-class (lang-int-class)
  (define/override ((evaluate-exp env) exp)
    (match exp
      [(Var name) (dict-ref env name)]
      [(Let name rhs body)
       (define new-env (dict-set env name ((evaluate-exp env) rhs)))
       ((evaluate-exp new-env) body)]
      [else ((super evaluate-exp env) exp)])))
