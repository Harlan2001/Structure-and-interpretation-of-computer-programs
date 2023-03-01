#lang racket

(define (cont-frac n-fn d-fn k)
  (define (impl i)
    (if (= i k)
        (/ (n-fn i) (d-fn i))
        (/ (n-fn i) (+ (d-fn i) (impl (+ i 1))))))
  (impl 1))

(define (tran-cf x k)
  (define (n-fn i)
    (if (= i 1)
        x
        (- (* x x))))
  (define (d-fn i)
    (- (* 2 i) 1))
  (cont-frac n-fn d-fn k))

;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (define (for-loop n last op)
    (cond ((<= n last)
           (op n)
           (for-loop (+ n 1) last op))))
  
  (define (test-n n)
    (let ((x (/ n (* 2 3.1415926))))
      (check-= (tran-cf x 100) (tan x) 0.0001)))
  
  (for-loop 0 360 test-n)
)
