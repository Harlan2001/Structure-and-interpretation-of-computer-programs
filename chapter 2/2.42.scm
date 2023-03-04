#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define empty-board null)

(define (safe? k positions)
  (define (same-row? v0 v1)
    (= (car v0) (car v1)))
  
  (define (same-diag? v0 v1)
    (= (abs (- (car v0) (car v1))) 
       (abs (- (cdr v0) (cdr v1)))))
  
  ;; pair_list restores (row, col) pairs
  (let ((pair_list (map cons positions (enumerate-interval 1 k))))
    (let ((val (car pair_list)))
      (= (length 
          (filter (lambda (x) 
                    (or (same-row? x val) (same-diag? x val)))
                  (cdr pair_list)))
         0))))

;; Glue new-row on the front, Take safe? out with car.
;; You can also use append to stick it in the back, but it's a little more difficult to get it out.
;;Sticking to the front and returning to the back, the results are equivalent, but the order of the solutions is different
(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))
  
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter 
          (lambda (positions) (safe? k positions))
          (flatmap
            (lambda (rest-of-queens)
              (map (lambda (new-row)
                     (adjoin-position new-row k rest-of-queens))
                   (enumerate-interval 1 board-size)))
            (queen-cols (- k 1))))))
  (queen-cols board-size))
