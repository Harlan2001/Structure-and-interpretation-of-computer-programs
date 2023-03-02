#lang racket

; Recursive version
(define (cont-frac n-fn d-fn k)
  (define (impl i)
    (if (= i k)
        (/ (n-fn i) (d-fn i))
        (/ (n-fn i) (+ (d-fn i) (impl (+ i 1))))))
  (impl 1))

; Iterative version
(define (cont-frac-2 n-fn d-fn k)
  (define (iter i ret)
    (if (< i 1)
        ret
        (iter (- i 1) 
              (/ (n-fn i) (+ (d-fn i) ret)))))
  (iter (- k 1) (/ (n-fn k) (d-fn k))))

(define (golden-ratio n)
  (define (fn x) 1)
  (cont-frac fn fn n))

(define (golden-ratio-2 n)
  (define (fn x) 1)
  (cont-frac-2 fn fn n))

;;;;;;;;;;;;;;;;;;;;;
(exact->inexact (golden-ratio 10))
(exact->inexact (golden-ratio 11))

(require rackunit)
(check-= (golden-ratio 10) (golden-ratio-2 10) 0.0001)
(check-= (golden-ratio 11) (golden-ratio-2 11) 0.0001)

;the return is:
;(golden-ratio 10) = 0.6179775280898876
;(golden-ratio 11) = 0.6180555555555556
;and the precise result is 0.61803398874989
;so, as long as k = 11, the first four decimal places of the result are exactly the same.
