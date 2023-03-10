#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((eq? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (count-pairs x)
  (let ((visited '()))
    (define (count-pairs-set x)
      (cond ((not (pair? x)) 0)
            ((element-of-set? x visited) 0)
            (else 
              (set! visited (adjoin-set x visited))
              (+ (count-pairs-set (car x))
                 (count-pairs-set (cdr x))
                 1))))
    (count-pairs-set x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The test cases that practiced 3.16 all now return 3 correctly
(define z1 (list 'a 'b 'c))
(count-pairs z1)

(define x2 (cons 'a 'b))
(define z2 (cons 'c (cons x2 x2)))
(count-pairs z2)

(define x3 (cons 'a 'b))
(define y3 (cons x3 x3))
(define z3 (cons y3 y3))
(count-pairs z3)

(define z4 (list 'a 'b 'c))
(set-cdr! (cddr z4) z4)
(count-pairs z4)
