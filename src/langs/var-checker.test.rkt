#lang racket

(require "../deps.rkt")
(require "var-checker.rkt")

(define checker (new var-checker-class))

(send checker type-check-program
      (parse-program '(program () 1)))
