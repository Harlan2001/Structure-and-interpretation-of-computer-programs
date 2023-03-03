;According to the fundamental theorem of arithmetic, any composite number can be decomposed into the product of a series of prime numbers, and this factorization is unique.
;2 and 3 are both prime numbers.So if z is equal to (2 ^ a) * (3 ^ b), then if we factor z, we can uniquely identify a and b.
;In the following car implementation, divide by 2 repeatedly, adding up the count each time.And when we don't get enough, we can get back to a.The implementation of cdr is similar, just repeatedly divided by 3.
#lang racket

(define (my-cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (my-car z)
  (define (iter z a)
    (if (= 0 (remainder z 2))
      (iter (/ z 2) (+ a 1))
      a))
  (iter z 0))

(define (my-cdr z)
  (define (iter z b)
    (if (= 0 (remainder z 3))
      (iter (/ z 3) (+ b 1))
      b))
  (iter z 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(my-car (my-cons 10 20))
(my-cdr (my-cons 10 20))
