#lang racket

(require "utils.rkt")

(provide (struct-out Int)
         (struct-out Prim)
         (struct-out Program))

(define-data Int [value])
(define-data Prim [op args])
(define-data Program [info body])
