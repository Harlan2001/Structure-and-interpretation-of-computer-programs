#lang racket
;;;对于点的函数构建
(define (make-point x y )
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

;;;对于线的部分函数构建
(define (make-segment start end)
  (cons start end))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

(define (midpoint-segment seg)
  (define (average a b)
    (/ (+ a b) 2.0))
  (define (midpoint a b)
    (make-point (average (x-point a) (x-point b))
                (average (y-point a) (y-point b))))
  (midpoint (start-segment seg) (end-segment seg)))

;;;输出
(define seg0 (make-segment (make-point 100 100) (make-point 200 200)))
(define seg1 (make-segment (make-point 5 10) (make-point 40 80)))
(print-point (midpoint-segment seg0))
(print-point (midpoint-segment seg1))
