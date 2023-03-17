#lang racket

(provide redefineable redefine)

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
