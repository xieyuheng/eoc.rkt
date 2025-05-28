#lang racket

(require "../deps.rkt")
(require "lang-int.rkt")

(provide lang-var-class)

(define-class lang-var-class (lang-int-class)
  (define/override ((interpret-exp env) exp)
    (match exp
      [(Var name) (dict-ref env name)]
      [(Let name rhs body)
       (define new-env (dict-set env name ((interpret-exp env) rhs)))
       ((interpret-exp new-env) body)]
      [else ((super interpret-exp env) exp)])))
