#lang racket

(require "stream.scm")
(require "infinite_stream.scm")
(require "stream_iterations.scm")
(require "3.55.scm") ; for partial-sums

(define (ln2-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln2-summands (+ n 1)))))

; Primary flow definition
(define ln2-stream
  (partial-sums (ln2-summands 1)))

; Eulerian acceleration
(define ln2-stream-2
  (euler-transform ln2-stream))

; superaccelerator
(define ln2-stream-3
  (accelerated-sequence euler-transform ln2-stream))

;;;;;;;;;;;;;;;;
(define (display-stream-withmsg msg s n)
  (display msg)
  (newline)
  (display-stream-n s n)
  (display "============")
  (newline))

(display-stream-withmsg "ln2-stream" ln2-stream 100)
(display-stream-withmsg "ln2-stream-2" ln2-stream-2 20)
(display-stream-withmsg "ln2-stream-3" ln2-stream-3 10)

;The precise value of ln2 0.693147180559945309417232121458176568075500134360255254120...
;The original ln2-stream converges very slowly. Even if 100 items are taken, the calculation result is 0.688172179310195, only 1 decimal place is the same.
;ln2-stream-2 with Euler acceleration has much faster convergence. The calculation result of 20 terms is 0.6931346368409872, with 4 decimal places the same.
;ln2-stream-3 with super acceleration has faster convergence rate,
