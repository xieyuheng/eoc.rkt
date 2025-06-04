#lang racket

(provide alist-map-value)

(define (alist-map-value alist f)
  (map (match-lambda
         [(cons key value)
          (cons key (f value))])
       alist))
