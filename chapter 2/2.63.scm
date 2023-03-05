#lang racket

(define (entry tree)
  (car tree))

(define (left-branch tree)
  (cadr tree))

(define (right-branch tree)
  (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (tree->list-1 tree)
  (if (null? tree)
      null 
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree) result-list)))))
  (copy-to-list tree null))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define a (make-tree 7
                     (make-tree 3
                                (make-tree 1 null null)
                                (make-tree 5 null null))
                     (make-tree 9
                                null 
                                (make-tree 11 null null))))
(define b (make-tree 3
                     (make-tree 1 null null)
                     (make-tree 7
                                (make-tree 5 null null)
                                (make-tree 9
                                           null
                                           (make-tree 11 null null)))))

(define c (make-tree 5
                     (make-tree 3
                                (make-tree 1 null null)
                                null)
                     (make-tree 9
                                (make-tree 7  null null)
                                (make-tree 11 null null))))

(tree->list-1 a) ; '(1 3 5 7 9 11)
(tree->list-2 a) ; '(1 3 5 7 9 11)

(tree->list-1 b) ; '(1 3 5 7 9 11)
(tree->list-2 b) ; '(1 3 5 7 9 11)

(tree->list-1 c) ; '(1 3 5 7 9 11)
(tree->list-2 c) ; '(1 3 5 7 9 11)


a)
;The recursive implementation of tree->list-1 uses append and cons to concatenate lists.The order of the final list is left-branch, entry, right-branch.
;Similarly, tree->list-2 (copy-to-list tree result-list) aims to place the table collected from the tree before the result-list.
;We also use cons inside.The order of the final list is also left-branch, entry, right-branch.
;So tree->list-1 and tree->list-2 are implemented in the same order.Collect left-branch data first, then entry data, and then right-branch data.
;In the binary tree representation, by definition, the data for left-branch is smaller than that for entry, and the data for right-branch is larger than that for entry.
;So the binary tree on page P106, no matter what its specific structure is, the list of collected data must be sorted from smallest to largest.
;The conclusion is that tree->list-1 and tree->list-2 have the same result for all trees.Further, 
;the trees of different structures in Figure 2-16 all have the same result and are listed in descending order as (1, 3, 5, 7, 9, 11).
b)
;Let's say the number of nodes in the tree is N.
;tree->list-1 calls append and cons once for each node traversed. append and cons are called N times in total.A single cons has a time complexity of O(1), 
;while append grows as the list length increases, so it appears that tree->list-1 has a time complexity of O(N ^ 2).
;But notice that every time append is the left and right subtree, and the balanced tree doesn't have linear growth of the left and right subtrees, 
;it gets cut in half every time.So tree->list-1 is order N logN.
;tree->list-2 traverses a node, calls cons once, and calls cons N times in total.cons' time complexity is O(1), so tree->list-2's time complexity is O(N).
;The conclusion is that the time complexity of tree->list-1 is O(N * logN) and the time complexity of tree->list-2 is O(N).tree->list-2 The execution time increases slowly.
