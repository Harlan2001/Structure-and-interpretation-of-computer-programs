#lang racket

(define f
  (let ((store-value 0))
    (lambda (x)
      (let ((old store-value))
        (set! store-value x)
        old))))

;;;;;;;;;;;;;;;;;;;
;The simulation (+ (f 0) (f 1)) evaluates from left to right.Evaluate from right to left and swap rows a and b
(define a (f 0))
(define b (f 1))
(+ a b)
