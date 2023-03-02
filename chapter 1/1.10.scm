#lang sicp

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 1 10)
(A 2 4)
(A 3 3)

;The return is:
;1024
;65536
;65536

;To understand how the code really works, we can expand the calculation process.
(A 1 10)
(A 0 (A 1 9))
(* 2 (A 1 9))
(* 2 (A 0 (A 1 8))
(* 2 (* 2 (A 1 8))
(* 2 (* 2 (A 0 (A 1, 7))
(* 2 (* 2 (* 2 (A 1, 7))
....
(* 2 (* 2 (* 2 (* 2 ....(* 2 (A 1 1))))))))))
(* 2 (* 2 (* 2 (* 2 ....(* 2 2)))))))       ;; 10 个 2 连续相乘
....
1024
;From the expansion of (A 1 10),we can see that the result of (A 1 n) is the multiplication of n twos,
;which is 2 to the power of n (expt 2 n).



(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 1 2)))
;; Then, instead of expanding gradually, we use the conclusion (A 1 n) = (expt 2 n).
...
(A 1 (A 1 4))
(A 1 16)
65536
;From the expansion of (A, 2, 4), it can be seen that the result of (A, 2, n) is continuously raised to the NTH power.
;That is (expt 2 (expt 2 (expt 2 1)), 
;that is
(A 2 1) = (expt 2 1) = 2
(A 2 2) = (expt 2 (A 2 1)) = (expt 2 2) = 4
(A 2 3) = (expt 2 (A 2 2)) = (expt 2 4) = 16
(A 2 4) = (expt 2 (A 2 3)) = (expt 2 16) = 65536
(A 2 5) = (expt 2 (A 2 4)) = (expt 2 65536) = Super big numbers

(A 3 3)
(A 2 (A 3 2))
(A 2 (A 2 (A 3 1)))
(A 2 (A 2 2))
(A 2 4)
65536

;So,we can conclude that
;(A 0 n) is expanded to (* 2 n), and the mathematical formula is 2 * n
;(A 1 n), as I said up here, is 2 to the n.The mathematical formula is 2 to the n.
;(A 2 n), which I said up here, to the NTH power.The mathematical formula is 2 to the 2 to the 2 to the...(2 ^ 2))) n times.

;So, we can use the conclusion to speculate the answer
(f n) =
(A 0 n) =
(* 2 n)

(g n) =
(A 1 n) =
(A 0 (A 1 (- n 1))) =
(f (A 1 (- n 1))) =
(f (g (- n 1))) =
(* 2 (g (- n 1)))

(h n) =
(A 2 n) =
(A 1 (A 2 (- n 1))) =
(g (A 2 (- n 1))) =
(g (h (- n 1))) =
(expt 2 (h (- n 1)))
