## exercise 5.51

A simple scheme finder for c. Both performance and error handling are problematic. The following documents are as follows:

| file                                    | function                  |
|----------------------------------------|-----------------------|
| [scheme_runtime.c](./scheme_runtime.c) | When you implement Scheme's runtime, you include a very simple GC |
| [scheme.c](./scheme.c)                 | The main program, driving the evaluation cycle                    |
| [eceval.c](./eceval.c)                 | Implement `eval` and `apply` core functions.Corresponding to [ch5-eceval.scm](../ch5-eceval.scm)|
| [eceval_support.c](./eceval_support.c) | Corresponding to [ch5-eceval-support.scm](../ch5-eceval-support.scm)|
| [syntax.c](./syntax.c)                 | Corresponding to [ch5-syntax.scm](../ch5-syntax.scm)                |
| [prime_libs.c](./prime_libs.c)         | C, a native function that is exported to Scheme code                    |
| [scheme_libs.h](./scheme_libs.h)       | The basic function written by Scheme                                     |

### compile

I have only tested the code on MacOS, with an Xcode project and a Makefile.On MacOS, you can open the Xcode project compilation directly.Or use the command line

```
cd exercise_5_51
make
```

Compile to produce an executable file for `scheme`. use

```
make clean
```
The.o and executable files generated at compile time will be deleted.

### use

The following command explains the evaluation Scheme source code

```
./scheme test_code/huffman.scm
```

If there is no file parameter.Direct tap

```
./scheme
```

It waits for user input and enters the evaluation loop.

### TODO

This simple Scheme evaluator does not yet use `load` and cannot load from one source file to another.That's a pretty big limitation.

