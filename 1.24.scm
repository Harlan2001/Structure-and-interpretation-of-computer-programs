#lang sicp

(define (square x) (* x x))
(define (runtime) (current-inexact-milliseconds)) 

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))  

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 100)
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
