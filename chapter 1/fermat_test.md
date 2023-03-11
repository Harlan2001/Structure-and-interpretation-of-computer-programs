## fermat_test

### Congruence operation
 
In mathematical notation, if  $a\bmod n == b\bmod n$ is congruent, it is denoted as

$$a\equiv b\mod n$$

The congruence sign is the equal sign of three horizontal lines.In addition, the mathematical symbol `a mod n` is a whole, indicating that a modulo n (take the remainder), is not written as `mod(a, n)`as a function call.

Congruence has some nice properties.There's the addition principle and the multiplication principle.

$$(a+b)\bmod n = [(a\bmod n)+(b\bmod n)]\bmod n$$

$$ab\bmod n = [(a\bmod n)(b\bmod n)]\bmod n$$

mod operation, can be regarded as the clock circle, beyond the circle will go back to the original place.

mod operations often appear in congruent formulas, which seem very complicated.But as long as a is the equivalent of a mod n, the formula should be natural.

Mods are used to make a turn a few times and then fall back into [0, n) .In this way, the numbers involved in the operation will be in [0, n], and the result will be enclosed in [0, n] and will never go beyond this range.

For example, the property of multiplication, first a as the equivalent 'a mod n', b as the equivalent 'b mod n', and then multiply, multiplied by the result of mod, again fall into [0, n) .

As long as I think of a as `a mod n`,  many operations of congruence are almost the same as ordinary integer operations.
### 快速幂取模

Code `expmod` computes modulo exponentiation operation, in fact, the application of congruent multiplication principle.

When b is odd

$$a^b\bmod n = aa^{b-1}\bmod n= [(a\bmod n)(a^{b-1}\bmod n)]\bmod n$$

When b is even

$$a^b\bmod n = a^{b/2}a^{b/2}\bmod n= (a^{b/2}\bmod n)^{2}\bmod n$$

### Fermat's little theorem

Fermat's little theorem says that when n is prime, a < n, then we have

$$a^{n}\equiv a\mod n$$

We usually change the formula

$$a^{n-1}\equiv 1\mod n$$

---

To prove Fermat's little theorem, we have to prove a conclusion.If n is a prime number, a &lt;n, one, two, three, four, five...n minus 1, times a, and then you take the remainder of n, and it's going to be 1 to n minus 1, but it's going to be in a different order.

For example, n = 5, a = 3.

* 1, 2, 3, 4 (original arrangement)
* 3, 6, 9, 12 (original permutation multiplied by a = 3)
* 3, 1, 4, 2 (take the remainder of 5)

As you can see, the remainder is still between 1 and 4, and it's not repeated, it's just in a different order.

Proof by contradiction.And if that doesn't work, there's going to be two numbers, i and j, so

$$i * a \equiv j * a\mod n$$

Let's say i > j， if I move this up a little bit, we get

$$(i - j) * a \equiv 0\mod n$$

In other words, i minus j times a goes into n.If n is prime, then one of (i - j) or a must contain the factor n.But (i - j) and (a) are both smaller than n, so obviously you can't have factor n.So the conclusion proves it.

---

Because multiplying by a and mod n, it's just a rearrangement of 1 to n-1, and the numbers don't repeat.So we know

$$(1 * 2 * 3 .... n - 1) = (a\bmod n)(2a\bmod n)(3a\bmod n) ... ((n-1)a\bmod n)$$

By applying the multiplication principle of congruence and using the notation of congruence, the above formula can be denoted as

$$(1 * 2 * 3 .... n - 1) \equiv a * 2a * 3a * ... (n-1)a\mod n$$

Divide the above equation by $(1 * 2 * 3 .... n - 1)$，Fermat's little theorem is proved

$$a^{n-1}\equiv 1\mod n$$

### code

``` Scheme
#lang racket

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))  

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (for-each (lambda (num)
             (check-true (fast-prime? num 100)))
           '(2 3 5 7 11 13 17 19 23))
  (for-each (lambda (num)
             (check-false (fast-prime? num 100)))
           '(36 25 9 16 4))
)
```
