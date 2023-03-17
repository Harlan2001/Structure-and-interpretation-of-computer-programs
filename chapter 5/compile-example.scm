#lang sicp

(#%require "ch5-compiler.scm")

(compile
  '(define (factorial n)
     (if (= n 1)
         1
         (* (factorial (- n 1)) n)))
  'val
  'next)
