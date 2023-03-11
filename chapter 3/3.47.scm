#lang sicp

(#%require "serializer.scm")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;The implementation of the semaphore requires maintaining a counter.With each fetch, the counter is decrement and retries are required when the counter reaches 0.On release
;Increment the counter.The point is that the counter itself requires either a mutex or a test-and-set!To protect.

; a) Based on mutex
(define (make-semaphore n)
  (let ((lock (make-mutex)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (lock 'acquire)
             (if (> n 0)
                 (begin
                   (set! n (- n 1))
                   (lock 'release))
                 (begin
                   (lock 'release)
                   (the-semaphore 'acquire)))) ; retry
            ((eq? m 'release)
             (lock 'acquire)
             (set! n (+ n 1))
             (lock 'release))))
    the-semaphore))

; b) Based on test-and-set! , similar to the mutex-based version.
; Just expand the implementation of (lock 'acquire) and (lock 'release).
(define (make-semaphore-2 n)
  (let ((cell (list false)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-semaphore 'acquire)
                 (if (> n 0)
                     (begin 
                       (set! n (- n 1))
                       (clear! cell))
                     (begin
                       (clear! cell)
                       (the-semaphore 'acquire)))))  ; retry
            ((eq? m 'release)
             (if (test-and-set! cell)
                 (the-semaphore 'release))
             (set! n (+ n 1))
             (clear! cell))))
    the-semaphore))
