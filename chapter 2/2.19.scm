#lang racket

(define (count-change amount coin-values)
  (cc amount coin-values))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else (+ (cc amount 
                     (except-first-denomination coin-values))
                 (cc (- amount 
                        (first-denomination coin-values))
                     coin-values)))))

(define no-more? null?)
(define except-first-denomination cdr)
(define first-denomination car)

;;;;;;;;;;;;;;;;;;

(define us-coins (list 50 25 10 5 1))
(count-change 100 us-coins)
(count-change 100 (list 10 25 50 1 5))

;The order of coin-values does not affect cc's calculated answer.In the code above, pass in two lists of different order, and the result is 292.
;cc's calculation expands the tree and traverses the coin-values list thoroughly.
;The tree expansion terminates with the amount value and the number of coin-values lists, independent of the data contained in the coin-values list.
;That is, regardless of the order of the list passed in, the tree will eventually unfold with the same specific leaves, but in a different order.
;The order of the list only affects the order of the leaves, not the leaves themselves.And cc is going to add up all the leaves, and the order of the leaves doesn't matter.
;Therefore, the order of the list does not affect the final calculation result of cc.
