#lang sicp
(define (max3 a b c)
  (cond ((and (>= a c) (>= b c)) (+ a b))
        ((and (>= a b) (>= c b)) (+ a c))
        (else (+ b c))))
