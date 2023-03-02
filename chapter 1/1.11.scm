#lang sicp

;; recursion
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

;; iteration
(define (f2 n)
  (define (iter a b c count)
    (if (= count 0)
        c
        (iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))
  
  (if (< n 3)
      n
      (iter 0 1 2 (- n 2))))
