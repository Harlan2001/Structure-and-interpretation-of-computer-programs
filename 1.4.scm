#lang sicp

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;if b is greater than 0 ,then return(a+b),
;else, return (a-b)
