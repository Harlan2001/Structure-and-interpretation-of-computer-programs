#lang racket

(require "stream.scm")
(require "infinite_stream.scm")
(require "3.59.scm") ; for cosine-series、sine-series
(require "3.60.scm") ; for mul-series
(require "3.61.scm") ; for invert-unit-series

(define (div-series s1 s2)
  (if (= (stream-car s2) 0)
      (error "constant term of s2 can't be 0 -- DIV-SERIES")
      (mul-series s1 (invert-unit-series s2))))

(define tan-series
  (div-series sine-series cosine-series))

;;;;;;;;;;;;;;;;
(stream-head->list sine-series 10)
(stream-head->list cosine-series 10) 
(stream-head->list tan-series 10)
