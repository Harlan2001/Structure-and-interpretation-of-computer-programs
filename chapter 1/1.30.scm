#lang racket

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1))
(define (cube x) (* x x x))

(define (simpson-integral f a b n)
  (define (factor k)
    (cond ((or (= k 0) (= k n)) 1)
          ((even? k) 2)
          (else 4)))
  
  (define (term k)
    (let ((h (/ (- b a) n)))
      (* (factor k) (f (+ a (* h k))))))
  
  (if (odd? n)
      (simpson-integral f a b (+ 1 n))
      (let ((h (/ (- b a) n)))
        (/ (* (sum term 0 inc n) h) 3.0))))

;;;;;;;;;;;;;;;;;;;;;;;;
(simpson-integral cube 0 1 100)
(simpson-integral cube 0 1 99)

;the return is:
0.25
0.25
