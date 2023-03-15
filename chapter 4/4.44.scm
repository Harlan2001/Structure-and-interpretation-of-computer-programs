#lang sicp

(#%require "ambeval.scm")

(easy-ambeval 200 '(begin

(define (require p)
  (if (not p) (amb)))

(define (an-integer-between low high)
  (require (<= low high))
  (amb low (an-integer-between (+ low 1) high)))

(define (for-each-n proc items n)
  (cond ((not (null? items))
         (proc (car items) n)
         (for-each-n proc (cdr items) (+ n 1)))))

(define (require-safe-position pos positions)
  (define (same-row? v0 v1)
    (= (car v0) (car v1)))
  
  (define (same-diag? v0 v1)
    (= (abs (- (car v0) (car v1))) 
       (abs (- (cdr v0) (cdr v1)))))
  
  (for-each-n (lambda (x n)
                ;; (row . col)
                (require (not (same-row? (cons pos 1) (cons x n))))
                (require (not (same-diag? (cons pos 1) (cons x n)))))
              positions
              2))

(define (queens board-size)
  (define (queen-cols k positions)
    (if (= k 0)
        positions
        (let ((pos (an-integer-between 1 board-size)))
          (require-safe-position pos positions)
          (queen-cols (- k 1) (cons pos positions)))))
  (queen-cols board-size '()))

(queens 8)
                     
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;As a result, the eight Queens problem has 92 solutions
;;Solutions such as (4, 2, 7, 3, 6, 8, 5, 1) omit column numbers
;;That means column 1 goes in row 4, column 2 goes in row 2, and so on

