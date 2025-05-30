#lang racket

(require "deps.rkt")

(provide (struct-out Imm)
         (struct-out Reg)
         (struct-out Deref)
         (struct-out Instr)
         (struct-out Callq)
         (struct-out Retq)
         (struct-out Jmp)
         (struct-out Block)
         (struct-out X86Program))

(define-data Imm [value])
(define-data Reg [name])
(define-data Deref [reg offset])
(define-data Instr [name arg*])
(define-data Callq [target arity])
(define-data Retq [])
(define-data Jmp [target])
(define-data Block [info instr*])
(define-data X86Program [info blocks])
