#lang sicp

;Let x1 advance 1 space each time using cdr and x2 advance 2 space each time using cddr.So x2 starts out in front of x1.
;So when the list contains rings, x2 will go around, catching up with x1 from behind.
;So when x1 and x2 meet, that means we have a ring.When x2 reaches the tail, it means it contains no ring.
;I don't have to decide if x1 is going to get to the tail, because x2 is going to get to the tail faster every time we go 2 Spaces, so x2 is going to get to the tail first without the ring.

(define (contains-cycle? x)
  (define (contains-cycle-step? x1 x2) 
    (cond ((not (pair? x2)) false)
          ((not (pair? (cdr x2))) false)
          ((eq? x1 x2) true)
          (else (contains-cycle-step? (cdr x1) (cddr x2)))))
  (if (not (pair? x))
      false
      (contains-cycle-step? x (cdr x))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (last-pair x)
  (if (null? (cdr x))
      x 
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(contains-cycle? (list 'a 'b 'c))                 ; #f
(contains-cycle? (make-cycle (list 'a)))          ; #t
(contains-cycle? (make-cycle (list 'a 'b 'c)))    ; #t
(contains-cycle? (make-cycle (list 'a 'b 'c 'd))) ; #t

(contains-cycle? (cons 1 2))                      ; f
(contains-cycle? '(1))                            ; f
(contains-cycle? '())                             ; f
