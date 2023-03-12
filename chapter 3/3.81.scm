#lang racket

(require "stream.scm")
(require "infinite_stream.scm")

;Linear congruence. a and m are prime numbers
(define (rand-update x)
  (let ((a 48271) (b 19851020) (m 2147483647))
    (modulo (+ (* a x) b) m)))

(define random-init 7)
(define (rand-generator cmds)
  (define (rand-helper v cmds)
    (if (stream-null? cmds)
        the-empty-stream
        (let ((m (stream-car cmds)))
          (cond ((eq? m 'generate) 
                 (cons-stream v (rand-helper (rand-update v) (stream-cdr cmds))))
                ((and (pair? m) (eq? (car m) 'reset))
                 (rand-helper (cdr m) (stream-cdr cmds)))
                (else "error Unknown command -- RAND-GENERATOR" m)))))
  (rand-helper random-init cmds))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (list->stream lst)
  (if (null? lst)
      the-empty-stream
      (cons-stream (car lst) (list->stream (cdr lst)))))

(define cmds (list->stream (list 
                             'generate
                             'generate
                             'generate
                             'generate
                             'generate
                             (cons 'reset 10)
                             'generate
                             'generate
                             'generate
                             'generate
                             'generate
                             (cons 'reset 10)
                             'generate
                             'generate
                             'generate
                             'generate
                             'generate
                             )))
(display-stream (rand-generator cmds))
