#lang racket

(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons null elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts) right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))
            
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(list->tree '(1 3 5 7 9 11)) ;; '(5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))

a)
;The partial tree input is a sorted list.In its implementation, the data is divided into the left and right sides, and the middle value is taken out.Recursively call partial-tree to turn the left side into a balanced binary tree, turn the right side into a balanced binary tree, and then create a new tree node with an intermediate value.
;The input is a sorted list, and the middle value must be larger than the left and smaller than the right.And partition, let the left and right data as much as possible equal (at most 1 difference), so the whole recursive process, will produce a balanced binary tree.
;(list->tree '(1 3 5 7 9 11)) will produce the tree like this:
         5 
        / \
       /   \
      /     \
     /       \
    1         9
   / \       / \
  /   \     /   \
null   3   7    11

b)
;Let's say the list is of length N.list-tree calls partial-tree, splitting the number of nodes into left and right halves each time, and each time you need to call partial-tree recursively, handling the left and right halves separately.
;So the algorithm complexity is O(N).Each list element is actually called make-tree once.
