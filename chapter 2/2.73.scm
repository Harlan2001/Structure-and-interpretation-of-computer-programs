#lang racket

;; P125 - [练习 2.73]

;;;;;;;;;;
;; put get Simple implementation
(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) #f))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a) 
;The original expression is (+ a1 a2) or (* a1 a2) so (car exp) is used to fetch the operator of the formula and (cdr exp) is used to fetch the argument of the formula
; Therefore, in the implementation of deriv, operators are used as the basis for assignment to transfer the corresponding parameters to the corresponding derivative formula.
; number? And variable? is not used data orientation , mainly because numbers and variables do not have corresponding operators.And we distribute based on operators,
; Without an operator, you can't distribute.If you must write it data-oriented, you need to add operators to it.
; For example, the number is '(num 10), and the variable is '(var x), but if you implement it this way.
; The original formula '(+ x 3), we need to write '(+ (var x) (num 3).It complicates things.

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp) var))))

; b)、c)
; It's easier to test deriv-2 and install-deriv-package-2.I'm going to write some functions outside.
;In fact, you can put deriv-sum, deriv-product, and so on inside install-deriv-package to avoid polluting the namespace。
; Or each derivative formula is disassembled and written as install-deriv-sum-package, install-deriv-product-package and other installation functions.

(define (install-deriv-package)  
  (put 'deriv '+  deriv-sum)
  (put 'deriv '*  deriv-product)
  (put 'deriv '** deriv-exponentiation)
  'done)

;; d) 
;; Just swap the first and second arguments in put.

(define (deriv-2 exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get (operator exp) 'deriv) (operands exp) var))))

(define (install-deriv-package-2)  
  (put '+  'deriv deriv-sum)
  (put '*  'deriv deriv-product)
  (put '** 'deriv deriv-exponentiation)
  'done)

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (deriv-sum args var)
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (make-sum (deriv (addend args) var)
            (deriv (augend args) var)))

(define (deriv-product args var)
  (define (multiplier s) (car s))
  (define (multiplicand s) (cadr s))
  (make-sum
    (make-product (multiplier args)
                   (deriv (multiplicand args) var))
    (make-product (deriv (multiplier args) var)
                   (multiplicand args))))

(define (deriv-exponentiation args var)
  (define (base s) (car s))
  (define (exponent s) (cadr s))
  (make-product
    (make-product (exponent args)
                  (make-exponentiation (base args) 
                                       (make-sum (exponent args) -1)))
    (deriv (base args) var)))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2) (+ a1 a2)))
        (else (list '+ a1 a2))))
  
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2) (* m1 m2)))
        (else (list '* m1 m2))))

(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
        ((=number? e 1) b)
        (else (list '** b e))))

;;;;;;;;;;;;;;;;;;;;;;
(install-deriv-package)
(deriv '(** x 4) 'x)
(deriv '(** x y) 'x)
(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)

(newline)

(install-deriv-package-2)
(deriv-2 '(** x 4) 'x)
(deriv-2 '(** x y) 'x)
(deriv-2 '(+ x 3) 'x)
(deriv-2 '(* x y) 'x)
(deriv-2 '(* (* x y) (+ x 3)) 'x)
