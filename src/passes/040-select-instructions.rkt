#lang racket

;; The target language of this pass is a variant of x86 that still uses
;; variables, so we add an AST node of the form (Var var) to the arg
;; nonterminal of the x86Int abstract syntax.

(require "../deps.rkt")

(define (select-instr-atm atm)
  (match atm
    [(Int value) (Imm value)]
    [(Var name) (Var name)]))

(note select-instr-assign (-> var-t c-exp-t (list-t instr-t)))
(define (select-instr-assign var rhs)
  (match rhs
    [(Int value)
     (list (Instr 'movq (list (select-instr-atm rhs) var)))]
    [(Var name)
     (list (Instr 'movq (list (select-instr-atm rhs) var)))]
    [(Prim 'read '())
     (list (Callq 'read_int)
           (Instr 'movq (list (Reg 'rax) var)))]
    [(Prim '- (list arg))
     (list (Instr 'movq (list (select-instr-atm arg) var))
           (Instr 'negq (list var)))]
    [(Prim '+ (list arg1 arg2))
     (list (Instr 'movq (list (select-instr-atm arg1) var))
           (Instr 'addq (list (select-instr-atm arg2) var)))]))

(note select-instr-stmt (-> stmt-t (list-t instr-t)))
(define (select-instr-stmt stmt)
  (match stmt
    [(Assign (Var name) (Prim '+ (list (Var name1) arg2)))
     #:when (equal? name name1)
     (list (Instr 'addq (list (select-instr-atm arg2) (Var name))))]
    [(Assign (Var name) (Prim '+ (list arg1 (Var name2))))
     #:when (equal? name name2)
     (list (Instr 'addq (list (select-instr-atm arg1) (Var name))))]
    [(Assign var rhs)
     (select-instr-assign var rhs)]))

(define (select-instr-tail tail)
  (match tail
    [(Seq stmt next-tail)
     (append (select-instr-stmt stmt)
             (select-instr-tail next-tail))]
    [(Return (Prim 'read '()))
     (list (Callq 'read_int)
           (Jmp 'conclusion))]
    [(Return exp)
     (append
      (select-instr-assign (Reg 'rax) exp)
      (list (Jmp 'conclusion)))]))

;; (define (select-instructions p)
;;   (match p
;;     [(Program info (CFG (list (cons 'start t))))
;;      (Program info
;;               (CFG (list (cons 'start (Block '() (select-instr-tail t))))))]))

;; select-instr-c-program
