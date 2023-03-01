(define (f g)
  (g 2))
;When executing the expression (f f) in DrRacket, an error occurs:
"application: not a procedure;
 expected a procedure that can be applied to arguments
  given: 2
  arguments...:"
  
  
 ;When executing (f f) in Mit-Scheme, the same error occurs, but the error description is different.
 "The object 2 is not applicable."
  
 ;Expand the calculation process of (f f) to be
(f f)
(f 2)
(2 2)	; Error, The object 2 is not applicable.
