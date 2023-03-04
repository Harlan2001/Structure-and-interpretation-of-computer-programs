#lang racket

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x))
                          rest)))))

;;;;;;;;;;;;;;;;;;;;;;;;;
(subsets (list 1 2 3))

;In the recursive code above.Compute the subset of (cdr s) first, denoted rest, so rest does not contain (car s).
;Every element of the rest you add (car s) is bound to contain (car s).
;The recursive procedure divides the subset of s into two parts, one that does not include (car s) and one that does include (car s).
;These two pieces together, of course, are a subset of s.
;Let's say I want to compute a subset of s = '(1, 2, 3).After calculating the subset of (cdr s) = '(2 3) (recursion here), we get
'(() (3) (2) (2 3)) ;; 1
;Using map, add (car s) = 1 to get
'((1) (1 3) (1 2) (1 2 3)) ;; 2
;Listing 1 and Listing 2 are then combined using append.I get a subset of s = '(1, 2, 3).
'(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
;And to compute a subset of '(2, 3), we compute a subset of '(3) first.
;And so on.Each time the number of lists decreases by 1, the termination condition is reached.
