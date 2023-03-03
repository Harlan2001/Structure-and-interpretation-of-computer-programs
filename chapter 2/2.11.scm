#lang racket

;; P63 - [练习 2.11]

(define (make-interval a b)
  (cons a b))

(define (lower-bound v)
  (car v))

(define (upper-bound v)
  (cdr v))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (add-interval
    x
    (make-interval (- (upper-bound y))
                   (- (lower-bound y)))))

(define (mul-interval x y)
  (let ((l_x (lower-bound x))
        (u_x (upper-bound x))
        (l_y (lower-bound y))
        (u_y (upper-bound y)))

      (cond ((< u_x 0)  ; x 全为负
              (cond ((< u_y 0) (make-interval (* u_x u_y) (* l_x l_y)))     ; y 全为负
                    ((> l_y 0) (make-interval (* l_x u_y) (* u_x l_y)))     ; y 全为正
                    (else      (make-interval (* l_x u_y) (* l_x l_y)))))   ; y 跨过 0

            ((> l_x 0)  ; x 全为正
              (cond ((< u_y 0) (make-interval (* u_x l_y) (* l_x u_y)))     ; y 全为负 
                    ((> l_y 0) (make-interval (* l_x l_y) (* u_x u_y)))     ; y 全为正
                    (else      (make-interval (* u_x l_y) (* u_x u_y)))))   ; y 跨过 0

            (else           ; x 跨过 0
              (cond ((< u_y 0) (make-interval (* u_x l_y) (* l_x l_y)))     ; y 全为负 
                    ((> l_y 0) (make-interval (* l_x u_y) (* u_x u_y)))     ; y 全为正
                    (else      (make-interval (min (* u_x l_y) (* l_x u_y)) ; y 跨过 0
                                              (max (* l_x l_y) (* u_x u_y)))
                    )))
            )))
                              

(define (div-interval x y)
  (if (<= (* (lower-bound y) (upper-bound y)) 0)
      (error "division error (interval spans 0)" y)
      (mul-interval 
        x
        (make-interval (/ 1.0 (upper-bound y))
                       (/ 1.0 (lower-bound y))))))

(define (print-interval v)
  (newline)
  (display "[")
  (display (lower-bound v))
  (display ", ")
  (display (upper-bound v))
  (display "]"))

;;;;;;;;;;;;;;;;;;;;;
(define a (make-interval 10 20))
(define b (make-interval 1 5))
(print-interval (add-interval a b))
(print-interval (sub-interval a b))
(print-interval (mul-interval a b))
(print-interval (div-interval a b))
;(print-interval (div-interval a (make-interval -1 1))) ; error
