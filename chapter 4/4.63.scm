#lang sicp

(#%require "queryeval.scm")

(initialize-data-base 
  '(
    (son Adam Cain) ;  Adam's son is Cain
    (son Cain Enoch)
    (son Enoch Irad)
    (son Irad Mehujael)
    (son Mehujael Methushael)
    (son Methushael Lamech)
    (wife Lamech Ada)
    (son Ada Jabal)
    (son Ada Jubal)
    
    (rule (grandson ?G ?S)
          (and (son ?G ?F)
               (son ?F ?S)))
    
    (rule (son ?man ?son)
          (and (wife ?man ?woman)
               (son ?woman ?son)))
    ))

(easy-qeval '(grandson Cain ?x))
; (grandson Cain Irad)

(easy-qeval '(son Lamech ?x))
; (son Lamech Jubal)
; (son Lamech Jabal)

(easy-qeval '(grandson Methushael ?x))
; (grandson Methushael Jubal)
; (grandson Methushael Jabal)
