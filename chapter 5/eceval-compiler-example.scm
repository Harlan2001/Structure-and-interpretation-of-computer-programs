#lang sicp

(#%require "ch5-eceval-compiler.scm")

(compile-and-go
  '(begin
     (define (factorial n)
       (if (= n 1)
           1
           (* (factorial (- n 1)) n)))
     (factorial 5)
     ))
