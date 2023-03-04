#lang racket

(define (reverse items)
  (define (iter items result)
    (if (null? items)
        result
        (iter (cdr items) (cons (car items) result))))
  (iter items null))

;;;;;;;;;;;
(reverse (list 1 4 9 16 25))
