#lang racket

;; The target language of this pass is a variant of x86 that still uses
;; variables, so we add an AST node of the form (Var var) to the arg
;; nonterminal of the x86Int abstract syntax.

(require "../deps.rkt")

(define (select-instr-atm atm)
  (match atm
    [(Int value) (Imm value)]
    [(Var name) (Var name)]))

;; select-instr-stmt
;; select-instr-tail
;; select-instr-c-program
