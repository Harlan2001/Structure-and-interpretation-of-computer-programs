#lang sicp
(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

(define (square x) (* x x))

(define (cube-root-iter guess x)
  (if (new-good-enough? guess (improve guess x))
      guess
      (cube-root-iter (improve guess x) x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (new-good-enough? guess new-guess)
  (< (abs (/ (- guess new-guess) guess))
     0.001))

(define (cube-root x)
  (cube-root-iter 1.0 x))

(define (cube x)
  (* x x x))
