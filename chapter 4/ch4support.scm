#lang racket

(provide get put)
(provide redefineable redefine)
(provide prime?)
(provide permutations)

;; put get Simple implementation
(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) #f))

;;DrReacket cannot redefine functions outside the module.In order to facilitate testing and prevent code duplication, it is sometimes necessary to redefine a function of a module.
;;For example, analyzingmceval.scm loads mceval.scm and wants to re-implement its eval function.So a hack was used
;;See https://stackoverflow.com/questions/10789160/how-do-i-undefine-in-dr-racket
(define-for-syntax (make-current-name stx id)
  (datum->syntax 
   stx (string->symbol
        (format "current-~a" (syntax-e id)))))

(define-syntax (redefine stx)
  (syntax-case stx ()
    [(_ (name arg ...) body ...)
     (with-syntax ([current-name (make-current-name stx #'name)])
       #'(current-name (lambda (arg ...) body ...)))]))

(define-syntax (redefineable stx)
  (syntax-case stx ()
    [(_ name)
     (with-syntax ([current-name (make-current-name stx #'name)])
       #'(begin
           (define current-name (make-parameter (λ x (error 'undefined))))
           (define (name . xs)
             (apply (current-name) xs))))]))


;; P33-1.2.6 Example: Prime number detection, [looking for factors]
(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))


;; P82 - [Nested mapping]
(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (remove item lst)
  (filter (lambda (x) (not (eq? x item)))
          lst))

(define (permutations s)
  (if (null? s)
      (list null)
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))

