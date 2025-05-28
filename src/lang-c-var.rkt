#lang racket

(require "deps.rkt")
(require "lang-var.rkt")

(provide lang-c-var-mixin)

(define (lang-c-var-mixin super-class)
  (class super-class
    (super-new)

    (inherit interpret-exp)

    ))

(provide lang-c-var-class)

(define lang-c-var-class (lang-c-var-mixin lang-var-class))
