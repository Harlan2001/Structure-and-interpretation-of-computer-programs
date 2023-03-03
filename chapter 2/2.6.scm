(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
 ;one can be written as (add-1 zero), expand it out
 (add-1 zero)
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
(lambda (f) (lambda (x) (f x)))
;two can be written as (add-1 one), which expands to
(add-1 one)
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
(lambda (f) (lambda (x) (f (f x))))
;So one and two can be defined as:
(define zero (lambda (f) (lambda (x) x)))
(define one  (lambda (f) (lambda (x) (f x))))
(define two  (lambda (f) (lambda (x) (f (f x)))))
;It's a reasonable guess that the Church number is the number of times f is applied to x.
;zero applies f 0 times.one is to apply f once.two is applying f twice.
;And so on.To test this hypothesis, we can try the manual expansion (add-1 two) and see that it does.
;Let's say f is defined as inc and x is 0.So here's what happens
(define (inc x) (+ x 1))
((zero inc) 0)  ;; Apply inc to 0 0 times and the result is 0
((one inc) 0)   ;; Apply inc to 0 once and the result is 1
((two inc) 0)   ;; Apply inc to 0 twice and the result is 2



;Addition:
;Now let's define the addition of Church numbers.
;If you already had the add-church function, then (add-church one two) would apply f three times.
;The result is
(lambda (f) (lambda (x) (f (f (f x)))))
;The addition would look something like this
(define (add-church a b)
  (lambda (f) 
    (lambda (x) 
      ....)))
;But we don't know the details yet, so let's take a guess.
;In the example above, if f is inc and x is 0, it would look something like this.
((two inc) 0)
;We suspect that there will be something like this inside the add-church.
((a f) x)
;According to the definition of Church, the above calculation is expanded as
(fa (fa (fa ... (fa x))))	;; There are a fa, so fa is just f
;And by the same token, (b f) x) expands out to be
(fb (fb (fb ... (fb x))))	;; There are b fb, so fb is just f
;Therefore, the expansion of ((a f) ((b f) x)) is
(fa (fa (fa ... (fa ((b f) x)))))                  ;; There's a fa, and ((b f) x) hasn't been expanded yet
(fa (fa (fa ... (fa (fb (fb (fb ... (fb x))))))))  ;; there are a + b  f
;Therefore, the definition of add is obtained by combining the above half-guess and half-analysis
(define (add-church a b) 
 (lambda (f) 
   (lambda (x) 
     ((a f) ((b f) x)))))
;verification
(((add-church one two) inc) 0) ;; return 3





;;;; and the complete code is :
#lang racket

(define (make-church n)
  (define zero 
    (lambda (f) (lambda (x) x)))

  (define (add-1 a)
    (lambda (f) (lambda (x) (f ((a f) x)))))

  (if (= n 0) 
    zero
    (add-1 (make-church (- n 1)))))

(define (add-church a b) 
 (lambda (f) 
   (lambda (x) 
     ((a f) ((b f) x)))))

(define (int-from-church n)
  (define (inc x) (+ x 1))
  ((n inc) 0))

;;;;;;;;;;;;;;;;;;;;
(define a (make-church 10))
(define b (make-church 20))
(define c (add-church a b))

(int-from-church a)
(int-from-church b)
(int-from-church c)
