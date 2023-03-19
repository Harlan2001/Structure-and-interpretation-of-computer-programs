#lang sicp

(#%require "ch5-compiler.scm")

(compile
  '(define (factorial n)
     (define (iter product counter)
       (if (> counter n)
           product
           (iter (* counter product)
                 (+ counter 1))))
     (iter 1))
  'val
  'next)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define compiled-code
  '(
    Define the factorial procedure
    ((assign val (op make-compiled-procedure) (label entry1) (reg env))
     (goto (label after-lambda2))
        
   ;;factorial entrance
   entry1
     (assign env (op compiled-procedure-env) (reg proc))
     (assign env (op extend-environment) (const (n)) (reg argl) (reg env))
     
     ;Define iter procedure
     (assign val (op make-compiled-procedure) (label entry3) (reg env))
     (goto (label after-lambda4))
      
     ;iter entrance
   entry3
     (assign env (op compiled-procedure-env) (reg proc))
     (assign env (op extend-environment) (const (product counter)) (reg argl) (reg env))
     
     (save continue)
     (save env)
     
     ; (> counter n)
     (assign proc (op lookup-variable-value) (const >) (reg env))
     (assign val (op lookup-variable-value) (const n) (reg env))
     (assign argl (op list) (reg val))
     (assign val (op lookup-variable-value) (const counter) (reg env))
     (assign argl (op cons) (reg val) (reg argl))
     (test (op primitive-procedure?) (reg proc))
     (branch (label primitive-branch8))
   compiled-branch9
     (assign continue (label after-call10))
     (assign val (op compiled-procedure-entry) (reg proc))
     (goto (reg val))
   primitive-branch8
     (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
   after-call10
     (restore env)
     (restore continue)
     
     ; judge (if (> counter n)
     (test (op false?) (reg val))
     (branch (label false-branch6))
     
   true-branch5
     ; product
     (assign val (op lookup-variable-value) (const product) (reg env))
     (goto (reg continue))
     
   false-branch6
      ;Find the iter operator
     (assign proc (op lookup-variable-value) (const iter) (reg env))
     (save continue)
     
     (save proc)
     (save env)
     
     ; (+ counter 1)
     (assign proc (op lookup-variable-value) (const +) (reg env))
     (assign val (const 1))
     (assign argl (op list) (reg val))
     (assign val (op lookup-variable-value) (const counter) (reg env))
     (assign argl (op cons) (reg val) (reg argl))
     (test (op primitive-procedure?) (reg proc))
     (branch (label primitive-branch14))
   compiled-branch15
     (assign continue (label after-call16))
     (assign val (op compiled-procedure-entry) (reg proc))
     (goto (reg val))
   primitive-branch14
     (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
   after-call16
   
     ;argl collects the first argument
     (assign argl (op list) (reg val))
     (restore env)
     (save argl)
     
     ; (* counter product)
     (assign proc (op lookup-variable-value) (const *) (reg env))
     (assign val (op lookup-variable-value) (const product) (reg env))
     (assign argl (op list) (reg val))
     (assign val (op lookup-variable-value) (const counter) (reg env))
     (assign argl (op cons) (reg val) (reg argl))
     (test (op primitive-procedure?) (reg proc))
     (branch (label primitive-branch11))
   compiled-branch12
     (assign continue (label after-call13))
     (assign val (op compiled-procedure-entry) (reg proc))
     (goto (reg val))
   primitive-branch11
     (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
   after-call13
     (restore argl)
     
     ;argl collects the second argument
     (assign argl (op cons) (reg val) (reg argl))
     (restore proc)
     (restore continue)
     
     ;Tail recursive call  (iter (* counter product) (+ counter 1))))，
     ;Note that once proc and argl are set, the jump is done without saving registers to the stack.
     ;The stack only uses constant space
     (test (op primitive-procedure?) (reg proc))
     (branch (label primitive-branch17))
   compiled-branch18
     (assign val (op compiled-procedure-entry) (reg proc))
     (goto (reg val))
   primitive-branch17
     (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
     (goto (reg continue))
   after-call19
   after-if7
     
   after-lambda4
      ;At the end of (define (iter xx)), set the name
     (perform (op define-variable!) (const iter) (reg val) (reg env))
     (assign val (const ok))
     
     ;Call (iter 1)
     (assign proc (op lookup-variable-value) (const iter) (reg env))
     (assign val (const 1))
     (assign argl (op list) (reg val))
     (assign val (const 1))
     (assign argl (op cons) (reg val) (reg argl))
     (test (op primitive-procedure?) (reg proc))
     (branch (label primitive-branch20))
   compiled-branch21
     (assign val (op compiled-procedure-entry) (reg proc))
     (goto (reg val))
   primitive-branch20
     (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
     (goto (reg continue))
     after-call22
     
   after-lambda2
      ;At the end of (define (factorial xx)), set the name
     (perform (op define-variable!) (const factorial) (reg val) (reg env))
     (assign val (const ok)))))
