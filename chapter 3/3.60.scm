#lang racket

(require "stream.scm")
(require "infinite_stream.scm")
(require "3.59.scm")
(provide mul-series)

; s1 = (car-s1 + cdr-s1), s2 = (car-s2 + cdr-s2)
; s1 * s2 = car-s1 * car-s2 + cdr-s1 * car-s2 + cdr-s2 * car-s1 + cdr-s1 * cdr-s2
;When s1 and s2 are both power series,
;* car-s1 * car-s2 contains only constant terms
;* cdr-s1 * car-s2 + cdr-s2 * car-s1 The lowest term is x
;* cdr-s1 * cdr-s2 The lowest term is x^2
;The above formula corresponds to the following implementation.
(define (mul-series s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
                              (scale-stream (stream-cdr s2) (stream-car s1)))
                 (cons-stream 0 (mul-series (stream-cdr s1) (stream-cdr s2))))))

;You can merge the above formulas a little bit
;cdr-s1 * car-s2 + cdr-s1 * cdr-s2 Combine to become cdr-s1 * (car-s2 + cdr-s2) = cdr-s1 * s2
;So s1 * s2 = car-s1 * car-s2 + cdr-s2 * car-s1 + cdr-s1 * s2
;This corresponds to the following implementation
(define (mul-series-2 s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams (scale-stream (stream-cdr s2) (stream-car s1)) 
                 (mul-series-2 (stream-cdr s1) s2))))

;Another way to merge
;cdr-s2 * car-s1 + cdr-s1 * cdr-s2 Merge and become cdr-s2 * (car-s1 + cdr-s1) = cdr-s2 * s1
;So s1 * s2 is equal to car-s1 * car-s2 + cdr-s1 * car-s2 + cdr-s2 * s1
;This corresponds to the following implementation
(define (mul-series-3 s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams (scale-stream (stream-cdr s1) (stream-car s2)) 
                 (mul-series-3 (stream-cdr s2) s1))))

;;;;;;;;;;;;;;
(module* main #f
  ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (stream-head->list (add-streams (mul-series cosine-series cosine-series)
                                  (mul-series sine-series sine-series)) 
                     20)
  
  ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (stream-head->list (add-streams (mul-series-2 cosine-series cosine-series)
                                  (mul-series-2 sine-series sine-series)) 
                     20)
  
  ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (stream-head->list (add-streams (mul-series-3 cosine-series cosine-series)
                                  (mul-series-3 sine-series sine-series)) 
                     20)
)
