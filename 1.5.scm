;(define (p) (p))
;Infinite recursion, if (p) needs to be evaluated, the program does not stop.Scheme has tail-recursive optimization, and the heap does not overflow.
;According to the book P10, application order and regular order description.
;In case of application order, parameter values need to be evaluated first, so (test 0 (p)) needs to be evaluated first (p).Therefore, in application order, (test 0 (p)) does not stop.
;If it is regular order, it will be fully expanded and then reduced, so (test 0 (p)) will be expanded to
;(if (= 0 0)
;    0
;    (p))
Since (= 0 0) is true, the result is 0, and (p) is not called.Thus, in regular order, (test 0 (p)) results in 0.
The conclusion is that if the interpreter uses application order, (test 0 (p)) will not stop.If regular order is used, the result of (test 0 (p)) is 0.
