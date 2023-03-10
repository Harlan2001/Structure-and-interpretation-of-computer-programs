#lang sicp

;Recursive solution, using the two-dimensional table idea.When inserting (list 'key1 'key2 'key3) value, a subtable may be created recursively.
;But this recursive solution is flawed.

;For example, the following code will cause the program to crash
; (define t (make-table))
; (insert! 'a 1000 t)  
; (insert! (list 'a 'b) 1000 t)  
;The key = 'a 'is inserted first.When keys = (list 'a 'b) is inserted, because the 'a record already exists.The program will mistake the 'a 'record for
;Subtable, and then look for the 'b record.But in fact key = 'a corresponds to a record of 1000, not a subtable.

;And this piece of code
; (define t (make-table))
; (insert! (list 'a 'b) 1000 t)  
; (insert! 'a 1000 t)  
;The record with keys = (list 'a 'b) is mistakenly flushed out.Because the second statement changes the record of key = 'a directly to 1000, the original subtable is lost.

;Recursively create a subtable, will appear the above crash or flush records, the root cause is the number of keys is not fixed.So each layer could be a final record, or a subtable,
;It would be cumbersome, if not impossible, to deal with them uniformly.
;This solution, although you can pass in a different number of keys.However, it is better to have the same number of keys in the same table. It is not suitable to use different numbers of keys in the same table.
;[Exercise 3.25 - Solution a] is simpler and more versatile.

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup key-list table)
  (if (list? key-list)
      (let ((record-or-subtable (assoc (car key-list) (cdr table))))
        (if record-or-subtable
            (if (null? (cdr key-list))  ;Judgment records or subtables.No extra keys, records.There are extra keys, which are tables.
                (cdr record-or-subtable)
                (lookup (cdr key-list) record-or-subtable))
            false))
      (lookup (list key-list) table)))  ;Converts a single key to a list

(define (insert! key-list value table)
  (define (insert-record! record table)
    (set-cdr! table (cons record (cdr table))))
  
  (if (list? key-list)
      (let ((record-or-subtable (assoc (car key-list) (cdr table))))
        (if (null? (cdr key-list))      ;Judgment records or subtables.No extra keys, records.There are extra keys, which are tables.
            (let ((record record-or-subtable))
              (if record
                  (set-cdr! record value)
                  (insert-record! (cons (car key-list) value) table)))
            
            (let ((subtable record-or-subtable))
              (if subtable
                  (insert! (cdr key-list) value subtable)
                  (let ((new-subtable (list (car key-list))))
                    (insert! (cdr key-list) value new-subtable)
                    (insert-record! new-subtable table))))))
      (insert! (list key-list) value table))) ;Converts a single key to a list

(define (make-table)
  (list '*table*))

;;;;;;;;;;;;;;;;;;;;;;;
(define t (make-table))
(insert! 'a 1000 t)  
(lookup 'a t)

;Insert three keys
(insert! (list 'key1 'key2 'key3) 123 t)
(lookup (list 'key1 'key2 'key3) t)

;Modify three keys
(insert! (list 'key1 'key2 'key3) 'hello-world t)  
(lookup (list 'key1 'key2 'key3) t)
