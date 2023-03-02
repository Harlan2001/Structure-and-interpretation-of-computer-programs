#lang racket

; Recursive version
(define (filtered-accumulate filter combiner null_value term a next b)
  (if (> a b)
      null_value
      (if (filter a)
          (combiner (term a) (filtered-accumulate filter combiner null_value term (next a) next b))
          (filtered-accumulate filter combiner null_value term (next a) next b))))

; Iterative version
(define (filtered-accumulate-2 filter combiner null_value term a next b)
  (define (iter a ret)
    (if (> a b)
        ret
        (if (filter a)
            (iter (next a) (combiner (term a) ret))
            (iter (next a) ret))))
  (iter a null_value))

;;;;;;;;;;;;;;;;;;;;
; Determine if it is prime
(define (square x) (* x x))
(define (inc n) (+ n 1))
(define (identity x) x)

(define (prime? n)
  (define (smallest-divisor n)
    (find-divisor n 2))
  
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
  
  (define (divides? a b)
    (= (remainder b a) 0))
  
  (= n (smallest-divisor n)))

; Find gcd
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;;;;;;;;;;;;;;;;;;;;;
; a) Find the sum of all the primes between [a, b]
(define (sum-prime a b)
  (filtered-accumulate prime? + 0 identity a inc b))


; b)Take the product of all positive integers less than n that are congruent with n
(define (product-coprime n)
  (define (filter i)
    (= (gcd i n) 1))
  (filtered-accumulate-2 filter * 1 identity 1 inc (- n 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (check-equal? (sum-prime 2 10) (+ 2 3 5 7))
  (check-equal? (sum-prime 2 20) (+ 2 3 5 7 11 13 17 19))
  
  (check-equal? (product-coprime 10) (* 1 3 7 9))
  (check-equal? (product-coprime 20) (* 1 3 7 9 11 13 17 19))
)
