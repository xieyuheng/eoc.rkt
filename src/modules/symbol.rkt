#lang racket

(require "string.rkt")

(provide freshen)

(define (freshen name)
  (string->symbol
   (string-to-subscript
    (symbol->string
     (gensym (symbol->string name))))))
