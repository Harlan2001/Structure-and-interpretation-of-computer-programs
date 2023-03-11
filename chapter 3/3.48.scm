#lang sicp

(#%require "serializer.scm")

;exchange needs to get the serialized queue of two accounts.Let's say queue A and queue B.
;The obtaining A and B queues are divided into two steps that can be interrupted. If A process P1 obtains A, it tries to obtain B.
;P2 gets B and tries to get A.So P1 and P2 each acquire a queue and wait forever for the other process to release the other queue.
;The deadlock occurs mainly because of the order in which the queues are acquired. The order in which the queues are acquired is different for P1 and P2.If the account number is mandatory, P1 and P2
;If the queues are acquired in the order A and B, deadlock will not occur.

(define (make-account-and-serializer id balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
          balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'id) id)
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))

(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    (if (< (account1 'id) (account2 'id))
        ((serializer1 (serializer2 exchange)) account1 account2)
        ((serializer2 (serializer1 exchange)) account1 account2))))
