#lang racket

(require "deps.rkt")

(provide (struct-out Int)
         (struct-out Prim)
         (struct-out Program))

(define-data Int [value])
(define-data Prim [op args])
(define-data Program [info body])
