#lang racket

;; P126 - [练习 2.74]

; I don't understand this problem very clearly.
; The problem, as I understand it, is looking at data distribution.
; In the implementation of get-record, get-salary, and find-employee-record, the functions are assigned to different companies for implementation according to the company name.
;This regardless of the internal subsidiary, personnel file format is specific, once the implementation of the standard function interface.
;The unified data format is available to the head office.
;If a new company is acquired, the new company will also need to implement these standard data interfaces for installation.The head office's query system implementation does not need to change.
;In the test code, companyA and companyB are installed.It's just that the interface has no implementation, it just prints some output to know that the function was called correctly.

;;;;;;;;;;
;; put get a simple implementation
(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) #f))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (get-record employee subcompany)
  ((get 'get-record subcompany) employee))

(define (get-salary employee subcompany)
  ((get 'get-salary subcompany) employee))

(define (find-employee-record employee subcompanies)
  (if (null? subcompanies)
      #f 
      (let ((ret ((get 'find-employee-record (car subcompanies)) employee)))
        (if ret
            ret 
            (find-employee-record employee (cdr subcompanies))))))
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-companyA-package)
  (define (get-record employee)
    (display "call companyA get-record")
    (newline)
    (list employee 1985))
  
  (define (get-salary employee)
    (display "call companyA get-salary")
    (newline)
    (list employee 20000))
  
  (define (find-employee-record employee)
    (display "call companyA find-employee-record")
    (newline)
    (if (eq? employee 'Tom)
        (list employee 1985)
        #f))
  
  (put 'get-record 'companyA get-record)
  (put 'get-salary 'companyA get-salary)
  (put 'find-employee-record 'companyA find-employee-record)
  'done)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-companyB-package)
  (define (get-record employee)
    (display "call companyB get-record")
    (newline)
    (list employee 1985))
  
  (define (get-salary employee)
    (display "call companyB get-salary")
    (newline)
    (list employee 20000))
  
  (define (find-employee-record employee)
    (display "call companyB find-employee-record")
    (newline)
    (if (eq? employee 'John)
        (list employee 1985)
        #f))
  
  (put 'get-record 'companyB get-record)
  (put 'get-salary 'companyB get-salary)
  (put 'find-employee-record 'companyB find-employee-record)
  'done)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(install-companyA-package)
(install-companyB-package)

(get-record 'Tom 'companyA)
(get-salary 'Tom 'companyA)

(get-record 'John 'companyB)
(get-salary 'John 'companyB)

(find-employee-record 'Tom '(companyB companyA))

; call companyA get-record
; '(Tom 1985)
; call companyA get-salary
; '(Tom 20000)
; call companyB get-record
; '(John 1985)
; call companyB get-salary
; '(John 20000)
; call companyB find-employee-record
; call companyA find-employee-record
; '(Tom 1985)
