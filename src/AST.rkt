#lang racket

(provide (struct-out Int)
         (struct-out Prim))

(struct Int (value) #:transparent)
(struct Prim (op args) #:transparent)
