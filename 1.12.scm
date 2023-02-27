#lang sicp

(define (pascal-row n)
  (define (next-row lst)
    (if (= (length lst) 1)
        (list (car lst) (car lst))
        (let ((ret (next-row (cdr lst)))
              (first (car lst)))
          (cons first (cons (+ first (car ret)) (cdr ret))))))
  
  (if (<= n 1)
      (list 1)
      (next-row (pascal-row (- n 1)))))
