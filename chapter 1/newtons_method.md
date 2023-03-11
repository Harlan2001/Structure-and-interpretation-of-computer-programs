## [Newton method]

### Newton's principle

Find the solution to the equation g(x) = 0.One method is [interval half-method](./half_interval_method.scm)described on page P44 also known as the dichotomy.Another method is Newton's method, also known as the tangent method.。

The basic principle of Newton's method is as follows.Suppose x0 is a guess of the equation `g(x) = 0`. So the point A that corresponds to g of x is (x0, g(x0))，and it goes through A and is tangent to g(x)。The tangent line intersects the X-axis at (x1, 0)。his x1 is a closer guess that `g(x) = 0`.

By the geometric definition of a derivative, the derivative of g of x is the tangent line.So if we go through A, the tangent line to g(x)  is g'(x0)。So the equation of the tangent line is

```
y - g(x0) = g'(x0)(x - x0)
```

At the point where it intersects the X-axis，y = 0，so let's substitute (x1, 0)into this top equation.So you get a better guess.

```
x1 = x0 - g(x0) / g'(x0)
```

And so on

```
x1 = x0 - g(x0) / g'(x0)
x2 = x1 - g(x1) / g'(x1)
x3 = x3 - g(x2) / g'(x2)
.....
```
Until the solutions are pretty close. By definition of fixed point, the solution to g(x) = 0 is

```
f(x) = x - g(x) / g'(x) 
```

the fixed point. In the book, we just use Dg(x)to represent the derivative, which is the same thing as  g'(x)。

### sqrt

In the first chapter, there are several ways to find the square root sqrt.Page P14 [Square root by Newton method](./newton_sqrt.scm). The idea of guessing until you get close enough was the fixed point, but it wasn't explicitly mentioned at the time.

And P15 says, if you have a guess y， then the average  y 和 x / y is a better guess.This is actually `y -> x / y` average damping 。

And the definition of the square root is  `y = sqrt(x)` , so 

```
=> y ^ 2 = x
=> y ^ 2 - x = 0
```

So it's going to be the solution of `f(y) = y ^ 2 - x = 0` .According to Newton's method above, corresponds to the fixed point of the following equation

```
f(y) = y - f(y)/f'(y) = y - (y ^ 2 - x) / (2 * y) = (y + x/y) / 2
```

So.Page P14, sqrt method, is just a specific application of Newton's method.

### Code

``` Scheme
#lang racket

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (let ((tolerance 0.00001))
      (< (abs (- v1 v2)) tolerance)))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))


(define (deriv g)
  (let ((dx 0.00001))
    (lambda (x)
      (/ (- (g (+ x dx)) (g x))
         dx))))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))

(define (square x) (* x x))
(define (cube x) (* x x x))

;;;;;;;;;;;;;;;;;;;;;;;;;;
((deriv cube) 5)  ; 75.00014999664018

(module* test #f
  (require rackunit)
  (define (for-loop n last op)
    (cond ((<= n last)
           (op n)
           (for-loop (+ n 1) last op))))
  
  (define (check-n n)
    (check-= (sqrt n) (expt n (/ 1 2)) 0.0001))
    
  (for-loop 0 100 check-n)
)
```
