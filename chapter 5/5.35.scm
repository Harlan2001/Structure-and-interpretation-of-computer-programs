#lang sicp

(#%require "ch5-compiler.scm")

(compile
  '(define (f x)
     (+ x (g (+ x 2)))
     )
  'val
  'next)
