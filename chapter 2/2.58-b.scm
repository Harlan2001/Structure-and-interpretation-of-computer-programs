#lang racket

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        (else
          (error "unknown expression type -- DERIV" exp))))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2) (+ a1 a2)))
        (else (list a1 '+ a2))))
  
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2) (* m1 m2)))
        (else (list m1 '* m2))))

(define (find-operation s)
  (cond ((memq '+ s) '+)
        ((memq '* s) '*)
        (else 'unknown)))

(define (take-until stop-symbol lst)
  (cond ((null? lst) null)
        ((equal? (car lst) stop-symbol) null)
        (else (cons (car lst) (take-until stop-symbol (cdr lst))))))

(define (simplify lst)
  (if (and (pair? lst) (= (length lst) 1))
    (simplify (car lst))
    lst))
  
(define (sum? x)
  (and (pair? x) (eq? (find-operation x) '+)))

(define (addend s) 
  (simplify (take-until '+ s)))

(define (augend s)
  (simplify (cdr (memq '+ s))))

(define (product? x)
  (and (pair? x) (eq? (find-operation x) '*)))

(define (multiplier s) 
  (simplify (take-until '* s)))

(define (multiplicand s)
  (simplify (cdr (memq '* s))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deriv '(x + (3 * (x + (y + 2)))) 'x)
(deriv '(x + 3 * (x + y + 2)) 'x)
