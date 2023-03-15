#lang sicp

;;Question a)
;;Output unique answer ((mary moore) (gabrielle hall) (lorna downing) (rosalind parker) (melissa barnacle))
;;That Lorna's father was Colonel Downing

;;Question b)
;;If the constraint (require (eq? mary 'moore)) is removed, and get two answers
;; ((mary moore) (gabrielle hall) (lorna downing) (rosalind parker) (melissa barnacle)) 
;; ((mary hall) (gabrielle moore) (lorna parker) (rosalind downing) (melissa barnacle))
;;Indicating that Lorna's father could be Colonel Downing or Dr.Parker

(#%require "ambeval.scm")

(easy-ambeval 10 '(begin
                    
(define (require p)
  (if (not p) (amb)))

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (a-father-name)
  (amb 'moore 'downing 'hall 'barnacle 'parker))

;;This implementation is faster, but harder to read
(define (yacht-puzzle)
  (let ((mary (a-father-name)))
    (require (eq? mary 'moore))
    (let ((melissa (a-father-name)))
      (require (eq? melissa 'barnacle))
      (let ((gabrielle (a-father-name)))
        (require (not (memq gabrielle (list mary melissa 'barnacle))))
        (let ((lorna (a-father-name)))
          (require (not (memq lorna (list mary melissa gabrielle 'moore))))
          (let ((rosalind (a-father-name)))
            (require (not (memq rosalind (list mary melissa gabrielle lorna 'hall))))
            (require
              (cond
                ;((eq? gabrielle 'moore) (eq? lorna 'parker)) ;; 分支不会成立，已有 (require (eq? mary 'moore))
                ;((eq? gabrielle 'downing) (eq? melissa 'parker)) ;; 分支不会成立，已有 (eq? melissa 'barnacle)
                ((eq? gabrielle 'hall) (eq? rosalind 'parker))
                ((eq? gabrielle 'barnacle) (eq? gabrielle 'parker))
                (else false))
              )
            (list (list 'mary mary)
                  (list 'gabrielle gabrielle)
                  (list 'lorna lorna)
                  (list 'rosalind rosalind)
                  (list 'melissa melissa))))))))

;;This implements brute force search, which is slower but clearer
(define (yacht-puzzle-brush)
  (let ((mary (a-father-name))
        (melissa (a-father-name))
        (gabrielle (a-father-name))
        (lorna (a-father-name))
        (rosalind (a-father-name)))
    
    (require (eq? mary 'moore))
    (require (eq? melissa 'barnacle))
    (require (not (eq? lorna 'moore)))
    (require (not (eq? rosalind 'hall)))
    (require (distinct? (list mary gabrielle lorna rosalind melissa)))
    
    (require
      (cond
        ((eq? gabrielle 'moore) (eq? lorna 'parker))
        ((eq? gabrielle 'downing) (eq? melissa 'parker))
        ((eq? gabrielle 'hall) (eq? rosalind 'parker))
        ((eq? gabrielle 'barnacle) (eq? gabrielle 'parker))
        (else false))
      )
    
    (list (list 'mary mary)
          (list 'gabrielle gabrielle)
          (list 'lorna lorna)
          (list 'rosalind rosalind)
          (list 'melissa melissa))))


(yacht-puzzle)

))
