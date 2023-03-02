#lang sicp
(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (fast-mul b n)
  (define (iter ret b n)
    (cond ((= n 0) ret)
          ((even? n) (iter ret (double b) (halve n)))
          (else (iter (+ ret b) b (- n 1)))))
  (iter 0 b n))
