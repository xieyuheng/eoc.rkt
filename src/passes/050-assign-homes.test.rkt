#lang racket

(require "../deps.rkt")
(require "010-uniquify.rkt")
(require "020-remove-complex-operands.rkt")
(require "030-explicate-control.rkt")
(require "040-select-instructions.rkt")
(require "050-assign-homes.rkt")

(format-x86-program
 (select-instructions
  (explicate-control
   (rco-program
    (uniquify
     (parse-program
      '(program
        ()
        (let ([a 42])
          (let ([b a])
            b)))))))))

;; (format-x86-program
;;  (select-instructions
;;   (explicate-control
;;    (rco-program
;;     (uniquify
;;      (parse-program
;;       '(program
;;         ()
;;         (let ((y (let ((x 20))
;;                    (+ x (let ((x 22)) x)))))
;;           y))))))))

;; (format-x86-program
;;  (select-instructions
;;   (explicate-control
;;    (rco-program
;;     (uniquify
;;      (parse-program
;;       '(program
;;         ()
;;         (let ((y (let ((x.1 20))
;;                    (let ((x.2 22))
;;                      (+ x.1 x.2)))))
;;           y))))))))

;; (format-x86-program
;;  (select-instructions
;;   (explicate-control
;;    (rco-program
;;     (uniquify
;;      (parse-program
;;       '(program
;;         ()
;;         (let ((z (let ((y (let ((x 6))
;;                             x)))
;;                    y)))
;;           z))))))))
