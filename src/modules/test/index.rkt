#lang racket

(require rackunit)

(provide assert-equal?
         assert)

(define-syntax assert-equal?
  (syntax-rules ()
    [(_ x y)
     (check-equal? x y)]))

(define-syntax assert
  (syntax-rules ()
    [(_ x)
     (check-not-false x)]))
