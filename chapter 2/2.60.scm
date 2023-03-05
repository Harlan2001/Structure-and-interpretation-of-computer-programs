#lang racket

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (append set1 set2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define a '(1 2 2 3 4 4 5 6))
(define b '(4 4 5 6 7 8 9))

(element-of-set? 10 a)  ; #f
(element-of-set? 9 b)   ; #t

(adjoin-set 10 a)       ; '(10 1 2 2 3 4 4 5 6)
(intersection-set a b)  ; '(4 4 5 6)
(union-set a b)         ; '(1 2 2 3 4 4 5 6 4 4 5 6 7 8 9)

;In the above implementation, element-of-set?And intersection-set are the same as the unrepeated representation.element-of-set? The complexity of intersection-set is O(n) and O(n ^ 2).
;While adjoin-set has constant complexity O(1), and union-set complexity is O(n), which is short before being used.
;In duplicate representations, if the data duplication rate is too high, more memory space will be consumed and the search will be slower.
;A duplicate representation is suitable for situations where there is little chance of the data itself repeating.
