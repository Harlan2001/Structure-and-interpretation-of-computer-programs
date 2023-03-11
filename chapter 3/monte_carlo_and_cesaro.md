## monte-carlo、cesaro-test 简述

In the book, [3.1.2](./monte_carlo.scm) uses two functions, monte-carlo and cesaro-test.

### Monte Carlo method

Monte Carlo method, also known as statistical simulation method, generates a large number of random numbers to test the system, and obtains the solution of the problem through probability statistics.

This method was born in the "Manhattan Project" of the United States in the 1940s, which was mainly proposed by Stanislaw Marcin Ulam and John von Neumann.

Ulam's uncle, who often loses money at casinos in Monte Carlo, Monaco.The method is based on probability and is named after Monte Carlo.

### Cesaro

Ernesto Cesaro was an Italian mathematician.cesaro-test The implementation of pi is as follows

``` Scheme
(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))
  
(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))
```

cesaro-test uses the mathematical principle of pi: Pick two numbers at random and the probability that they are prime to each other is  (pi^2)/6.

Suppose two numbers are prime to each other.

So they're not all multiples of 2.If they're all multiples of 2, the probability is (1/2) * (1/2), and if they're not all multiples of 2, the probability is [1 - (1/2)^2].

The same way

* They're not all multiples of 3, so the probability is [1 - (1/3)^2].
* They're not all multiples of 5, so the probability is [1 - (1/5)^2].
* They're not all multiples of 7, so the probability is [1 - (1/7)^2].
* ....

Two numbers are mutually prime, they are not both multiples of any prime number, and they are both true.So the probability is equal to

```
P = [1 - (1/2)^2] * [1 - (1/3)^2] * [1 - (1/5)^2] * [1 - (1/7)^2] ....
```

According to Euler product formula, prime multiplication and addition of natural numbers are related.

<img src="euler_product.svg"/>

So the probability of random two Numbers is

```
P = 1 + (1/2)^2 + (1/3)^2 + (1/4)^2 .....
```

This requires the reciprocal sum of all the squares of natural numbers, which is the famous Basel problem.The first person to give the exact value of this equation was also Euler, pi^2 /6.



