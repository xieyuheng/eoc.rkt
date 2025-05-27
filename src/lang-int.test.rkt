#lang racket

(require "deps.rkt")
(require "lang-int.rkt")

(assert-equal?
 (interpret-lang-int
  (Program (list) (Int 1)))
 1)

(assert-equal?
 (interpret-lang-int
  (Program (list) (Prim '- (list (Int 8)))))
 -8)

(assert-equal?
 (interpret-lang-int
  (Program (list) (Prim '- (list (Int 8) (Int 4)))))
 4)

(assert-equal?
 (pe-lang-int
  (Program (list) (Prim '- (list (Int 8) (Int 4)))))
 (Program (list) (Int 4)))

(assert-equal?
 (pe-lang-int
  (Program (list) (Prim '- (list (Int 8) (Prim 'read (list))))))
 (Program (list) (Prim '- (list (Int 8) (Prim 'read (list))))))

(assert-equal?
 (interpret-lang-int
  (pe-lang-int
   (Program (list) (Prim '- (list (Int 8) (Int 4))))))
 4)
