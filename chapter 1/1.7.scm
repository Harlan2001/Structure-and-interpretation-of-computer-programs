;Using Newton's method to find the square root of the code, to calculate relatively small numbers.
(sqrt (* 0.03 0.03))
;The result is 0.04030062264654547, but the correct result should be 0.03.Is it because of good-enough?The comparative error value is only 0.001.By making the error smaller, the calculation is more accurate, but it's still not accurate enough for fewer numbers.
;Let's say I'm doing a big number
(sqrt 100000000000000000.0)
;It doesn't stop, but the correct result should be 316227766.016838.
;This is because guess = 316227766.01683795, guess squares are large, 
;and in floating-point numbers, the precision left for decimal places is insufficient for extremely large numbers.
;Not enough to express the difference between two large numbers.
;So (<(abs (- (square guess) x)) is always greater than 0.001 error.
;And the result can't be improved any more, so it keeps cycling in guess = 316227766.01683795 without stopping.

;here is the new code for sqrt
#lang sicp

(define (average x y) 
  (/ (+ x y) 2))

(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

(define (square x) (* x x))

(define (sqrt-iter guess x)
  (if (new-good-enough? guess (improve guess x))
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (new-good-enough? guess new-guess)
  (< (abs (/ (- guess new-guess) guess))
     0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))


;the result will be:
(sqrt (* 0.03 0.03)) = 0.03002766742182557
(sqrt 100000000000000000.0) = 316228564.9222876
