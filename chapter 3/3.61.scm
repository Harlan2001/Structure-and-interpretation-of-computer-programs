#lang racket

(require "stream.scm")
(require "infinite_stream.scm")
(require "3.59.scm") ; for cosine-series、exp-series
(require "3.60.scm") ; for mul-series
(provide invert-unit-series)

(define (neg-stream s)
  (scale-stream s -1))

(define (invert-unit-series s)
  (cons-stream
    1
    (neg-stream (mul-series (stream-cdr s) (invert-unit-series s)))))

;;;;;;;;;;;;;;;;;
(module* main #f
  (define a (invert-unit-series cosine-series))
  (stream-head->list (mul-series a cosine-series) 20) ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  
  (define b (invert-unit-series exp-series))
  (stream-head->list (mul-series b exp-series) 20)    ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
)
