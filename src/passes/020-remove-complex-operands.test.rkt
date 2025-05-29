#lang racket

(require "../deps.rkt")
(require "../langs/lang-var.rkt")
(require "010-uniquify.rkt")
(require "020-remove-complex-operands.rkt")

(define lang (new lang-var-class))

(format-program
 (rco-program
  (parse-program
   '(program
     ()
     (let ([x (+ 42 (- 10))])
       (+ x 10))))))

(format-program
 (rco-program
  (parse-program
   '(program
     ()
     (+ (+ 1 2) (+ 3 (+ 4 5)))))))

(format-program
 (rco-program
  (parse-program
   '(program
     ()
     (let ([a 42])
       (let ([b a])
         b))))))

(assert-equal?
 (send lang interpret-program
       (rco-program
        (uniquify
         (parse-program
          '(program
            ()
            (let ([x (+ 42 (- 10))])
              (+ x 10)))))))
 42)
