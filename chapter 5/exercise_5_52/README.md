## exercise 5.52

Compile Scheme code into a sequence of C instructions.

* [`compiler.scm`](./compiler.scm), the modified compiler. Compile scheme into c code.
* [`exercise_5_52.scm`](./exercise_5_52.scm), use the compiler to compile the evaluator in Section 4.1 to generate a Scheme interpreter written in C.

### Run Scheme

使用 Use DrRacket to open `exercise_5_52.scm` and run again.A C code file of [gen-scheme.hpp](./gen-scheme.hpp) is generated.

### C code file

To execute the code in `gen-scheme.hpp`.We include several files

* [scheme.c](./scheme.c), main function entry.
* [gen-scheme.hpp](./gen-scheme.hpp), compile the generated C code.

The runtime support implemented in [exercise 5.51](../exercise_5_51/README.md) is also required

| file                                    | function                 |
|----------------------------------------|-----------------------|
| [scheme_runtime.c](../exercise_5_51/scheme_runtime.c) | The exercise 5.51 file, which implements Scheme runtime, contains a very simple GC |              |
| [eceval_support.c](../exercise_5_51/eceval_support.c) | Exercise 5.51 file, corresponding to [ch5-eceval-support.scm](../ch5-eceval-support.scm)|
| [prime_libs.c](../exercise_5_51/prime_libs.c)         | Practice 5.51 file, written in C, exported to Scheme code to use native functions                    |

### Compiling C code

I have only tested the code on MacOS, with an Xcode project and a Makefile.On MacOS, you can open the Xcode project compilation directly.Or use the command line

```
cd exercise_5_52
make
```

Compile to produce an executable file for `scheme`. Use

```
make clean
```
The.o and executable files generated at compile time will be deleted.

### useage

Tap in

```
./scheme
```

The execution effect is equivalent to [`exercise_5_52.scm`](./exercise_5_52.scm) of the original Scheme code to be compiled.A simple evaluator.
