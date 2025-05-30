#lang racket

(require "../deps.rkt")
(require "../langs/lang-var.rkt")
(require "010-uniquify.rkt")
(require "020-remove-complex-operands.rkt")
(require "030-explicate-control.rkt")

(define lang (new lang-var-class))

(format-c-program
 (explicate-control
  (rco-program
   (uniquify
    (parse-program
     '(program
       ()
       (let ([y (let ([x 20])
                  (+ x (let ([x 22]) x)))])
         y)))))))

(format-c-program
 (explicate-control
  (rco-program
   (uniquify
    (parse-program
     '(program
       ()
       (let ([y (let ([x.1 20])
                  (let ([x.2 22])
                    (+ x.1 x.2)))])
         y)))))))

(format-c-program
 (explicate-control
  (rco-program
   (uniquify
    (parse-program
     '(program
       ()
       (let ([z (let ([y (let ([x 6])
                           x)])
                  y)])
         z)))))))
