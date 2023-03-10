#lang sicp

;It's exactly one-dimensional table code, so if you have multiple key-1s, key-2s, key-3s, you're going to
;Change list key-1 key-2 key-3 to list key-3.Although this way is a bit tricky, but simple and general, also fully meet the requirements of the question.
;But that's probably not what the author intended.The author may have wanted to examine recursion, which can be solved in [Exercise 3.25 - Solution b].

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        false)))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table 
                  (cons (cons key value) (cdr table))))))

(define (make-table)
  (list '*table*))

;;;;;;;;;;;;;;;;;;;;;;;
(define t (make-table))
(insert! 'a 1 t)
(insert! 'b 2 t)
(insert! (list 'a 'b 'c) 3 t)

(lookup 'a t)
(lookup 'b t)
(lookup (list 'a 'b 'c) t)

(insert! (list 'a 'b 'c) 10 t)
(lookup (list 'a 'b 'c) t)

;Insert three keys
(insert! (list 'key1 'key2 'key3) 123 t)
(lookup (list 'key1 'key2 'key3) t)

;Modify three keys
(insert! (list 'key1 'key2 'key3) 'hello-world t)  
(lookup (list 'key1 'key2 'key3) t)
