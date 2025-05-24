#lang racket

(provide define-data
         assert-equal?
         assert)

(define-syntax define-data
  (syntax-rules ()
    [(_ data-name field-names)
     (struct data-name field-names #:prefab)]))

(require rackunit)

(define-syntax assert-equal?
  (syntax-rules ()
    [(_ x y)
     (check-equal? x y)]))

(define-syntax assert
  (syntax-rules ()
    [(_ x)
     (check-not-false x)]))
