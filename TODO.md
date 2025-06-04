> 2 Integers and Variables

[syntax] x86-program -- format-x86-program

[pass] 040-select-instructions -- fix test by format-x86-program

[pass] 050-assign-homes
[pass] 060-patch-instructions
[pass] 070-prelude-and-conclusion

> 3 Register Allocation
> 4 Booleans and Conditionals
> 5 Loops and Dataflow Analysis
> 6 Tuples and Garbage Collection
> 7 Functions
> 8 Lexically Scoped Functions
> 9 Dynamic Typing
> 10 Gradual Typing
> 11 Generics

# later

var-evaluator -- non-empty env

[syntax] parse -- c-var
[syntax] test -- c-var
c-var-evaluator -- test
improve testing

[syntax] `parse-program` -- handle `env`
int-evaluator -- `evaluate-program` -- handle `env`
