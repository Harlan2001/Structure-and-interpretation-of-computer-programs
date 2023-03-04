#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (make-segment start end)
  (cons start end))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

;;;;;;;;;;;;;;;;;;;
(define a (make-segment (make-vect 0 0)
                        (make-vect 10 10)))
(start-segment a)
(end-segment a)
