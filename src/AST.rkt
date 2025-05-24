#lang racket

(require "utils.rkt")

(provide (struct-out Int)
         (struct-out Prim))

(define-data Int [value])
(define-data Prim [op args])
