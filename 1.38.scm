;first, we need to know the ryle of D:
;i = 1 2 3 4 5 6 7 8 9 10 11 12 13 14 ....
;D = 1 2 1 1 4 1 1 6 1 1  8  1  1  10 ....

;Every third number of D, the even numbers are increasing.The relation between i and D is
(define (d-fn i)
  (if (= (remainder (+ i 1) 3) 0) ; (i + 1) % 3 == 0
      (/ (* 2 (+ i 1)) 3)         ; 2 * (i + 1) / 3
      1))
      
;so the code is: 
#lang racket

(define (cont-frac n-fn d-fn k)
  (define (impl i)
    (if (= i k)
        (/ (n-fn i) (d-fn i))
        (/ (n-fn i) (+ (d-fn i) (impl (+ i 1))))))
  (impl 1))

(define (compute-e k)
  (define (n-fn i) 1)
  (define (d-fn i)
    (if (= (remainder (+ i 1) 3) 0)
        (/ (* 2 (+ i 1)) 3)
        1))
  (+ (cont-frac n-fn d-fn k) 2))

;;;;;;;;;;;;;
(exact->inexact (compute-e 100))


;The result of calculating e is
;2.718281828459045

;And the exact result of e is
;2.7182818284590452353602874713526624977572470936999595749669.....
