#lang sicp
(define (mul a b)
  (if (= b 0)
      0
      (+ a (mul a (- b 1)))))

(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (fast-mul a n)
  (cond ((= n 0) 0)
        ((even? n) (double (fast-mul a (halve n))))
        (else (+ a (fast-mul a (- n 1))))))

