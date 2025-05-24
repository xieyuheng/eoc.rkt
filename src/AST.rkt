#lang racket

(provide (struct-out Int)
         (struct-out Prim))

(define-syntax define-data
  (syntax-rules ()
    [(_ data-name field-names)
     (struct data-name field-names #:prefab)]))

(define-data Int [value])
(define-data Prim [op args])
