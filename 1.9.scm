(define (+ a b)
  (if (= a 0) 
      b 
      (inc (+ (dec a) b))))
;Calculate (+ 4 5) and expand to
(+ 4 5)
(inc (+ 3 5))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9
;We can see the shape of the calculation, first expanding and then contracting.The calculation is recursive.
(define (+ a b)
  (if (= a 0) 
      b 
      (+ (dec a) (inc b))))
;Calculate (+ 4 5) and expand to
(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)
9
;The calculation process only uses constant storage, only needs to track two values a and b, and the steps required for calculation are proportional to parameter a.
;The calculation is linear and iterative.
