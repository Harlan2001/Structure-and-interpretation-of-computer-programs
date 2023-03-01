#lang racket
(define (square x) (* x x))
(define (runtime) (current-inexact-milliseconds)) 

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (begin
        (report-prime n (- (runtime) start-time))
        #t)
      #f))

(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " is prime: ")
  (display elapsed-time))

(define (search-for-primes n count)
  (define (make-odd n)
    (if (even? n)
        (+ n 1)
        n))
  (define (iter-even n count)
    (cond ((not (= count 0))
           (if (timed-prime-test n)
               (iter-even (+ n 2) (- count 1))
               (iter-even (+ n 2) count)))))
  (iter-even (make-odd n) count))

;;;;;;;;;;;;;;;;;
(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)
(search-for-primes 10000000 3)
(search-for-primes 100000000 3)


;and the return is :
1000 is prime: 0.001953125
10000 is prime: 0.007080078125
100000 is prime: 0.02197265625
1000000 is prime: 0.071044921875
10000000 is prime: 0.21923828125
100000000 is prime: 0.672119140625
