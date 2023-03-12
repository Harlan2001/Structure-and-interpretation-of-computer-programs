#lang racket

(require "stream.scm")
(require "infinite_stream.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

;Divide it into four pieces
;A number on the top left, a line on the top, a line on the left, a chunk on the bottom right
(define (all-pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (interleave
        (stream-map (lambda (x) (list (stream-car s) x))
                    (stream-cdr t))
        (stream-map (lambda (x) (list x (stream-car t)))
                    (stream-cdr s)))
      (all-pairs (stream-cdr s) (stream-cdr t)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(displayln "int-all-pairs")
(define int-all-pairs (all-pairs integers integers))
(display-stream-n int-all-pairs 100)
